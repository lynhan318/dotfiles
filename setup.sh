#!/bin/sh 
dotfilePath=$(pwd)

ln -sfn $dotfilePath/{alacritty,nvim} $HOME/.config
ln -sfn $dotfilePath/.tmux.conf $HOME/.tmux.conf
ln -sfn $dotfilePath/.zshrc $HOME/.zshrc

