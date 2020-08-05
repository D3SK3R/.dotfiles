#!/bin/sh

state=$(head -n 1 .state)
if [ $state = "on" ]; then
    echo "off" > .state
    xdo hide -N 'Polybar'
else
    echo "on" > .state
    xdo show -N 'Polybar'
fi


# Other way to do it.
#state=$(ls | grep togglestate)
#if [ -z $state ]; then
#    touch togglestate
#    xdo hide -N 'Polybar'
#else
#    rm togglestate
#    xdo show -N 'Polybar'
#fi

