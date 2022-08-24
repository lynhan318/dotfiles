export ZSH="$HOME/.oh-my-zsh"

# Path to your oh-my-zsh installation.
plugins=(git tmux zsh-syntax-highlighting zsh-autosuggestions autojump zsh-vi-mode)

# ZSH_THEME="robbyrussell"

source $ZSH/oh-my-zsh.sh

alias vim="nvim"
alias ls="exa"
alias serve="simple-http-server"
export EDITOR="nvim"

eval "$(starship init zsh)"

# Set Spaceship ZSH as a prompt

export FZF_DEFAULT_COMMAND='rg --files'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [ -r ~/.zshrc ]; then echo 'export GPG_TTY=$(tty)' >> ~/.zshrc; \
  else echo 'export GPG_TTY=$(tty)' >> ~/.zprofile; fi
export GPG_TTY=$(tty)
export GPG_TTY=$(tty)
export GPG_TTY=$(tty)
export GPG_TTY=$(tty)
export GPG_TTY=$(tty)
export GPG_TTY=$(tty)
export GPG_TTY=$(tty)
export GPG_TTY=$(tty)
export GPG_TTY=$(tty)
export GPG_TTY=$(tty)
export GPG_TTY=$(tty)
export GPG_TTY=$(tty)
export GPG_TTY=$(tty)
