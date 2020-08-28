#!/bin/sh

# Faster command than xrandr?
# grep . /sys/class/drm/*/status

if xrandr | grep -ow "DP1 connected"
then
    # If second monitor connected, activated it
   xrandr --output eDP1 --primary --mode 1366x768 --pos 1360x0 --rotate normal --output DP1 --mode 1360x768 --pos 0x0 --rotate normal --output HDMI1 --off --output HDMI2 --off --output VIRTUAL1 --off
else
    # If second monitor not connected, deactivated it and use only the default
    xrandr --output eDP1 --primary --mode 1366x768 --output DP1 --off
fi
