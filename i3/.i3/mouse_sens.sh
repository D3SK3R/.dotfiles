#!/bin/sh
# To see all connected devices:
# xinput --list --short
while true; do
        NEW_MOUSEID=$(xinput | grep -i "Mouse" | grep -o -E 'id=[0-9]+' | head -n 1 | cut -d"=" -f2)
        NEW_MOUSEID2=$(xinput | grep -i "Mouse" | grep -o -E 'id=[0-9]+' | head -n 3 | tail -1 | cut -d"=" -f2)
        if [ "$MOUSEID" != "$NEW_MOUSEID" ]; then
                MOUSEID=$NEW_MOUSEID
                if [ "$MOUSEID" != "" ]; then
                        xinput --set-prop "$MOUSEID" "libinput Accel Speed" -0.9
                        echo "1 $MOUSEID"
                fi
        fi
        if [ "$MOUSEID2" != "$NEW_MOUSEID2" ]; then
                MOUSEID2=$NEW_MOUSEID2
                if [ "$MOUSEID2" != "" ]; then
                        xinput --set-prop "$MOUSEID2" "libinput Accel Speed" -0.9
                        echo "2 $MOUSEID2"
                fi
        fi
        sleep 2
done &
