#!/bin/sh

#mute=$(pactl list sources | grep Mute | sed -n 2p | cut -d : -f2 | sed 's/ //g')
mute=$(pactl list sources | grep Mute | awk -F' ' 'NR==2 {print $2}')

echo $mute
if [[ $mute = 'no' ]]; then
    echo ''
elif [[ $mute = 'yes' ]]; then
    #   
    echo ' -  '
    #echo ' '
fi

