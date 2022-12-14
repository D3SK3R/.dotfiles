#!/bin/sh

# make a window picture-in-picture size
# and move it to the top-right corner.
# execute again hovering the same window
# and it will disable the pip mode

node="$(bspc query -N -n ${1:-focused})" || exit 1
wid="$(xdotool getwindowfocus)" || exit 1
state=$(bspc query -n $node --tree | jq -r '.client["state"]') || exit 1
#desktop="$(bspc query -D -d focused --names)"

if [[ "$state" == "tiled" ]]; then
    bspc node $node -t floating --flag sticky=on

    xdotool windowsize $wid 302 170 &

    xdotool windowmove $wid 2971 31 &
else
    bspc node $node -d 2

    bspc node $node -t tiled --flag sticky=off
fi

