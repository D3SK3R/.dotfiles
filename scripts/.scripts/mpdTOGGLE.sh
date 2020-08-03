#!/bin/sh

mpc -p 1100 toggle

playing=$(mpc -p 1100 | head -n 1)

state=$(mpc -p 1100 | grep -e "\[.*\]" | cut -d' ' -f1)

if [ $state == "[playing]" ]; then
    dunstify -t 2000 " Playing..." "$playing" -p 1100 -r 1100
else
    dunstify -t 2000 " Pausing..." "$playing" -p 1100 -r 1100
fi
