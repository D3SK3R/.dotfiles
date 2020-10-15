#!/bin/sh

fudp=$(ps aux | grep fudp | tail -n+2)

if [ "$fudp" ]; then
    dunstify -t 1000 'fudp' 'stopping lag' -p 5 -r 5
    killall fudp
else
    dunstify -t 1000 'fudp' 'lagging' -p 5 -r 5
    fudp 27.27.27.27 &
fi
