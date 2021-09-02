#!/bin/sh

# Faster command than xrandr?
# grep . /sys/class/drm/*/status

monitor=$(xrandr | grep -ow 'DP-1 connected')

if [ "$monitor" ]; then
    # If second monitor connected, activated it to the left of my main monitor
    dunstify 'Second Monitor detected' '' -r 5
    #xrandr --output eDP-1 --primary --mode 1366x768 --pos 1360x0 --rotate normal --output DP-1 --mode 1360x768 --pos 0x0 --rotate normal;
    xrandr --output eDP-1 --primary --auto --output DP-1 --auto --left-of eDP-1
    #kill picom;picom -b --experimental-backend;
else
    # If second monitor not connected, deactivated it and use only the default
    dunstify 'No other monitors detected' '' -r 5
    #xrandr --output eDP-1 --primary --mode 1366x768 --output DP-1 --off
    xrandr --output eDP-1 --primary --auto --output DP-1 --off
fi
