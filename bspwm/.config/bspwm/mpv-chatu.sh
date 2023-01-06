#!/bin/sh

bspc subscribe node_add | while read -r _ _ _ _ node; 
do
    name=$(xprop -id "$node" | cut -d'"' -f2 | grep -E ".* [0-9]*:[0-9]* - mpv")
    if [[ ! -z $(echo $name | grep -E ".* [0-9]*:[0-9]* - mpv") ]]; then
        bspc node $node -d 2
    fi
done
