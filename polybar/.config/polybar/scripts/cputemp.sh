#!/bin/sh

temp=$(sensors 2>/dev/null | grep Tctl | sed 's/+//g' | awk '{print $2}')

# 
echo " $temp  "
