#!/bin/sh

#mute=$(pactl list sources | grep Mute | awk -F' ' 'NR==2 {print $2}')

# activePort=$(pacmd list | \grep '<alsa_input.usb-Logitech_G432_Gaming_Headset_000000000000-00.mono-fallback>' -A 63 | \grep 'active port' | awk -F'<' 'END{gsub(">","");print $2}')

device="alsa_input.usb-Logitech_G432_Gaming_Headset_000000000000-00.mono-fallback"
activePort=$(pacmd list | \grep $device -A 63 | \grep 'active port' | awk -F'<' 'END{gsub(">","");print $2}')

# if [[ $activePort = "analog-input-headset-mic" ]]; then
if [[ $activePort = "analog-input-mic" ]]; then
    # mute=$(pactl list sources | grep analog-input-mic -B 43 | awk -F' ' 'NR==1 {print $2}')
    mute=$(pacmd list | \grep -e $device -A 10| \grep -E "RUNNING|SUSPENDED" -A 7 | awk 'END{print $2}')
elif [[ $activePort = "analog-input-internal-mic" ]]; then
    mute=$(pacmd list | \grep -e $device -A 10| \grep -E "RUNNING|SUSPENDED" -A 7 | awk 'END{print $2}')
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

