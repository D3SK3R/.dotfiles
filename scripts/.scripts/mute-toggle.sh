#!/bin/sh

# ALTERNATIVE PROBABLY EASIER: (the "--default-source might be optional") 
# pamixer --default-source --get-volume(-human)
# pamixer --default-source --get-mute
# pamixer --default-source --set-volume
# pamixer --default-source --toggle-mute
# pamixer --default-source --increase/--decrease 1

# Check if my audio input (pulseaudio) is muted or not, mute or unmute, and send a notification

#mute=$(pactl list sources | grep Mute | awk -F' ' 'NR==2 {print $2}')

# activePort=$(pacmd list | \grep '<alsa_input.pci-0000_00_1b.0.analog-stereo>' -A 63 | \grep 'active port' | awk -F'<' 'END{gsub(">","");print $2}')
device="alsa_input.usb-Logitech_G432_Gaming_Headset_000000000000-00.mono-fallback"
activePort=$(pacmd list | \grep $device -A 63 | \grep 'active port' | awk -F'<' 'END{gsub(">","");print $2}')

# if [[ $activePort = "analog-input-headset-mic" ]]; then
if [[ $activePort = "analog-input-mic" ]]; then
    mute=$(pacmd list | \grep -e $device -A 10| \grep -E "RUNNING|SUSPENDED" -A 7 | awk 'END{print $2}')
    echo $mute
    # mute=$(pactl list sources | grep analog-input-mic -B 40 | awk -F' ' 'NR==1 {print $2}')
    # src=$(pactl list sources | grep analog-input-mic -B 46 | awk -F' ' 'NR==1 {print $2}')
elif [[ $activePort = "analog-input-internal-mic" ]]; then
    mute=$(pacmd list | \grep -e $device -A 10| \grep -E "RUNNING|SUSPENDED" -A 7 | awk 'END{print $2}')
    # mute=$(pactl list sources | grep analog-input-internal-mic -B 40 | awk -F' ' 'NR==1 {print $2}')
    # src=$(pactl list sources | grep analog-input-internal-mic -B 48 | awk -F'#' 'NR==1 {print $2}')
else
    echo 'No active port found.'
fi

iconOn="/usr/share/icons/Papirus-Dark/16x16/panel/mic-ready.svg"
iconOff="/usr/share/icons/Papirus-Dark/16x16/panel/mic-volume-muted.svg"

echo $mute
if [[ $mute = 'no' ]]; then
    pactl set-source-mute $device toggle
    dunstify -i $iconOff -t 1000 'Mic muted' -r 2
elif [[ $mute = 'yes' ]]; then
    pactl set-source-mute $device toggle
    dunstify -i $iconOn -t 1000 'Mic unmuted' -r 2
fi

polybar-msg action "#mute.hook.0" >/dev/null
h ''
