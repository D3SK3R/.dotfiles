#!/usr/bin/env python

import os
from time import sleep

cyan = '\033[36m'
blank = '\033[m'

os.system('clear')

def connect():
    print(f'{cyan}Enabling tcpip on port 5555...{blank}')
    for c in range(3):
        os.system('adb tcpip 5555')
        sleep(0.5)

    os.system('adb forward tcp:5555 tcp:5555')
    sleep(2)
    print(f'{cyan}Devices list:{blank}')
    os.system('adb devices')

    print(f'{cyan}Device\'s ip:{blank}')
    os.system('adb shell ifconfig wlan0')

    print(f'{cyan}Done. Disconnect the device from the USB port{blank}')

connect()

while True:
    choice = int(input('[1] Connect device\n[2] Run script again\n[3] Run adb kill-server and run again\n[4] Troll\n[0] Exit\n> '))

    if choice == 1:
      ip = input(f'{cyan}Devices\'s IP\n> {blank}')
      #os.system(f'adb connect {ip}')
      os.system(f'.scripts/adb_connect.sh {ip}')
    elif choice == 2:
        print('Running again...')
        sleep(1)
        os.system('clear')
        connect()
    elif choice == 3:
        print('Killing adb and running again...')
        sleep(1)
        os.system('clear')
        os.system('adb kill-server')
        connect()
    elif choice == 4:
        print('Troll...')
        sleep(1)
        os.system('clear')
        os.system('./adb_troll.sh')
    elif choice == 0:
        print('Exiting...')
        break
