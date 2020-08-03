#!/bin/bash

#!/bin/bash

# Option 1:
# https://github.com/haikarainen/light
#light -A 1

# Option 2:
# yay xorg-xbacklight
xbacklight -dec 1

# Option 3: BEST if it worked...
#sh ~/.scripts/brightness.sh -

current=$(light -G)

dunstify -t 1000 "Brightness -1%" "Current brightness: $current" -p 2 -r 2
