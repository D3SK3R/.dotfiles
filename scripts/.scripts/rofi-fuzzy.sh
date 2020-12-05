#!/bin/sh

fd . ~ | rofi -threads 0 -dmenu -i -theme themes/fuzzy-material -p "locate:" | xargs -I {} xdg-open "{}"

