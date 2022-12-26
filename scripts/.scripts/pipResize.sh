#!/bin/sh

# make a window picture-in-picture size
# and move it to the top-right corner.
# execute again hovering the same window
# and it will disable the pip mode
node="$(bspc query -N -n ${1:-focused})" || exit 1
wid="$(xdotool getwindowfocus)" || exit 1
state=$(bspc query -n $node --tree | jq -r '.client["state"]') || exit 1
#desktop="$(bspc query -d -d focused --names)"

file="/tmp/pipresize"

# check if the window is in tiled mode
if [[ "$state" == "tiled" ]]; then
  # check if the file exists
  if [[ -f "$file" ]]; then 
    # if it does, reads every line from that file
    while read line; do
      # if a line is "1", it knows there's already a pip window
      if [[ "$line" =~ ^1.* ]]; then
        if [[ "$line" =~ ^2.* ]]; then
          dunstify "both spots already taken"
        else
          dunstify "moving window to second spot"
          bspc node $node -t floating --flag sticky=on

          xdotool windowsize $wid 302 170 &

          xdotool windowmove $wid 2971 221 &

          echo "2 $wid" >> $file
          exit
        fi
      # if not, it knows it's the first window
      else
        dunstify "moving window to the first spot"
        bspc node $node -t floating --flag sticky=on

        xdotool windowsize $wid 302 170 &

        xdotool windowmove $wid 2971 31 &

        # writes "1" to that file to show there's a pip window
        echo "1 $wid" >> $file
        exit
      fi
    done < $file
  # if there's no file, create one and then move window 
  else
    dunstify "moving window to the first spot"
    bspc node $node -t floating --flag sticky=on

    xdotool windowsize $wid 302 170 &

    xdotool windowmove $wid 2971 31 &
    echo "1 $wid" > $file
  fi
# if the window is floating, means it's the pip so it restores it
else
  while read line; do
    opened="$(echo $line | awk '{print $2}')"
    # spot="echo $line | awk '{print $1}'"
    # checks if that floating window is in the file
    if [[ "$wid" == "$opened" ]]; then
      # if it is, it deletes it's line 
      # sed -i "s/$line/ /g" $file
      sed -ire "s/$line//g;/^\s*\$/d" $file
    fi
  done < $file

  bspc node $node -d 2

  bspc node $node -t tiled --flag sticky=off

  # if the file is empty
  if ! [[ -s "$file" ]]; then
    rm $file
  fi
fi
 


# if [[ "$state" == "tiled" ]]; then
#   # if the file doesn't exist (-f to if it exists)
#   if [[ -z $file ]]; then
#     dunstify "file doesn't exist, moving to first spot"
#     bspc node $node -t floating --flag sticky=on
#
#     xdotool windowsize $wid 302 170 &
#
#     xdotool windowmove $wid 2971 31 &
#     
#     sleep 0.2 && touch $file &
#   else
#     dunstify "file exists, moving to second spot"
#     bspc node $node -t floating --flag sticky=on
#
#     xdotool windowsize $wid 302 170 &
#
#     xdotool windowmove $wid 2971 221
#   fi
# else
#   bspc node $node -d 2
#
#   bspc node $node -t tiled --flag sticky=off
#
#   rm $file
# fi

