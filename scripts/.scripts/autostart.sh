#!/bin/sh

################################################################################################
##                                         SCRIPTS                                            ##
################################################################################################

# script to change i3 layout setting
~/.scripts/alternating_layouts.py &
# alternative: https://github.com/nwg-piotr/autotiling

# script to change mouse sens
~/.scripts/mouse_sens.sh &

# set keyboard layout 
~/.scripts/keyboardLayout.sh &

# set timeout to lock the screen
xautolock -time 60 -locker ~/.scripts/lock.sh

# set keyboard repeat delay and interval
xset r rate 200 30 # first number after "rate" is delay, and second is interval

# theming?
ff-theme-util

# fix/set cursor theme
fix_xcursor

# touchpad gestures
ibinput-gestures-setup restart &

# flashfocus 
sleep 5 & flashfocus &

# Send a warning when free ram gets lower
#~/.scripts/ram_warning.sh

# Stretch notif
~/.scripts/stretch.sh &

################################################################################################
##                                         PROGRAMS                                           ##
################################################################################################

# polybar
~/.config/polybar/launch.sh &

# pulseaudio
killall pulseaudio & sleep 0.5 & pulseaudio &

# urxvt daemon
urxtv -q -o -f &

# run urxvt to use with scratchpad
urxvt -name floating_urxvt &

# restart xfce4-power-manager
kill $(ps ax | awk '/xfce4-power-manager/ {print $1}' | head -n 1);sleep 1;xfce4-power-manager &

# qutebrowser to use with scratchpad
qutebrowser &

# spotify
spotify &

# fix betterdiscord and open discord
sleep 3;betterdiscordctl update;betterdiscordctl reinstall;betterdiscordcl restart;sleep 1;discord &

# megasync
megasync &

# albert
#albert &

# dunst notification
#dunst &

# syncthing
syncthing -no-browser &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# picom
nitrogen --restore;sleep 1;picom -b &

# network-manager applet
nm-applet &

# pamac
pamac-tray &

# clipit and clipster
clipit & clipster -d &

# telegram
telegram-desktop -startintray &




