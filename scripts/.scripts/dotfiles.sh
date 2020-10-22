#!/bin/sh

# As a script to be run
message=$@
if [ -z "$message" ]; then
    message="default commit"
fi
cd ~/.dotfiles/
git add .
git commit -m "$message"
git push
cd ~
clear


# As a function to be sourced in .bashrc/.zshrc
#function dots(){
#    message=$@
#    if [ -z "$message" ]; then
#        message="default commit"
#    fi
#    cd ~/.dotfiles/
#    git add .
#    git commit -m "$message"
#    git push
#    cd ~
#    clear
#}

