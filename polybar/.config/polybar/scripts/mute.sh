#!/bin/sh

#mute=$(pactl list sources | grep Mute | awk -F' ' 'NR==2 {print $2}')

activePort=$(pacmd list | \grep '<alsa_input.pci-0000_00_1b.0.analog-stereo>' -A 63 | \grep 'active port' | awk -F'<' 'END{gsub(">","");print $2}')

if [[ $activePort = "analog-input-headset-mic" ]]; then
    mute=$(pactl list sources | grep analog-input-mic -B 43 | awk -F' ' 'NR==1 {print $2}')
elif [[ $activePort = "analog-input-internal-mic" ]]; then
    mute=$(pactl list sources | grep analog-input-internal-mic -B 40 | awk -F' ' 'NR==1 {print $2}')
else
    echo 'No active port found.'
fi

echo $mute
if [[ $mute = 'no' ]]; then
    echo ''
elif [[ $mute = 'yes' ]]; then
    #   
    echo ' -  '
    #echo ' '
fi

