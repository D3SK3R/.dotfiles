#!/bin/sh

temp=$(sensors | grep Tctl | sed 's/+//g' | awk '{print $2}')

# 
echo " $temp "
