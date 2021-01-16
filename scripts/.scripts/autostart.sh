#!/bin/sh

# function to check if the program is already running
# if not, run it with an & in the end
function run {
    if ! pgrep $1; then
        $@&
    fi
}

#######################
###     programs    ###
#######################
run sxhkd

run urxvtd -q -o -f

run xfce4-power-manager

#run megasync

#run libinput-gestures-setup restart

#run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1

run nm-applet

run pamac-tray

run clipster -d

run copyq

#run xautolock -time 60 -locker ~/.scripts/lock.sh

run ff-theme-util

run fix_xcursor

run pulseaudio &

#run spotify

#run firefox

#run discord

#run premid

xsetroot -cursor_name left_ptr &

setxkbmap -model abnt2 -layout br -variant abnt2 &

nitrogen --restore;sleep 1;picom -b --experimental-backend &

#sleep 5 && flashfocus &

#######################
###     scripts     ###
#######################
sleep 4 && $HOME/.config/polybar/launch.sh &

$HOME/.scripts/mouse_sens.sh &

#$HOME/.scripts/monitors.sh &

xset r rate 200 30 & 
# first number is delay, and second is interval

#sleep 10 && $HOME/.scripts/headset-mic.sh &

#$HOME/.scripts/better.sh &



