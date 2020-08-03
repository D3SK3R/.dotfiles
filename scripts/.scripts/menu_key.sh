#!/bin/sh

menu="menu"
if [ "$menu" = "menu" ]; then
    xmodmap -e 'keycode 135 = slash'
    mpg123 -q /home/d3sk3r/.scripts/ding-notif.mp3
fi
