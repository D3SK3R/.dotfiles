#!/bin/python
# -*- coding: utf-8 -*-

# Procedure
# Surf to https://openweathermap.org/city
# Fill in your CITY
# e.g. Antwerp Belgium
# Check url
# https://openweathermap.org/city/2803138
# you will the city code at the end
# create an account on this website
# create an api key (free)
# LANG included thanks to krive001 on discord
### Campinas: https://openweathermap.org/city/3467865

import urllib.request
import requests

campinas = "3467865"
americana = "3472343"

CITY = campinas
API_KEY = "756edce7e9d4c385ef9499a53492678c"
# MY API
#API_KEY = "f4546886d043bccd6654cbf00230cf9c"
UNITS = "Metric"
UNIT_KEY = "C"
#UNIT_KEY = "F"
LANG = "en"


network = True

try: urllib.request.urlopen("http://google.com")
except urllib.error.URLError as e:
    network = False

if network == True:
    REQ = requests.get("http://api.openweathermap.org/data/2.5/weather?id={}&lang={}&appid={}&units={}".format(CITY, LANG,  API_KEY, UNITS))
    try:
        # HTTP CODE = OK
        if REQ.status_code == 200:
            CURRENT = REQ.json()["weather"][0]["description"].capitalize()
            TEMP = int(float(REQ.json()["main"]["temp"]))
            #print("{}, {} °{}".format(CURRENT, TEMP, UNIT_KEY))
            print(" {} °{}".format(TEMP, UNIT_KEY))
        else:
#            print("Error: BAD HTTP STATUS CODE " + str(REQ.status_code))
            print("No Data")
    except (ValueError, IOError):
        print("Error: Unable print the data")
else:
    print('N/A')
