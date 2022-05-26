#!/bin/sh

# Changes the volume level of an audio track
# Signals an the status bar to update

# usage example:

# Using pactl (apparently more cpu friendly)
# ./volume.sh +2% to increase 2% to the current volume

# Using amixer: (comment currentSink and pactl command, and uncomment amixer command)
# ./volume.sh Master 2%+ to increase 2% to the current volume

icon="/usr/share/icons/Papirus-Dark/16x16/actions/audio-volume-high.svg"

currentSink=$(pacmd list-sinks | \grep "* index:" | awk '{print $3}')
pactl set-sink-volume $currentSink $1

#amixer set "$1" "$2"

currentVol=$(pacmd list-sinks | \grep -A 7 "* index:" | awk -F' ' 'END{print $5}')

dunstify -i $icon -t 1000 "Volume $2" "Current volume: $currentVol" -r 1

