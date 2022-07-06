#!/bin/sh

# gets the pid of the mpd process
mpdRunning=$(pidof mpd)

# checks to see if there's any pid, if not, enters this if and controls playerctl
if [ -z $mpdRunning ]; then
    case $1 in
        next)
            playerctl next
            ;;
        prev)
            playerctl previous
            ;;
        stop)
            playerctl stop;playerctl previous
            dunstify -t 2000 " Stopping..." -r 6600
            ;;
        toggle)
            playerctl play-pause
            if [[ $(playerctl status) == "Playing" ]]; then
                dunstify -t 2000 " Pausing..." -r 6600
            else
                dunstify -t 2000 " Playing..." -r 6600
            fi 
    esac
# if pidof mpd returns something, it enters this else and controls mpc
else
    mpc='mpc -p 6600'
    case $1 in
        next)
            $mpc next
            playing=$(mpc -p 6600 | head -n 1)
            dunstify -t 2000 " Next..." "$playing" -r 6600
            ;;
        prev)
            $mpc seek 0;$mpc cdprev
            playing=$(mpc -p 6600 | head -n 1)
            dunstify -t 2000 " Previous..." "$playing" -r 6600
            ;;
        stop)
            $mpc seek 0;$mpc pause
            playing=$(mpc -p 6600 | head -n 1)
            dunstify -t 2000 " Stopping..." "$playing" -r 6600
            ;;
        toggle)
            playing=$(mpc -p 6600 | head -n 1)
            state=$(mpc -p 6600 | sed -n 2p | cut -d' ' -f1)
            if [ $state == '[playing]' ]; then
                dunstify -t 2000 " Pausing..." "$playing" -r 6600
            else
                dunstify -t 2000 " Playing..." "$playing" -r 6600
            fi
            $mpc toggle
    esac
fi
