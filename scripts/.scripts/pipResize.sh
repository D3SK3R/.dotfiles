#!/bin/sh

# make a window picture-in-picture size
# and move it to the top-right corner

node="$(bspc query -N -n ${1:-focused})" || exit 1
wid="$(xdotool getwindowfocus)" || exit 1

echo $node
echo $wid

bspc node $node -t floating

xdotool windowsize $wid 302 170 &

xdotool windowmove $wid 2424 64 &

