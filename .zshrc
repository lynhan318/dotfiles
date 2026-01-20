# Add deno completions to search path
if [[ ":$FPATH:" != *":/home/kevin/.zsh/completions:"* ]]; then export FPATH="/home/kevin/.zsh/completions:$FPATH"; fi
source ~/.bash_profile
export EDITOR="nvim"

function v() {
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
plugins=(git git-open tmux zsh-autosuggestions zsh-vi-mode F-Sy-H)
source $ZSH/oh-my-zsh.sh

alias vim="nvim"
alias ls="eza"
alias p="pnpm"
alias pi="pnpm install"
alias pd="pnpm run dev"
alias pb="pnpm run build"
alias hs="atuin search"
alias push=push
alias v=v
alias thanos=thanos
alias lg="lazygit"

# Set Spaceship ZSH as a prompt

export FZF_DEFAULT_COMMAND='rg --files'
export BAT_THEME='base16'
export GPG_TTY=$(tty)

eval "$(zoxide init --cmd j zsh)"
eval "$(starship init zsh)"
eval "$(atuin init zsh)"


source <(fzf --zsh)
HISTFIL=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
autoload -Uz compinit
compinit
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"


# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export ANDROID_HOME="/home/kevin/Android/Sdk"
export PATH="$ANDROID_HOME:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# bun completions
[ -s "/home/kevin/.bun/_bun" ] && source "/home/kevin/.bun/_bun"
. "/home/kevin/.deno/env"
