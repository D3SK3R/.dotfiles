#!/bin/bash

# takes the IP as argument
ip=$1
refused=$(echo "unable to connect to "$ip":5555: Connection refused")
no_route=$(echo "failed to connect to '"$ip":5555': No route to host")
timeout=$(echo "unable to connect to "$ip":5555: Connection timed out")
argument=$(echo "unable to connect to "$ip":5555: Invalid argument")

while true; do
    # verify if theres arguments
    if [ $# -eq 0 ]; then
        echo "No arguments given"
        echo "Use ./adb_connect <ip to connect>"
        break
    fi

    # verify if theres more than 1 argument
    if [ $# -eq >= 2 ]; then
        echo "Too many arguments given"
        echo "Use ./adb_connect <ip to connect>"
        break
    fi

    # tries to connect
    adb tcpip 5555 >/dev/null 2>$1
    try=$(adb connect "$ip"":5555")

    # verify if it connected to the IP
    if [ "$try" != "$refused" ]; then
        if [ "$try" != "$no_route" ]; then
            if [ "$try" != "$timeout" ]; then
                if [ "$try" != "$argument" ]; then
                    echo "CONNECTED"
                    break
                fi
            else
                echo "Timeout"
            fi
        else
            echo "No route"
        fi
    else
        echo "Refused"
    fi
    sleep 2
done
