#!/bin/bash

engine=$(ibus engine)

ENGLISH="xkb:us::eng"
VIETNAM="Bamboo"
if [[ "$engine" == "$VIETNAM" ]]; then
  echo "VI"
else
  echo "EN"
fi
