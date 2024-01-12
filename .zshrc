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
alias hs="atuin search"
alias push=push
alias thanos=thanos
alias ariga-dev="kubectl config use-context arn:aws:eks:us-east-1:352056394569:cluster/nebula-dev && k9s -n default"
alias ariga-prod="kubectl config use-context arn:aws:eks:us-east-1:844442413632:cluster/nebula-prod && k9s -n default"

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

# bun completions
[ -s "/Users/nhanly/.bun/_bun" ] && source "/Users/nhanly/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
