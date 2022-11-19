function push() {
    git status
    git add .
    echo "New commit message set to: $1\n"
    git commit -m "$1"
    git push
}

export ZSH="$HOME/.oh-my-zsh"

# Path to your oh-my-zsh installation.
plugins=(git git-open tmux zsh-autosuggestions zsh-vi-mode F-Sy-H)

# ZSH_THEME="spaceship"

source $ZSH/oh-my-zsh.sh

alias vim="nvim"
alias ls="exa"
alias serve="simple-http-server"

# alias pnpm 
alias p="pnpm"
alias pi="pnpm install"
alias pd="pnpm run dev"
alias pb="pnpm run build"
alias push=push

export EDITOR="nvim"


# Set Spaceship ZSH as a prompt

export FZF_DEFAULT_COMMAND='rg --files'
export BAT_THEME='base16'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export DENO_INSTALL="/Users/kevin/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
export GPG_TTY=$(tty)


# pnpm
export PNPM_HOME="/Users/kevin/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end
# bun completions
[ -s "/Users/kevin/.bun/_bun" ] && source "/Users/kevin/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
eval "$(zoxide init --cmd j zsh)"
eval "$(starship init zsh)"

