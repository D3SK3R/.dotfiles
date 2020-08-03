#!/bin/sh

amixer -D pulse sset Master 2%-

#current=$(pacmd list-sinks | grep -A 15 "index: 0" | grep 'volume:' | grep -E -v 'base volume:' | awk -F : '{print $3}' | grep -o -P '.{0,3}%'| sed s/.$// | tr -d ' ')

current=$(pacmd list-sinks | grep -A 15 "index: " | grep 'volume:' | grep -E -v 'base volume:' | awk -F : '{print $3}' | grep -o -P '.{0,3}%'| sed s/.$// | tr -d ' ')

dunstify -t 1000 "Volume -2%" "Current volume: $current" -p 1 -r 1
