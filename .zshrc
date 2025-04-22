source ~/.bashrc
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export EDITOR="nvim"
export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export ANDROID_HOME=$ANDROID_SDK_ROOT
export PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$PATH
export PATH=$ANDROID_HOME/platform-tools:$PATH
export PATH=$ANDROID_HOME/emulator:$PATH

function v() {
    nvim $(fzf)
}

function push() {
    pnpm fix
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
plugins=(git git-open tmux zsh-autosuggestions zsh-vi-mode F-Sy-H zsh-history-substring-search)
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

# bun completions
[ -s "/home/kevin/.bun/_bun" ] && source "/home/kevin/.bun/_bun"
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down



# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/kevin/.lmstudio/bin"
