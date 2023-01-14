#!/bin/sh

# Panic script
# it works as toggle:
# execute the first time to panic and the second to go back to normal

# Executing it the first time will check if this is actually the first part of the toggle
# then its gonna create an file to show, the next time, that the the script is activated

# When firs executed, it creates a file in /tmp/panic, writes all the ids of all visible windows at the time while also adding the hidden tag to them
# pauses all music sources and notifications for dunst
# and open 3 terminal with different programs with the name 'panic'
#
# executing it one more time, it will read the file, unpause the music if it was playing, kill all 'panic' windows created, unhide all previsouly shown windows, resume notifications and delete the file

file=/tmp/panic

if [ -z $(ls /tmp/ | grep panic) ]; then
    touch $file

    # hides all shown windows
    # and writes their IDs into the file
    for i in $(bspc query -N -n .normal.\!hidden); do
        bspc node $i -g hidden=on
        echo "hidden $i" >> $file
    done

    # if running the script from the desktop 1, disables monocle layout
    # and writes to the file
    if [[ "$(bspc query --desktop focused -D --names)" = 1 ]]; then
      bspc desktop 1 -l tiled
      echo "desktop 1" >> $file
    fi

    # pauses the media if playing
    if [[ $(playerctl status) = "Playing" ]]; then
        echo 'playerctl playing' >> $file
        playerctl play-pause
    fi
    if [[ $(mpc -p 6600 | grep playing) ]]; then
        echo 'mpd playing' >> $file
        mpc -p 6600 pause
    fi

    # stops and closes all possible notifications
    dunstctl set-paused true

    # opens 3 terminals
    # urxvt -name 'panic' -e gotop -aps &
    st -n 'panic' -e gotop -aps --nvidia &
    sleep 0.1
    # urxvt -name 'panic' -e ranger &
    st -n 'panic' -e ranger &
    sleep 0.1
    # urxvt -name 'panic' &
    st -n 'panic' &
    #sleep 0.8
else
    # closes the terminals that the panic button opened
    xdo close -n 'panic'

    # read all the lines from the file
    while read line; do
        # reads the file to know whether I was on the first desktop
        # if yes, return it's layout back to monocle
        if [ "$line" = 'desktop 1' ]; then
          bspc desktop -l monocle
        fi
        # reads the file to know whether it's paused the media, if so, resumes it
        if [ "$line" = 'playerctl playing' ]; then
            playerctl play
        fi
        if [ "$line" = 'mpd playing' ]; then
            mpc -p 6600 play
        fi
        # reads the file to know what windows were hidden by panic
        if [ $(echo $line | cut -d' ' -f1) = 'hidden' ]; then
            bspc node $(echo $line | cut -d' ' -f2) -g hidden=off
        fi
    done < $file

    # re-enable notifications
    dunstctl close-all
    dunstctl set-paused false

    rm $file
fi


