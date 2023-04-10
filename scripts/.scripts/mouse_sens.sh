#!/bin/sh

# A better way of doing this:
# sudo vim /usr/share/X11/xorg.conf.d/40-libinput.conf
# find the identifier "libinput ponter catchall"
# add the line (before the Driver line):
# Option "AccelSpeed" "-0.8"

# To see all connected devices:
# xinput --list --short

ids=$(xinput list --short | \grep -i mouse | cut -d"=" -f2 | awk '{print $1}')

for id in $ids; do
  echo "setting for: $id"
  xinput --set-prop "$id" "libinput Accel Speed" -0.8
  printf "\n"
done

# while true; do
#         NEW_MOUSEID=$(xinput | grep -i "Mouse" | grep -o -E 'id=[0-9]+' | head -n 1 | cut -d"=" -f2)
#         NEW_MOUSEID2=$(xinput | grep -i "Mouse" | grep -o -E 'id=[0-9]+' | head -n 3 | tail -1 | cut -d"=" -f2)
#         if [ "$MOUSEID" != "$NEW_MOUSEID" ]; then
#                 MOUSEID=$NEW_MOUSEID
#                 if [ "$MOUSEID" != "" ]; then
#                         xinput --set-prop "$MOUSEID" "libinput Accel Speed" -0.8
#                         echo "1 $MOUSEID"
#                 fi
#         fi
#         if [ "$MOUSEID2" != "$NEW_MOUSEID2" ]; then
#                 MOUSEID2=$NEW_MOUSEID2
#                 if [ "$MOUSEID2" != "" ]; then
#                         xinput --set-prop "$MOUSEID2" "libinput Accel Speed" -0.8
#                         echo "2 $MOUSEID2"
#                 fi
#         fi
#         sleep 4
# done &
