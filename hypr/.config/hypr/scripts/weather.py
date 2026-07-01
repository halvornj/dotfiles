#!/usr/bin/env python3

# weather using python

import requests
import json
import os
from pyquery import PyQuery

# weather icons
weather_icons = {
    "clearsky_day": "󰖙",
    "clearsky_night":  "󰖔",

    "fair_day": "",
    "fair_night": "",
    "rainshowers_day": "",
    "rainshowers_night": "",
    "lightrain": "",
    "rain": "",
    "heavyrain": "",
    "heavyrainandthunder": "",
    "lightsleet": "",
    "sleet": "",
    "heavysleet": "",
    "lightsnow": "",
    "snow": "",
    "heavysnow": "",
    "snowandthunder": "",
    "sleetandthunder": "",
    "fog": "",
    "rainandthunder": "",
    "snowshowers_day": "",
    "snowshowers_night": "",
    "severe": "",
    "default": "",
}

# Get current location based on IP address
def get_location():
    response = requests.get("https://ipinfo.io")
    data = response.json()
    loc = data["loc"].split(",")
    return float(loc[0]), float(loc[1])
  
# Get latitude and longitude
latitude, longitude = get_location()

# Open-Meteo API endpoint
url=f"https://api.met.no/weatherapi/locationforecast/2.0/compact?lat={latitude}&lon={longitude}"

response = requests.get(url)
if(response.status_code != 200):
    exit(1)

json_response = response.text
resp_dict = json.loads(json_response)
# if index 0 is last hour, 1 is this hour, we get the average of data between [2] and [3]

first_hour = resp_dict.get("properties").get("timeseries")[2].get("data")
second_hour = resp_dict.get("properties").get("timeseries")[3].get("data")

avg_wind_speed = (first_hour.get("instant").get("details").get("wind_speed") + second_hour.get("instant").get("details").get("wind_speed")) / 2

avg_rain_amnt = (first_hour.get("next_1_hours").get("details").get("precipitation_amount") + second_hour.get("next_1_hours").get("details").get("precipitation_amount")) / 2

temp = first_hour.get("instant").get("details").get("air_temperature")

symbol_code = first_hour.get("next_1_hours").get("summary").get("symbol_code")

icon = weather_icons.get(symbol_code,"")


# print waybar module data
out_data = {
    "text": f"{icon}  {temp}°C  {avg_rain_amnt}mm  {avg_wind_speed}m/s",
    "class": symbol_code,
}
print(json.dumps(out_data))


# simple_weather = (
#     f"{icon}  {status}\n"
#     + f"  {temp} ({temp_feel_text})\n"
#     + f"{wind_text} \n"
#     + f"{humidity_text} \n"
#     + f"{visibility_text} AQI{air_quality_index}\n"
# )

# try:
#     with open(os.path.expanduser("~/.cache/.weather_cache"), "w") as file:
#         file.write(simple_weather)
# except Exception as e:
#     print(f"Error writing to cache: {e}")
