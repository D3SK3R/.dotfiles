#!/bin/bash

# Alternative to it:
# Package: light
# commands:
# light -A 1 to increase brightness by 1
# light -U 1 to decrease brightness by 1

# USAGE:
# ./brightness + or - to increase or decrease brightness, or no argument to show brightness

# Use this command if you get a permission error
#sudo chmod a+rw /sys/class/backlight/intel_backlight/brightness

# command to know what file to use: ls /sys/class/backlight
# to be able to edit the file:
# sudo chmod 666 /sys/class/backlight/intel_backlight/brightness

file="/sys/class/backlight/intel_backlight/brightness"
level=$(cat $file)

icon="/usr/share/icons/Papirus-Dark/16x16/devices/display.svg"

if [[ "$#" -eq 0 ]]; then
    cat $file
elif [[ "$1" = "-" ]]; then
    echo $(( level - 1 )) > $file
    current=$(cat $file)
    dunstify -i $icon -t 1000 "Brightness -1%" "Current brightness: $current" -r 2
elif [[ "$1" = "+" ]]; then
    echo $(( level + 1 )) > $file
    current=$(cat $file)
    dunstify -i $icon -t 1000 "Brightness +1%" "Current brightness: $current" -r 2
fi
