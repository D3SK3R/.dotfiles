#!/bin/sh

if xrandr | grep -ow "DP1 connected"; then
    #sleep 0.5
    i3 workspace 4
    i3 workspace 9
fi

i3 workspace 9

if [ $(playerctl status) = "Playing" ]; then
    playerctl stop;playerctl previous
fi
mpc -p 1100 seek 0 && mpc -p 1100 pause

sleep 0.2

urxvt -e gotop -aps &
#urxvt &
sleep 0.2
urxvt -e ranger &
#sleep 0.8

