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

## BSPWM Monitors setup
if xrandr | grep -ow "DP-1 connected" >/dev/null; then
    autorandr --change &
    sleep 2 && bspc desktop 2 --focus &&
    sleep 0.5 &&
    bspc desktop 1 --focus
else
    run autorandr
    bspc monitor -d 1 2 3 4 5 6 7 8 9
    sleep 3 && $HOME/.config/polybar/launch.sh &
fi
# everything about monitors is commented
# since I'm using autorandr that executed all of this
#$HOME/.config/bspwm/monitors-bspwm &

#$HOME/.scripts/monitors.sh &

$HOME/.scripts/keyboardSet &

sleep 6 && $HOME/.scripts/headset-configure &

#######################
###    programs     ###
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

run xautolock -time 60 -locker ~/.scripts/lock.sh

# not necessary
#run fix_xcursor

run udiskie -t

start-pulseaudio-x11
#pulseaudio --kill & pulseaudio &
#sleep 2 && killall pulseaudio & sleep 1 && pulseaudio &

run mpd

#sleep 3 && killall copyq;copyq & 
#sh -c "sleep 5; copyq &"

nitrogen --restore &

picom -b --experimental-backend &

sleep 10 && flashfocus &

# floating stuff
sleep 3 && urxvt -title floating_terminal &
#sleep 3 && st -n floating_terminal &
sleep 3 && urxvt -title floating_terminal2 &
#sleep 3 && st -n floating_terminal2 &

sleep 3 && urxvt -title ncmpcpp -e ncmpcpp &

# workaround: use external rules bspwm
# doesn't work, at least not with a low sleep delay
#sleep 3 && bspc rule -a "*" -o hidden=on sticky=on state=floating rectangle=800x600+1643+98;spotify &

#sleep 5 && firefox &

sleep 4 && discord & #premid &

sleep 10 && copyq &


