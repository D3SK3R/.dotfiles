#!/bin/sh

# killall <program> not always work, so I'd have to find the process id and use kill <id>, this script substitutes this.
# todo: write this as a function to source it and be able to kill using it without having ./kill.sh

kill $(ps auxf | grep $1 | awk -F' ' '{print $2}' | tail -n +3)

