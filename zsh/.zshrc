function push() {
    git status
    git add .
    echo "New commit message set to: $1\n"
    git commit -m "$1"
    git push
}

function thanos(){
    kill -9 $(lsof -t -i:$1)
}
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$ZDOTDIR/ohmyzsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

plugins=(git tmux git-open zsh-autosuggestions zsh-vi-mode F-Sy-H)

source $ZSH/oh-my-zsh.sh

alias vim="nvim"
alias ls="exa"

# alias pnpm 
alias p="pnpm"
alias pi="pnpm install"
alias pd="pnpm run dev"
alias pb="pnpm run build"
alias hs="atuin search"
alias push=push
alias thanos=thanos

export EDITOR="nvim"


# Set Spaceship ZSH as a prompt

export FZF_DEFAULT_COMMAND='rg --files'
export BAT_THEME='base16'
eval "$(zoxide init --cmd j zsh)"
export ATUIN_NOBIND="true"
eval "$(atuin init zsh)"

bindkey '^r' _atuin_search
bindkey '^[[A' _atuin_search
bindkey '^[OA' _atuin_search

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
