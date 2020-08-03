#!/bin/bash

# USAGE:
# ./brightness + or - to increase or decrease brightness, or no argument to show brightness

# command to know what file to use: ls /sys/class/backlight
# to be able to edit the file:
# sudo chmod 666 /sys/class/backlight/intel_backlight/brightness

file="/sys/class/backlight/intel_backlight/brightness"
level=$(cat $file)

if [[ "$#" -eq 0 ]]; then
    cat $file
elif [[ "$1" = "-" ]]; then
    echo $(( level - 1 )) > $file
elif [[ "$1" = "+" ]]; then
    echo $(( level + 1 )) > $file
fi
