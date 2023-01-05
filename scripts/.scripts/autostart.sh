#!/bin/sh

# function to check if the program is already running
# if not, run it with an & in the end
function run {
    if ! pgrep $1; then
        $@&
    fi
}

run dunst
dunstify -i "/usr/share/icons/Papirus-Dark/16x16/emblems/checkmark.svg" "Running autostart script" &

#######################
###     scripts     ###
#######################

# BSPWM Monitors setup
# if xrandr | grep -ow "HDMI-0 connected" >/dev/null; then
if [ $(xrandr | grep -ow "connected" | wc -l) -ge 2 >/dev/null ]; then
    autorandr --change &
    sleep 1.5 && bspc desktop 2 --focus &
    sleep 1.7 && bspc desktop 1 --focus &
else
    run autorandr
    bspc monitor -d 1 2 3 4 5 6 7 8 9
    #sleep 3
    sleep 2 && $HOME/.config/polybar/launch.sh &
fi
# everything about monitors is commented
# since I'm using autorandr that executed all of this
#$HOME/.config/bspwm/monitors-bspwm &

$HOME/.scripts/keyboardSet &

# id="$(xinput --list | \grep "G403" | \grep -v "Keyboard" | awk '{print $8}' | cut -d'=' -f2)" && \
  # xinput --set-prop "$id" "libinput Accel Speed" -0.7 &

#sleep 0.7 && $HOME/.scripts/headset-configure &

sleep 10 && polybar-msg action "#mute.hook.0" >/dev/null &
sleep 10 && polybar-msg action "#target.hook.0" >/dev/null &
#######################
###    programs     ###
#######################
xrdb -merge $HOME/.Xresources &

start-pulseaudio-x11 &

#run mpd

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

sleep 3 && spotify & killall mpd &

# sleep 2 && urxvt -title ncmpcpp -e ncmpcpp &
# sleep 2 && st -T ncmpcpp -e ncmpcpp &

nitrogen --restore &

# picom -b --experimental-backend &
picom &

sleep 3 && flashfocus &

# disable the autostart option inside copyq's preferences
sleep 4 && copyq &

# floating stuff
# sleep 2 && urxvt -title floating_terminal &
sleep 2 && st -T floating_terminal &
# sleep 2 && urxvt -title floating_terminal2 &
sleep 2 && st -T floating_terminal2 &

#sleep 5 && firefox &

# sleep 3 && discord & #premid &

#sh $HOME/.scripts/better.sh &
# sh $HOME/.scripts/water.sh &

#sleep 5 && kdeconnect-indicator &

light -I &

~/.scripts/cpuBoost &

prime-offload &

eww -c ~/.config/eww/fool_moon/menu/ daemon & 
eww -c ~/.config/eww/fool_moon/meters/ daemon &

