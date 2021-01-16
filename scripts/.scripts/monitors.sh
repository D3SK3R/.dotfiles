#!/bin/sh

# Faster command than xrandr?
# grep . /sys/class/drm/*/status

monitor=$(xrandr | grep -ow 'DP1 connected')

if [ "$monitor" ]; then
    # If second monitor connected, activated it to the left of my main monitor
    dunstify 'Second Monitor detected' '' -p 5 -r 5
    #xrandr --output eDP1 --primary --mode 1366x768 --pos 1360x0 --rotate normal --output DP1 --mode 1360x768 --pos 0x0 --rotate normal;
    xrandr --output eDP1 --primary --auto --output DP1 --auto --left-of eDP1
    #kill picom;picom -b --experimental-backend;
else
    # If second monitor not connected, deactivated it and use only the default
    dunstify 'No other monitors detected' '' -p 5 -r 5
    #xrandr --output eDP1 --primary --mode 1366x768 --output DP1 --off
    xrandr --output eDP1 --primary --auto --output DP1 --off
fi
