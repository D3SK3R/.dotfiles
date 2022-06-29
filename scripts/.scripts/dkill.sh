#!/bin/sh

# killall <program> not always work, so I'd have to find the process id and use kill <id>, this script substitutes this.
# WARNING: it may kill the unintended processes 

# usage: 
# source dkill.sh
# then:
# dkill <process name to be killed>

# put the code inside the function and source dkill.sh to be able to use dkill <arg>
dkill (){
    if [ -z $1 ]; then
        echo "Usage: dkill <process name>"
    else
        pid=$(ps auxf | grep $1 | awk -F' ' '{print $2}' | tail -n +2)
        if [ -z $pid ]; then
            echo "process not found"
        else
            echo "Do you really want to kill the processes\n$pid\n\n[Y/n]"
            read choice
            if [ -z choice ] || [ "$choice" = "y" ] || [ "$choice" = "" ]; then
                kill -9 $(echo $pid)
                #kill $(ps auxf | grep $1 | awk -F' ' '{print $2}' | tail -n +2) 2>/dev/null
                #echo "killing the processes ID:\n$pid"
                echo "Killed."
            else
                echo "Exiting without killing the processes"
            fi
        fi
    fi
}

