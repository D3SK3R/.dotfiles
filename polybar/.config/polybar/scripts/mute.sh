#!/bin/sh

mute=$(pactl list sources | grep Mute | sed -n 2p | cut -d : -f2 | sed 's/ //g')

if [[ $mute = 'no' ]]; then
    echo ''
elif [[ $mute = 'yes' ]]; then
    #   
    echo ' -  '
    #echo ' '
fi

