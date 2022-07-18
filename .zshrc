export ZSH="$HOME/.oh-my-zsh"

# Path to your oh-my-zsh installation.
plugins=(git tmux zsh-syntax-highlighting zsh-autosuggestions autojump zsh-vi-mode)

# ZSH_THEME="robbyrussell"

source $ZSH/oh-my-zsh.sh

alias vim="nvim"
alias ls="exa"

export EDITOR="nvim"

eval "$(starship init zsh)"

# Set Spaceship ZSH as a prompt

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
