#!/bin/sh

# killall <program> not always work, so I'd have to find the process id and use kill <id>, this script substitutes this.
# WARNING: it may kill the unintended processes 

# usage: 
# ./dkill.sh <process name>

# put the code inside the function and source dkill.sh to be able to use dkill <arg>
# for some reason shell script works differently when inside a function
# because of that, to be able to print the processes id and names side by side in a for loop, I need to put everything outsite the function
# dkill (){
# }
if [[ -z $1 ]]; then
    echo "Usage: dkill <process name>"
else
    pid=$(ps auxf | grep -i $1 | grep -vE "grep|sh" | awk '{print $2}')
    name=$(ps -eo user,pid,command | grep -i $1 | grep -vE "grep|sh" | awk '{print $3}')
    # pid=$(ps auxf | grep $1 | awk -F' ' '{print $2}' | tail -n +2)
    if [[ -z $pid ]]; then
        echo "process not found"
    else
        # echo "Do you really want to kill the processes\n$pid\n\n[Y/n]"
        printf "Do you really want to kill the processes:\n\n"
        i=1
        for proc in $pid; do
            echo "$proc $(echo $name | cut -d' ' -f$i)"
            i=$(($i+1))
        done
        printf "\nKill [Y/n] "
        read choice
        echo "$choice"
        if [ -z choice ] || [ "$choice" = "y" ] || [ "$choice" = "" ]; then
            kill -9 $(echo $pid) >/dev/null
            echo "Killed."
        else
            echo "Exiting without killing the processes"
        fi
    fi
fi

