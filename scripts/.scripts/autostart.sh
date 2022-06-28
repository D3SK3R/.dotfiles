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
if xrandr | grep -ow "DP1 connected" >/dev/null; then
    autorandr --change &
    #sleep 2
    sleep 1 && bspc desktop 2 --focus &&
    sleep 0.5 &&
    bspc desktop 1 --focus
else
    run autorandr
    bspc monitor -d 1 2 3 4 5 6 7 8 9
    #sleep 3
    sleep 2 && $HOME/.config/polybar/launch.sh &
fi
# everything about monitors is commented
# since I'm using autorandr that executed all of this
#$HOME/.config/bspwm/monitors-bspwm &

#$HOME/.scripts/monitors.sh &

$HOME/.scripts/keyboardSet &

# 4
sleep 0.7 && $HOME/.scripts/headset-configure &

# 5
sleep 1.5 && polybar-msg hook mute 1 &

#######################
###    programs     ###
#######################
xrdb -merge $HOME/.Xresources

run sxhkd

run urxvtd -q -o -f

run xsetroot -cursor_name left_ptr

run xfce4-power-manager

run megasync

run libinput-gestures-setup restart

run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1

run nm-applet

run pamac-tray

run clipster -d

run xautolock -time 60 -locker ~/.scripts/lock.sh

run udiskie -t

start-pulseaudio-x11 &
#pulseaudio --kill & pulseaudio &
#sleep 2 && killall pulseaudio & sleep 1 && pulseaudio &

run mpd
#run LD_PRELOAD=/usr/local/lib/spotify-adblock.so spotify

nitrogen --restore &

picom -b --experimental-backend &

# 5
sleep 3 && flashfocus &

# disable the autostart option inside copyq's preferences
# 5
sleep 3 && copyq &

# floating stuff
# sleep 2 && urxvt -title floating_terminal &
sleep 2 && st -T floating_terminal &
# sleep 2 && urxvt -title floating_terminal2 &
sleep 2 && st -T floating_terminal2 &

# sleep 2 && urxvt -title ncmpcpp -e ncmpcpp &
sleep 2 && st -T ncmpcpp -e ncmpcpp &

# workaround: use external rules bspwm
# doesn't work, at least not with a low sleep delay
#sleep 3 && bspc rule -a "*" -o hidden=on sticky=on state=floating rectangle=800x600+1643+98;spotify &

#sleep 5 && firefox &

sleep 3 && discord & #premid &

#sleep 8 && redshift &

#sh $HOME/.scripts/better.sh &
sh $HOME/.scripts/water.sh &

# Map the menu key to slash (doesn't work when executed before keyd/kmonad)
#xmodmap -e "keycode 135 = slash"

sleep 2 && xcape -e 'Shift_R=Escape' &

sleep 5 && kdeconnect-indicator &

