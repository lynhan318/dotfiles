#!/bin/sh 
dotfilePath=$(pwd)

ln -sfn $dotfilePath/alacritty $HOME/.config
ln -sfn $dotfilePath/nvim $HOME/.config
ln -sfn $dotfilePath/rofi $HOME/.config
#ln -sfn $dotfilePath/polybar $HOME/.config

ln -sfn $dotfilePath/.tmux.conf $HOME/.tmux.conf
ln -sfn $dotfilePath/.zshrc $HOME/.zshrc
#ln -sfn $dotfilePath/.i3 $HOME/.i3
