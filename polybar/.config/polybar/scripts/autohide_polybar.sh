#!/usr/bin/env python
import time
import subprocess
import re
import logging

SCREEN_HEIGHT = 800
# default: 30
PERCENT_LIMIT = 95
SHOW_CMD = 'xdo show -N "Polybar"'
HIDE_CMD = 'xdo hide -N "Polybar"'
#SHOW_CMD = 'xdotool search --name Polybar windowmove --relative -- 0 30'
#HIDE_CMD = 'xdotool search --name Polybar windowmove --relative -- 0 -30'

logging.basicConfig(level=logging.INFO)

def get_y_position():
    xdotool_output = subprocess.check_output(
        'xdotool getmouselocation --shell',
        shell=True).decode('utf-8')
    return int(re.search(r'Y=(\d{1,})', xdotool_output).groups()[0]) + 1

hidden = True
subprocess.call(HIDE_CMD, shell=True)
while True:
    y = get_y_position()
    time.sleep(.10)
    on_edge = y < SCREEN_HEIGHT / PERCENT_LIMIT
    logging.info("Got height %d. On edge: %s", y, str(on_edge))
    if on_edge and hidden:
        subprocess.call(SHOW_CMD, shell=True)
        hidden = False
    if (not on_edge) and (not hidden):
        subprocess.call(HIDE_CMD, shell=True)
        hidden = True
