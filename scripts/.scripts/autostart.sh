#!/bin/sh

# check if the script is running right after the system started
# so that I can edit and reload my bspwmrc without it
# re-running this script
#uptime="$(cat /proc/uptime | cut -d' ' -f1 | cut -d'.' -f1)"
#if [[ "$uptime" -gt "100" ]]; then
#    exit 
#fi

dunstify -i "/usr/share/icons/Papirus-Dark/16x16/emblems/checkmark.svg" "Running autostart script"

# function to check if the program is already running
# if not, run it with an & in the end
function run {
    if ! pgrep $1; then
        $@&
    fi
}

#######################
###     scripts     ###
#######################
if xrandr | grep -ow "DP1 connected" >/dev/null; then
    autorandr --change &
else
    bspc monitor -d 1 2 3 4 5 6 7 8 9
    sleep 3 && $HOME/.config/polybar/launch.sh &
fi
# everything about monitors is commented
# since I'm using autorandr that executed all of this
#$HOME/.config/bspwm/monitors-bspwm &

#$HOME/.scripts/monitors.sh &

$HOME/.scripts/mouse_sens.sh &

$HOME/.config/bspwm/swallowbspwm &

$HOME/.scripts/better.sh &

sleep 2 && $HOME/.scripts/headset-mic.sh &

#######################
###     programs    ###
#######################
xrdb -merge $HOME/.Xresources

run sxhkd

run urxvtd -q -o -f

run xsetroot -cursor_name left_ptr

run xfce4-power-manager

run megasync

#run libinput-gestures-setup restart

run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1

run nm-applet

run pamac-tray

run clipster -d

run copyq 

run xautolock -time 60 -locker ~/.scripts/lock.sh

run ff-theme-util

run fix_xcursor

run udiskie -t

killall pulseaudio && pulseaudio &

xset r rate 200 30 & 
# first number is delay, and second is interval

setxkbmap -model abnt2 -layout br -variant abnt2 &

nitrogen --restore;sleep 1;picom -b --experimental-backend &

sleep 4 && flashfocus &

# floating stuff
sleep 3 && urxvt -name floating_terminal &

sleep 3 && urxvt -name floating_terminal2 &

#sleep 3 && bspc rule -a "*" -o hidden=on sticky=on state=floating;spotify &

sleep 4 && firefox &

sleep 3 && discord & premid &


