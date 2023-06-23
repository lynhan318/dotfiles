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

export ZSH="$HOME/.config/zsh/ohmyzsh"

# Path to your oh-my-zsh installation.
plugins=(git git-open zsh-autosuggestions zsh-vi-mode F-Sy-H)

# ZSH_THEME="spaceship"

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
export GPG_TTY=$(tty)

eval "$(zoxide init --cmd j zsh)"
eval "$(starship init zsh)"
eval "$(atuin init zsh)"
eval "$(atuin init zsh)"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
