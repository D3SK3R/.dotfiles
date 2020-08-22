#!/usr/bin/env bash

# rofi-power
# Use rofi to call systemctl for shutdown, reboot, etc

# 2016 Oliver Kraitschy - http://okraits.de

#OPTIONS="Reboot system\nPower-off system\nSuspend system\nHibernate system"
#OPTIONS=" Lock\n Sleep\n Logout\n Restart\n Shutdown"
OPTIONS=" LOCK\n\n SLEEP\n\n LOGOUT\n\n REBOOT\n\n SHUTDOWN"

# source configuration or use default values
if [ -f $HOME/.config/rofi-power/config ]; then
  source $HOME/.config/rofi-power/config
else
  #LAUNCHER="rofi -width 30 -dmenu -i -p rofi-power:"
  LAUNCHER="rofi -dmenu -i -f 'Roboto Mono 12'"
  USE_LOCKER="false"
  LOCKER="/home/d3sk3r/.i3/lock.sh"
fi

# Show exit wm option if exit command is provided as an argument
if [ ${#1} -gt 0 ]; then
  OPTIONS="Exit window manager\n$OPTIONS"
fi

option=`echo -e $OPTIONS | $LAUNCHER | awk '{print $2}' | tr -d '\r\n'`
if [ ${#option} -gt 0 ]
then
    case $option in
      Exit)
        eval $1
        ;;
      LOCK)
        sleep 0.5;betterlockscreen -l blur;mpc -p 1100 seek 0 && mpc -p 1100 pause
        ;;
      SLEEP)
        sleep 0.5;i3exit suspend
        ;;
      LOGOUT)
        i3exit logout
        ;;
      REBOOT)
        i3exit reboot
        ;;
      SHUTDOWN)
        i3exit shutdown
        ;;
      *)
        ;;
    esac
fi
