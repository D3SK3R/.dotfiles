#!/bin/sh

# Check if my audio input (pulseaudio) is muted or not, and send a notification

mute=$(pactl list sources | grep Mute | sed -n 2p | cut -d : -f2 | sed 's/ //g')

if [[ $mute = 'no' ]]; then
    pactl set-source-mute 1 toggle
    dunstify -t 1000 'Mic muted' ' ' -p 2 -r 2
elif [[ $mute = 'yes' ]]; then
    pactl set-source-mute 1 toggle
    dunstify -t 1000 'Mic unmuted' ' ' -p 2 -r 2
fi


