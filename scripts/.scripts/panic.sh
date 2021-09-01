#!/bin/sh

# Panic script
# it works as toggle:
# execute the first time to panic and the second to go back to normal

# Executing it the first time will chec if this is actually the first part of the toggle
# then its gonna create an file to show, the next time, that the the script is activated

#TODO
# 1: fix the 'hides all floating windows' part, since it also
# hides the floating windows thats not from sctratchpad

file=/tmp/panic

if [ -z $(ls /tmp/ | grep panic) ]; then
    touch $file

    # workspace I'm currently focusing
    focused=$(bspc query -D -d focused --names)
    # Get the workspaces i'm in, write it to the file and
    # sees if theres another monitor, if so, move it to another workspace
    # and writes to the file
    if xrandr | grep -ow "DP-1 connected" >/dev/null; then
        ws1=$(bspc query -m eDP-1 -T | jq | grep "focusedDesktopId" | \
            awk -F " " '{print $NF}' | cut -d',' -f1)
        ws2=$(bspc query -m DP-1 -T | gron | grep "focusedDesktopId" | \
            awk -F " " '{print $NF}' | cut -d';' -f1)
        bspc desktop -f 4
        bspc desktop -f 9
    else
        ws1=$(bspc query -m eDP-1 -T | jq | grep "focusedDesktopId" | \
        awk -F " " '{print $NF}' | cut -d',' -f1)
        bspc desktop -f 9
    fi
    
    # writing the actual workspace AFTER the possible second monitor is already
    # in the file, so that the script moves me to the right workspace in the second
    # monitor and only then, moves me to the right workspace in the main monitor
    echo "workspace2 $ws2" >> $file
    echo "workspace1 $ws1" >> $file
    echo "focused $focused" >> $file

    # hides all shown floating windows
    # and writes their ID into the file
    for i in $(bspc query -N -n .floating.\!hidden); do
        bspc node $i -g hidden=on
        echo "hidden $i" >> $file
    done

    # pauses the media if playing
    if [[ $(playerctl status) = "Playing" ]]; then
        echo 'playing' >> $file
        playerctl play-pause
    fi
    if [[ $(mpc -p 1100 | grep playing) ]]; then
        echo 'playing' >> $file
        mpc -p 1100 pause
    fi

    # stops and closes all possible notifications
    dunstctl set-paused true

    # kills swallow script so that the terminals don't get swallowed
    killall swallowbspwm
    # opens 3 terminals
    urxvt -name 'panic' -e gotop -aps &
    sleep 0.2
    urxvt -name 'panic' -e ranger &
    sleep 0.2
    urxvt -name 'panic' &
    #sleep 0.8
else
    # closes the terminals that the panic button opened
    xdo close -n 'panic'

    while read line; do
        # reads the file to know whether the music was paused, if so, resumes it
        if [ "$line" = 'playing' ]; then
            playerctl play
            mpc -p 1100 play
        fi
        # reads the file to know what workspaces I was in and goes to it
        if [ $(echo $line | cut -d' ' -f1) = 'workspace2' ]; then
            bspc desktop -f $(echo $line | cut -d' ' -f2)
        fi
        if [ $(echo $line | cut -d' ' -f1) = 'workspace1' ]; then
            bspc desktop -f $(echo $line | cut -d' ' -f2)
        fi
        # last, focus the exact workspace I was focusing before panic
        if [ $(echo $line | cut -d' ' -f1) = 'focused' ]; then
            bspc desktop -f $(echo $line | cut -d' ' -f2)
        fi
        # reads the file to know what floating windows were hidden by panic
        if [ $(echo $line | cut -d' ' -f1) = 'hidden' ]; then
            bspc node $(echo $line | cut -d' ' -f2) -g hidden=off
        fi
    done < $file

    # re-enable notifications
    dunstctl close-all
    dunstctl set-paused false

    # executes swallow again and removes the file used to toggle the script
    $HOME/.config/bspwm/swallowbspwm &
    rm $file
fi


