#!/bin/sh

# Changes the volume level of an audio track
# Signals an the status bar to update

# usage example:
# ./volume.sh Master 2%+ to increase 2% to the actual volume

# mute 'feature' not working
if [ "$1" = "All" ]; then
    if [ "$2" = "mute" ]; then
        volume="$(i3volume)"

        if [ ! "$(echo "$volume" | grep -q "mute")" ]; then
            amixer set "Master" "mute"
            amixer set "Headphone" "mute"
            amixer set "Speaker" "mute"
        else
            amixer set "Master" "unmute"
            amixer set "Headphone" "unmute"
            amixer set "Speaker" "unmute"
        fi
    fi
else
    amixer set "$1" "$2"
    current=$(pacmd list-sinks | grep -A 15 "index: " | grep 'volume:' | grep -E -v 'base volume:' | awk -F : '{print $3}' | grep -o -P '.{0,3}%'| sed s/.$// | tr -d ' ')

    dunstify -t 1000 "Volume $2" "Current volume: $current" -p 1 -r 1

fi

# not using polybar hook
#polybar-msg hook volume 1
