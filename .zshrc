# Add deno completions to search path
if [[ ":$FPATH:" != *":/Users/kevin/.zsh/completions:"* ]]; then export FPATH="/Users/kevin/.zsh/completions:$FPATH"; fi
export ELECTRON_OZONE_PLATFORM_HINT=auto
export QT_QPA_PLATFORM=wayland
export XDG_SESSION_DESKTOP=hyprland
export XDG_CURRENT_DESKTOP=hyprland
export GDK_BACKEND="wayland,x11"
export MOZ_ENABLE_WAYLAND=1


function sf() {
    nvim $(fzf)
}

function push() {
    git status
    git add .
    echo "New commit message set to: $1\n"
    git commit -m "$1"
    git push origin -u $(git rev-parse --abbrev-ref HEAD)
}

function thanos(){
    kill -9 $(lsof -t -i:$1)
}

export ZSH="$HOME/.oh-my-zsh"

# Path to your oh-my-zsh installation.
plugins=(git git-open tmux zsh-autosuggestions zsh-vi-mode F-Sy-H)

# ZSH_THEME="spaceship"

source $ZSH/oh-my-zsh.sh

alias vim="nvim"
alias ls="lsd"

# alias pnpm 
alias p="pnpm"
alias pi="pnpm install"
alias pd="pnpm run dev"
alias pb="pnpm run build"
alias hs="atuin search"
alias push=push
alias thanos=thanos
alias lg="lazygit"
alias o="lazygit"

export EDITOR="nvim"


# Set Spaceship ZSH as a prompt

export FZF_DEFAULT_COMMAND='rg --files'
export BAT_THEME='base16'

export PATH="$DENO_INSTALL/bin:$PATH"
export GPG_TTY=$(tty)

eval "$(zoxide init --cmd j zsh)"
eval "$(starship init zsh)"
eval "$(atuin init zsh)"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="/Applications/Xcode.app/Contents/Developer/usr/bin/simctl:$PATH"


source <(fzf --zsh)
HISTFIL=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# bun completions
[ -s "/Users/kevin/.bun/_bun" ] && source "/Users/kevin/.bun/_bun"
. "/Users/kevin/.deno/env"
# Initialize zsh completions (added by deno install script)
autoload -Uz compinit
compinit