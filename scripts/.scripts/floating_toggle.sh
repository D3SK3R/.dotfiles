#!/usr/bin/env bash

# usage:
# sh floating_toggle.sh --name floating_terminal
# or
# sh floating_toggle.sh --class Spotify

property=$1
program=$2

id=$(xdotool search $property "$program$" | head -n1)

if [ "$id" != "" ]; then
  bspc node "$id" --flag hidden -f
fi
