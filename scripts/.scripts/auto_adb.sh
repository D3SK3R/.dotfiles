#!/bin/sh

function connect() {
    printf 'Waiting for device...\n'
    usb-devices > ~/.local/a.txt
    usb-devices > ~/.local/b.txt
    a=$(cat ~/.local/a.txt)
    b=$(cat ~/.local/b.txt)

    loop='true'
    while "$loop" == 'true'; do
        if [ "$a" != "$b" ]; then
            printf "\nPhone detected, starting adb...\n"
            sleep 1
            adb -d tcpip 5555 > /dev/null
            sleep 1.5
            adb -d shell ifconfig wlan0 > ~/.local/ip.txt
            ip=$(cat .local/ip.txt | grep -e "inet addr:" | cut -d':' -f2 | cut -d' ' -f1)
            adb connect $ip:5555 > /dev/null
            printf "IP: $ip\nDone...\n\n"
            loop='false'
            rm {~/.local/a.txt,~/.local/b.txt}
            break
        else
            usb-devices > ~/.local/b.txt
            b=$(cat ~/.local/b.txt)
        fi
    done
}
connect
while true; do
    printf '[1] Info\n[2] Troll\n[3] adbe\n> '
    read -p '' action
    if [ "$action" == 1 ]; then
        adb devices
        adbe devices
    fi
    if [ "$action" == 2 ]; then
        sh ~/.scripts/adb_troll.sh
        break
    fi
    if [ "$action" == 3 ]; then
        adbe
        break
    fi
done
