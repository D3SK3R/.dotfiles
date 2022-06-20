#!/bin/sh

fudp=$(ps aux | grep fudp | tail -n+2)

if [ "$fudp" ]; then
    dunstify -t 2500 'fudp' 'stopping lag' -r 5
    killall fudp
else
    dunstify -t 2500 'fudp' 'lagging' -r 5
    fudp 27.27.27.27 &
fi
