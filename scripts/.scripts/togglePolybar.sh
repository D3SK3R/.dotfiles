#!/bin/sh

# script to show/hide polybar

wid=$(xdotool search --name "polybar-main_eDP-1" | head -n1)
wid2=$(xdotool search --name "polybar-main2_DP-1" | head -n1)
state=$(xwininfo -id $wid | grep "Map State:")

if [[ $state == *IsViewable ]]; then
    xdotool windowunmap $wid
    xdotool windowunmap $wid2
    bspc config top_padding 0
    bspc config top_monocle_padding 0
elif [[ $state == *IsUnMapped ]]; then
    xdotool windowmap $wid
    xdotool windowmap $wid2
    sleep 0.2;bspc config top_padding 22
    sleep 0.2;bspc config top_monocle_padding 6
else
    echo "can't get state"
fi

