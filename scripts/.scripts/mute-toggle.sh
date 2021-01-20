#!/bin/sh

# Check if my audio input (pulseaudio) is muted or not, and send a notification

mute=$(pactl list sources | grep Mute | sed -n 2p | cut -d : -f2 | sed 's/ //g')
iconOn="/usr/share/icons/Papirus-Dark/16x16/panel/mic-ready.svg"
iconOff="/usr/share/icons/Papirus-Dark/16x16/panel/mic-volume-muted.svg"

if [[ $mute = 'no' ]]; then
    pactl set-source-mute 1 toggle
    dunstify -i $iconOff -t 1000 'Mic muted' ' ' -p 2 -r 2
elif [[ $mute = 'yes' ]]; then
    pactl set-source-mute 1 toggle
    dunstify -i $iconOn -t 1000 'Mic unmuted' ' ' -p 2 -r 2
fi

polybar-msg hook mute 1

