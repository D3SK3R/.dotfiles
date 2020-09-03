#!/bin/sh

# script to move everything I download from telegram (which is always 2D pics) to my 2D folder

while true; do
    while [ $(ps aux | grep -e "\<telegram\>" | wc -l) -lt '2' ]; do
        echo "telegram is closed"
        telegram="closed"
        if [ -d "/home/d3sk3r/Telegram Desktop" ]; then
            rm -rf /home/d3sk3r/Telegram\ Desktop
        fi
        sleep 1
    done
    
    if [ -d "/home/d3sk3r/Telegram Desktop" ]; then
        echo "telegram is open"
        mv /home/d3sk3r/Telegram\ Desktop/* /home/d3sk3r/MEGA/D3SK3R/Other/Paste/Girls/2D/
    fi
    sleep 1
done
