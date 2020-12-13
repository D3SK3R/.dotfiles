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
            ;;
        toggle)
            playerctl play-pause
    esac
# if pidof mpd returns something, it enters this else and controls mpc
else
    mpc='mpc -p 1100'
    case $1 in
        next)
            $mpc next
            playing=$(mpc -p 1100 | head -n 1)
            dunstify -t 2000 " Next..." "$playing" -p 1100 -r 1100
            ;;
        prev)
            $mpc seek 0;$mpc cdprev
            playing=$(mpc -p 1100 | head -n 1)
            dunstify -t 2000 " Previous..." "$playing" -p 1100 -r 1100
            ;;
        stop)
            $mpc seek 0;$mpc pause
            playing=$(mpc -p 1100 | head -n 1)
            dunstify -t 2000 " Stopping..." "$playing" -p 1100 -r 1100
            ;;
        toggle)
            $mpc toggle
            playing=$(mpc -p 1100 | head -n 1)
            state=$(mpc -p 1100 | grep -e "\[.*\]" | cut -d' ' -f1)
            if [ '$state' == "[playing]" ]; then
                dunstify -t 2000 " Playing..." "$playing" -p 1100 -r 1100
            else
                dunstify -t 2000 " Pausing..." "$playing" -p 1100 -r 1100
            fi
    esac
fi
