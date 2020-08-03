#!/bin/sh

mpc -p 1100 seek 0;mpc -p 1100 pause

playing=$(mpc -p 1100 | head -n 1)

dunstify -t 2000 " Stopping..." "$playing" -p 1100 -r 1100
