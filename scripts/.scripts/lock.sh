#!/bin/bash

mpc -p 1100 seek 0 && mpc -p 1100 pause &
playerctl stop && betterlockscreen -l blur 
