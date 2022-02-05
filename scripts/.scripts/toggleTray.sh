#!/bin/sh

# script to show/hide polybar system tray

wid=$(xdotool search --name "Polybar tray window" | head -n1)
state=$(xwininfo -id $wid | grep "Map State:")

if [[ $state == *IsViewable ]]; then
    xdotool windowunmap $wid
elif [[ $state == *IsUnMapped ]]; then
    xdotool windowmap $wid
else
    echo "can't get state"
fi

