#!/bin/sh

# Check if the headset mic in use 
# if its not, set it and set its volume
# Sources: https://askubuntu.com/questions/349427/two-microphones-listed-in-the-input-section-of-pulseaudio-internal-microphone
# https://askubuntu.com/questions/165877/mic-is-not-workin-in-my-desktop-available-unknown

# Info:
# how to easily know what sink-index to use:
# mute the mic input and use the command:
# pacmd list-sources | grep 'muted: yes' -B 11

while true; do
    micConnected=$(pacmd list | grep 'analog-input-headphone-mic: Microphone (priority 8700, latency offset 0 usec, available: unknown)')

    # if theres no headset microphone
    if [ -z "$micConnected" ]; then
        echo 'no headset microphone detected'
    else
        micInUse=$(pacmd list | grep 'active port: <analog-input-headset-mic>')
        # checks whether the headset mic is in use or not
        # if its not, set it to use
        if [ -z "$micInUse" ]; then
            echo 'headset mic set as input'
            pacmd set-source-port 1 'analog-input-headset-mic'
            pacmd set-default-source 1
        fi
        # set its volume to 50
        # volume 50: 32985 / volume 70: 45830
        echo 'setting headset mic volume to 50'
        pacmd set-source-volume 1 32985
    fi
    sleep 10
done

