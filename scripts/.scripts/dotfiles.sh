#!/bin/sh

message=$@
if [ -z "$message" ]; then
    message="default commit"
fi
cd ~/.dotfiles/
git add .
git commit -m "$message"
git push git@github.com:D3SK3R/.dotfiles
cd ~
clear

