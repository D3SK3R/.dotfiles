#!/bin/sh

function dots(){
    cd ~/.dotfiles/
    git add .
    git commit -m "$@"
    git push
    cd ~
#    clear
}

