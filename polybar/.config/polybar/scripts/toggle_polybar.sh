#!/bin/sh

state=$(head -n 1 .state)
if [ $state = "on" ]; then
    echo "off" > .state
    polybar-msg cmd hide
    #xdo hide -N 'Polybar'
else
    echo "on" > .state
    polybar-msg cmd show
    #xdo show -N 'Polybar'
fi


