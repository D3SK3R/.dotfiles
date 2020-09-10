#!/bin/sh

# killall <program> not always work, so I'd have to find the process id and use kill <id>, this script substitutes this.

# source kill.sh to be able to use dkill <arg>
dkill (){
    kill $(ps auxf | grep $1 | awk -F' ' '{print $2}' | tail -n +2)
    echo "killing the processes ID: $(ps auxf | grep $1 | awk -F' ' '{print $2}' | tail -n +2)"
}

#kill $(ps auxf | grep $1 | awk -F' ' '{print $2}' | tail -n +3)

