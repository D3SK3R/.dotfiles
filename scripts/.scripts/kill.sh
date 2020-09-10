#!/bin/sh

# killall <program> not always work, so I'd have to find the process id and use kill <id>, this script substitutes this.

# source kill.sh to be able to use dkill <arg>
dkill (){
    if [ -z $1 ]; then
        echo "Usage: dkill <process name>"
    else
        pid=$(ps auxf | grep $1 | awk -F' ' '{print $2}' | tail -n +2)
        if [ -z $pid ]; then
            echo "process not found"
        else
        kill $(ps auxf | grep $1 | awk -F' ' '{print $2}' | tail -n +2) 2>/dev/null
        echo "killing the processes ID:\n$pid"
        fi
    fi
}

