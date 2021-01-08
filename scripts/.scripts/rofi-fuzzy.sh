#!/bin/sh

fd . ~ | rofi -threads 0 -dmenu -i -theme themes/style-fuzzy.rasi -p "locate:" | xargs -I {} xdg-open "{}"

