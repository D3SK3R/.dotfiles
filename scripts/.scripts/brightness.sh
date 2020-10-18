#!/bin/bash

# USAGE:
# ./brightness + or - to increase or decrease brightness, or no argument to show brightness

# Use this command if you get a permission error
#sudo chmod a+rw /sys/class/backlight/intel_backlight/brightness

# command to know what file to use: ls /sys/class/backlight
# to be able to edit the file:
# sudo chmod 666 /sys/class/backlight/intel_backlight/brightness

file="/sys/class/backlight/intel_backlight/brightness"
level=$(cat $file)

if [[ "$#" -eq 0 ]]; then
    cat $file
elif [[ "$1" = "-" ]]; then
    echo $(( level - 1 )) > $file
    current=$(cat $file)
    dunstify -t 1000 "Brightness -1%" "Current brightness: $current" -p 2 -r 2
elif [[ "$1" = "+" ]]; then
    echo $(( level + 1 )) > $file
    current=$(cat $file)
    dunstify -t 1000 "Brightness +1%" "Current brightness: $current" -p 2 -r 2
fi
