#!/bin/sh

# Minimum memory limit, MB
minimum=1000

# Check interval, sec
interval=60

while true; do
    free=$(free -m|awk '/^Mem:/{print $7}')

    message="Free memory: $free MB"

    if [ "$free" -lt "$minimum" ]; then
        notify-send -u critical "Memory running out!" "$message"
        #mpg123 -q /home/d3sk3r/.scripts/ding-notif.mp3
    fi

    echo $message
    sleep $interval
done
