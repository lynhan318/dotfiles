export ZSH="$HOME/.oh-my-zsh"

# Path to your oh-my-zsh installation.
plugins=(git tmux zsh-syntax-highlighting zsh-autosuggestions autojump zsh-vi-mode)

# ZSH_THEME="robbyrussell"

source $ZSH/oh-my-zsh.sh

alias vim="nvim"
alias ls="exa"

export EDITOR="nvim"

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

eval "$(starship init zsh)"

# Set Spaceship ZSH as a prompt
