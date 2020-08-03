#!/bin/sh

mpc -p 1100 seek 0;mpc -p 1100 cdprev

playing=$(mpc -p 1100 | head -n 1)

dunstify -t 2000 " Previous..." "$playing" -p 1100 -r 1100
