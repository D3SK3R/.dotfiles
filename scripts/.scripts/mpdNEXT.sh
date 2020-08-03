#!/bin/sh

mpc -p 1100 next

playing=$(mpc -p 1100 | head -n 1)

dunstify -t 2000 " Next..." "$playing" -p 1100 -r 1100
