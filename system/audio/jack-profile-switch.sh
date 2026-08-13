#!/bin/bash
# Follow the 3.5 mm jack with the card profile.
#
# This laptop's audio is a SOF card driven by ALSA UCM (sof-hda-dsp, ALC287).
# In UCM, Speaker and Headphones are not two ports on one sink — they both
# declare `PlaybackPCM "hw:${CardId}"`, i.e. the same PCM, so PipeWire cannot
# expose them at once and splits them into mutually exclusive card profiles:
#
#   HiFi (HDMI1, HDMI2, HDMI3, Headphones, Mic1, Mic2)   priority 10300
#   HiFi (HDMI1, HDMI2, HDMI3, Mic1, Mic2, Speaker)      priority 10200
#
# Moving between speaker and headphones is therefore a *profile* switch, and
# nothing in the stack performs it:
#
#   - The kernel tracks the jack correctly ('Headphone Jack' flips on/off) and
#     PipeWire reflects it on the port ([Out] Headphones -> available / not
#     available). That part works.
#   - But profile priority and availability are static. Measured on both sides
#     of an unplug, the two profiles stay at 10300/10200 and both stay
#     `available: yes` whether or not anything is in the jack.
#   - WirePlumber's device/find-best-profile.lua picks the highest-priority
#     profile whose availability is not "no". With the numbers above that is
#     always Headphones, so leaving profile selection to WirePlumber pins the
#     machine to a dead output the moment the jack is empty.
#
# So the port availability is the only signal that actually moves, and this
# script is what turns it into a profile switch.
#
# Transitions, not state: the profile is set at startup and then only when the
# jack changes. Choosing an output by hand afterwards therefore sticks until
# the next plug or unplug, instead of being immediately overridden.

set -u

CARD_INDEX=$(awk '/sof-hda-dsp/ {print $1; exit}' /proc/asound/cards)
if [ -z "${CARD_INDEX:-}" ]; then
    echo "jack-profile-switch: no sof-hda-dsp card found" >&2
    exit 1
fi

# Resolve the jack control by name; its numid is not stable across kernels.
JACK_NUMID=$(amixer -c "$CARD_INDEX" controls 2>/dev/null \
    | sed -n "s/^\(numid=[0-9]*\),iface=CARD,name='Headphone Jack'$/\1/p")
if [ -z "$JACK_NUMID" ]; then
    echo "jack-profile-switch: card $CARD_INDEX has no 'Headphone Jack' control" >&2
    exit 1
fi

CARD_PA=$(pactl list cards short | awk '/skl_hda_dsp_generic/ {print $2; exit}')
if [ -z "${CARD_PA:-}" ]; then
    echo "jack-profile-switch: card not present in PipeWire" >&2
    exit 1
fi

# The block of `pactl list cards` belonging to this card, so a second card
# (a USB headset, a Bluetooth sink) can never be parsed by mistake.
card_block() {
    pactl list cards | awk -v RS='Card #' -v c="Name: $CARD_PA" 'index($0, c)'
}

# Profile names are generated from the UCM device list, so they are matched by
# the device they contain rather than spelled out literally.
profile_with() {
    card_block \
        | sed -n '/^\tProfiles:/,/^\tActive Profile:/p' \
        | sed -n 's/^\t\t\([^:]*\):.*/\1/p' \
        | grep -m1 -- "$1"
}

active_profile() {
    card_block | sed -n 's/^\tActive Profile: //p'
}

jack_plugged() {
    amixer -c "$CARD_INDEX" cget "$JACK_NUMID" 2>/dev/null \
        | grep -m1 ': values' | grep -q 'on'
}

apply() {
    local want
    if jack_plugged; then
        want=$(profile_with 'Headphones')
    else
        want=$(profile_with 'Speaker')
    fi
    [ -z "$want" ] && return 0
    [ "$(active_profile)" = "$want" ] && return 0
    pactl set-card-profile "$CARD_PA" "$want"
}

apply
LAST=$(jack_plugged && echo on || echo off)

# alsactl emits an event whenever a control on the card changes, so the jack is
# followed without polling. Anything else on the card also wakes us, which the
# state comparison below filters out.
alsactl monitor "hw:$CARD_INDEX" 2>/dev/null | while read -r _; do
    NOW=$(jack_plugged && echo on || echo off)
    [ "$NOW" = "$LAST" ] && continue
    LAST=$NOW
    apply
done
