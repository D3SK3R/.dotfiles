#!/bin/sh

# Check if my audio input (pulseaudio) is muted or not, and send a notification

#mute=$(pactl list sources | grep Mute | awk -F' ' 'NR==2 {print $2}')

activePort=$(pacmd list | \grep '<alsa_input.pci-0000_00_1b.0.analog-stereo>' -A 63 | \grep 'active port' | awk -F'<' 'END{gsub(">","");print $2}')

if [[ $activePort = "analog-input-headset-mic" ]]; then
    mute=$(pactl list sources | grep analog-input-mic -B 43 | awk -F' ' 'NR==1 {print $2}')
    src=$(pactl list sources | grep analog-input-mic -B 51 | awk -F'#' 'NR==1 {print $2}')
elif [[ $activePort = "analog-input-internal-mic" ]]; then
    mute=$(pactl list sources | grep analog-input-internal-mic -B 40 | awk -F' ' 'NR==1 {print $2}')
    src=$(pactl list sources | grep analog-input-internal-mic -B 48 | awk -F'#' 'NR==1 {print $2}')
else
    echo 'No active port found.'
fi

iconOn="/usr/share/icons/Papirus-Dark/16x16/panel/mic-ready.svg"
iconOff="/usr/share/icons/Papirus-Dark/16x16/panel/mic-volume-muted.svg"

echo $mute
if [[ $mute = 'no' ]]; then
    pactl set-source-mute $src toggle
    dunstify -i $iconOff -t 1000 'Mic muted' -r 2
elif [[ $mute = 'yes' ]]; then
    pactl set-source-mute $src toggle
    dunstify -i $iconOn -t 1000 'Mic unmuted' -r 2
fi

polybar-msg hook mute 1

