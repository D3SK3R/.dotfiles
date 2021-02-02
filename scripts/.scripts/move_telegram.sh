#!/bin/sh

# script to move everything I download from telegram (which is always 2D pics) to my 2D folder

while true; do
    while [ $(ps aux | grep -e "\<telegram\>" | wc -l) -lt '2' ]; do
        echo "telegram is closed"
        telegram="closed"
        if [ -d "~/Telegram Desktop" ]; then
            rm -rf ~/Telegram\ Desktop
        fi
        sleep 1
    done
    
    if [ -d "~/Telegram Desktop" ]; then
        echo "telegram is open"
        mv ~/Telegram\ Desktop/* ~/MEGA/D3SK3R/Other/Paste/Girls/2D/
    fi
    sleep 1
done
