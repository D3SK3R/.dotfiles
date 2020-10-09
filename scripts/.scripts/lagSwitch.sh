#!/bin/sh

fudp=$(ps aux | grep fudp | tail -n+2)

if [ "$fudp" ]; then
    dunstify 'fudp' 'stopping lag' -p 5 -r 5
    killall fudp
else
    dunstify 'fudp' 'lagging' -p 5 -r 5
    ~/fudp/fudp 27.27.27.27
fi
