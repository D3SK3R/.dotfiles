#!/bin/sh

available=$(free -mt | awk -F" " 'END{ram=$3 / 1024;printf ("%.2fGB\n", ram)}')

echo "$available"

