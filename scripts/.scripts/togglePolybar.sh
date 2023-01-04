#!/bin/sh

# script to show/hide polybar

monitor1=$(xrandr | \grep -w connected | awk 'FNR==1 {print $1}')
monitor2=$(xrandr | \grep -w connected | awk 'FNR==2 {print $1}')

wid=$(xdotool search --name "polybar-main_$monitor1" | head -n1)
wid2=$(xdotool search --name "polybar-main2_$monitor2" | head -n1)
state=$(xwininfo -id $wid | grep "Map State:")

if [[ $state == *IsViewable ]]; then
    xdotool windowunmap $wid
    xdotool windowunmap $wid2
    bspc config top_padding 0
    bspc config top_monocle_padding 0
elif [[ $state == *IsUnMapped ]]; then
    xdotool windowmap $wid
    xdotool windowmap $wid2
    # sleep 0.2;bspc config top_padding 22
    sleep 0.2;bspc config top_monocle_padding 6
else
    echo "can't get state"
fi

