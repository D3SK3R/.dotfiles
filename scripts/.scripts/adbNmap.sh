phone=$@
if [ -z "$phone" ]; then
    phone="samsung"
    adb="true"
else
    #adb="false"
    echo "enabling adb connect" > /dev/null
fi
while true; do
    clear
    printf "Looking for $phone in the network\n"
    scan="$(sudo nmap -sn 192.168.15.1/24 | grep -i -e $phone)"
    scan2="$(sudo nmap -sn 192.168.0.1/24 | grep -i -e $phone)"
    if [ -z "$scan" ]; then
        if [ -z "$scan2" ]; then
            sleep 0.5
        else
            printf "\n### 192.168.0.1 ###\n\n$(sudo nmap -sn 192.168.0.1/24)\n"
            if [ "$adb" == "true" ]; then
                adb connect 192.168.0.101
            fi
            notify-send Finished;mpg123 -q /home/d3sk3r/.scripts/ding-notif.mp3
            break
        fi
    else
        printf "\n### 192.168.15.1 ###\n\n$(sudo nmap -sn 192.168.15.1/24)\n"
        if [ "$adb" == "true" ]; then
            adb connect 192.168.15.48:5555
        fi
        notify-send Finished;mpg123 -q /home/d3sk3r/.scripts/ding-notif.mp3
        break
    fi
done
