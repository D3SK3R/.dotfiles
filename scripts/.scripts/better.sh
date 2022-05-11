#!/bin/sh

while true;
do
    minutes=30
    sleep $((60*minutes))
    dunstify -i "/usr/share/icons/Papirus-Dark/22x22/emblems/emblem-important.svg" -t 5000 "Are you doing something useful?" "\nIf not, now:\nStudy or Exercise" 
done
