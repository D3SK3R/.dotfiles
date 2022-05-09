#!/bin/sh

while true;
do
    sleep 600
    dunstify -i "/usr/share/icons/Papirus-Dark/22x22/emblems/emblem-important.svg" -t 5000 "Are you doing something useful?" "\nIf not, now:\nStudy or Exercise" 
done
