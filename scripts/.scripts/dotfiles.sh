#!/bin/sh

function dots(){
    message=$@
    cd ~/.dotfiles/
    git add .
    git commit -m "$message"
    git push
    cd ~
#    clear
}

