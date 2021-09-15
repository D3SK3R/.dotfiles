#!/bin/sh

# Changes the volume level of an audio track
# Signals an the status bar to update

# usage example:
# ./volume.sh Master 2%+ to increase 2% to the current volume

icon="/usr/share/icons/Papirus-Dark/16x16/actions/audio-volume-high.svg"

amixer set "$1" "$2"
#current=$(pacmd list-sinks | grep -A 15 "index: " | grep 'volume:' | grep -E -v 'base volume:' | awk -F : '{print $3}' | grep -o -P '.{0,3}%'| head -n1 | tr -d ' ')
current=$(pacmd list-sinks | \grep -A 7 "* index:" | awk -F' ' 'END{print $5}')

dunstify -i $icon -t 1000 "Volume $2" "Current volume: $current" -r 1

