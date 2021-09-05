#!/bin/sh

available=$(free -m | awk -F" " 'NR==2 {ram=$3 / 1024;printf ("%.2fGB\n", ram)}')

echo "$available"

