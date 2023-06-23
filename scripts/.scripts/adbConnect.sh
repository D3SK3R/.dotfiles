#!/bin/sh

adb kill-server 2>/dev/null
adb start-server 2>/dev/null

isConnected=$(adb devices | head -2 | tail -1)
# keep trying to detect the device
# when the device is found, the loop exits
while [[ $isConnected == "" ]]; do 
  # echo "not connected, retrying"
  isConnected=$(adb devices | head -2 | tail -1)
  sleep 0.5
done

echo "Device connected"

while true; do
  if [[ $(adb tcpip 5555 2>/dev/null) ]]; then
    break
  fi
done

adb tcpip 5555 2>/dev/null
read -p "Press Enter after allowing it on the phone..."

deviceip=$(adb shell ip a | grep -w inet | tail -1 | awk '{sub(/\/.*/, "", $2);print $2}')
printf "\nDevice's IP: $deviceip\n"

adb connect $deviceip:5555
adb devices


