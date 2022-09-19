#!/usr/bin/env bash

# rofi-power
# Use rofi to call systemctl for shutdown, reboot, etc

# 2016 Oliver Kraitschy - http://okraits.de

uptime=$(uptime -p | sed -e 's/up //g')

#OPTIONS="Reboot system\nPower-off system\nSuspend system\nHibernate system"
#OPTIONS=" Lock\n Sleep\n Logout\n Restart\n Shutdown"
OPTIONS=" LOCK\n SLEEP\n LOGOUT\n REBOOT\n SHUTDOWN"

# source configuration or use default values
if [ -f $HOME/.config/rofi-power/config ]; then
  source $HOME/.config/rofi-power/config
else
  #LAUNCHER="rofi -width 30 -dmenu -i -p rofi-power:"
  # LAUNCHER="rofi -dmenu -i -f 'DejaVu Sans Mono 12' -theme themes/style-power.rasi"
  LAUNCHER="rofi -dmenu -i -f 'DejaVu Sans Mono 12' -theme themes/power.rasi"
  USE_LOCKER="false"
  LOCKER="/home/d3sk3r/.i3/lock.sh"
fi

# Show exit wm option if exit command is provided as an argument
if [ ${#1} -gt 0 ]; then
  OPTIONS="Exit window manager\n$OPTIONS"
fi

option=`echo -e $OPTIONS | $LAUNCHER -mesg "uptime: $uptime" | awk '{print $2}' | tr -d '\r\n'`
if [ ${#option} -gt 0 ]
then
    case $option in
      Exit)
        eval $1
        ;;
      LOCK)
       ~/.scripts/lock.sh 
        ;;
      SLEEP)
        sleep 0.5;systemctl suspend
        #sleep 0.5;xset dpms force off
        ;;
      LOGOUT)
        bspc quit
        ;;
      REBOOT)
        systemctl reboot
        ;;
      SHUTDOWN)
        systemctl poweroff
        ;;
      *)
        ;;
    esac
fi
