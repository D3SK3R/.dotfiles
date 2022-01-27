#!/bin/sh

# Script to restart the USB port my Headset is in so that I don't have to re-insert it every time I boot

# to run as root on start up
#$ sudo crontab -e
# add this line:
# @reboot yourScriptPath
# OR
# Include the command in /etc/rc.local

~/.scripts/usbreset > /tmp/usb

device=$(cat /tmp/usb | grep Headset | cut -d' ' -f4 | cut -d':' -f1)

rm /tmp/usb

#echo $device

sudo ~/.scripts/usbreset /dev/bus/usb/001/$device


