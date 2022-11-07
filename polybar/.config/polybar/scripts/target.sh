#!/bin/zsh

# source ~/.scripts/target
targetip=/tmp/targetip
if [[ -f $targetip ]]; then
  IP=$(cat $targetip)
  echo " Target: $IP"
else
  echo ""
fi


