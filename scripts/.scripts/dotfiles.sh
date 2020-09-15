#!/bin/sh

function dots(){
    dir=$(pwd)
    message=$@
    if [ -z "$message" ]; then
        message="default commit"
    fi
    cd ~/.dotfiles/
    git add .
    git commit -m "$message"
    git push
    sleep 1
    cd $path
    clear
}

