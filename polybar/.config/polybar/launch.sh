#!/usr/bin/env sh

# More info : https://github.com/jaagr/polybar/wiki

# Install the following applications for polybar and icons in polybar
# awesome-terminal-fonts
# Tip: There are other interesting fonts that provide icons like nerd-fonts-complete

# Terminate already running bar instances
killall -q -s 9 polybar

# Wait until the processes have been shut down
#while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

# Monitors
PRIMARY=$(xrandr --query | grep " connected" | grep "primary" | cut -d" " -f1)
OTHERS=$(xrandr --query | grep " connected" | grep -v "primary" | cut -d" " -f1)

if type "xrandr" > /dev/null; then
    MONITOR=$PRIMARY polybar --reload main -c ~/.config/polybar/config.ini &
    # sleep necessary so that the bar on the main monitor loads first and takes the tray output
    # *only necessary if using 1 bar for two monitors, if not, just leave the tray enable on only 1 monitor
    #sleep 1
    for m in $OTHERS; do
        MONITOR=$m polybar --reload main2 -c ~/.config/polybar/config.ini &
    done
else
    polybar --reload main -c ~/.config/polybar/config.ini &
fi

# fixing top padding BSPWM
sleep 0.6 && bspc config top_padding 22 &

# hooks for scripts:
sleep 0.8 && polybar-msg action "#mute.hook.0" >/dev/null &
sleep 0.8 && polybar-msg action "#target.hook.0" >/dev/null &

#count=$(xrandr --query | grep " connected" | cut -d" " -f1 | wc -l)
#desktop=$(echo $DESKTOP_SESSION)
#case $desktop in
#    i3)
#    if type "xrandr" > /dev/null; then
#        MONITOR=$PRIMARY polybar --reload main -c ~/.config/polybar/config &
#        # sleep necessary so that the bar on the main monitor loads first and takes the tray output
#        sleep 1
#        for m in $OTHERS; do
#            MONITOR=$m polybar --reload main -c ~/.config/polybar/config &
#        done
#    else
#    polybar --reload main -c ~/.config/polybar/config &
#    fi
#    ;;
#    openbox)
#    if type "xrandr" > /dev/null; then
#      for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
#        MONITOR=$m polybar --reload mainbar-openbox -c ~/.config/polybar/config &
#      done
#    else
#    polybar --reload mainbar-openbox -c ~/.config/polybar/config &
#    fi
##    if type "xrandr" > /dev/null; then
##      for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
##        MONITOR=$m polybar --reload mainbar-openbox-extra -c ~/.config/polybar/config &
##      done
##    else
##    polybar --reload mainbar-openbox-extra -c ~/.config/polybar/config &
##    fi
#
#    ;;
#    bspwm)
#    if type "xrandr" > /dev/null; then
#      for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
#        MONITOR=$m polybar --reload mainbar-bspwm -c ~/.config/polybar/config &
#      done
#    else
#    polybar --reload mainbar-bspwm -c ~/.config/polybar/config &
#    fi
#    ;;
#
#    xmonad)
#    if [ $count = 1 ]; then
#      m=$(xrandr --query | grep " connected" | cut -d" " -f1)
#      MONITOR=$m polybar --reload mainbar-xmonad -c ~/.config/polybar/config &
#    else
#      for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
#        MONITOR=$m polybar --reload mainbar-xmonad -c ~/.config/polybar/config &
#      done
#    fi
#    ;;
#esac

#for future scripts - how to find interface
#interface=$(ip route | grep '^default' | awk '{print $5}' | head -n1)
#interface-name=$(ip route | grep '^default' | awk '{print $5}')
#interface-name=$(ifconfig -a | sed -n 's/^\([^ ]\+\).*/\1/p' | grep -Fvx -e lo:| sed 's/.$//')
