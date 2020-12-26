#!/bin/sh

if [ -z $(ls /tmp/ | grep panic) ]; then
    touch /tmp/panic

    # Get the workspace i'm in and write it to the file
    ws=$(i3-msg -t get_workspaces \
    | jq '.[] | select(.focused==true).name' \
    | cut -d"\"" -f2)

    # sees if theres another monitor, if so, move it to another workspace
    # and writes to the file
    if xrandr | grep -ow "DP1 connected" >/dev/null; then
        i3 workspace 4
        i3 workspace 9
        echo "second monitor" >> /tmp/panic
    else
        i3 workspace 9
    fi
    
    # writing the actual workspace AFTER the possible second monitor is already
    # in the file, so that the script moves me to the right workspace in the second
    # monitor and only then, moves me to the right workspace in the main monitor
    echo "workspace $ws" >> /tmp/panic

    # pauses the media if playing
    if [ $(playerctl status) = "Playing" ]; then
        echo 'playing' >> /tmp/panic
        playerctl stop;playerctl previous
    fi
    mpc -p 1100 seek 0 && mpc -p 1100 pause

    # opens 3 terminals
    urxvt -e gotop -aps &
    sleep 0.2
    urxvt -e ranger &
    sleep 0.2
    urxvt &
    #sleep 0.8
else
    # closes the terminals that the panic button opened
    # if executed from a urxvt terminal
    # this script will 'break', making it not run the lines above xdo close
    # since this is also gonna close the terminal the script is running
    xdo close -N 'URxvt' -d

    # reads the file to know whether the script has paused the music, if so, resumes it
    filename=/tmp/panic
    while read line; do
        if [ "$line" = 'playing' ]; then
            playerctl play
            mpc -p 1100 toggle
        fi
        # read the file to know whether I have my second monitor on
        if [ "$line" = 'second monitor' ]; then
            i3 workspace 2
        fi
        # reads the file to know what workspace was in and goes to it
        if [ $(echo $line | cut -d' ' -f1) = 'workspace' ]; then
            echo $line
            i3 $line
        fi

    done < $filename

    rm /tmp/panic
fi


