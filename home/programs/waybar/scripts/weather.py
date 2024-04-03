#!/usr/bin/env python

import json
import requests
from datetime import datetime

WEATHER_CODES = {
    '113': '',  # 🌈 Rainbow
    '116': '',  # ⛅️ Partly Cloudy
    '119': '',  # ☁️ Cloudy
    '122': '',  # ☁️ Cloudy
    '143': '',  # 🌫 Mist
    '176': '',  # 🌦 Showers
    '179': '',  # 🌧 Light Rain
    '182': '',  # 🌧 Light Rain
    '185': '',  # 🌧 Light Rain
    '200': '',  # ⛈ Thunderstorm
    '227': '',  # 🌨 Snow
    '230': '',  # ❄️ Snowflake
    '248': '',  # 🌫 Fog
    '260': '',  # 🌫 Fog
    '263': '',  # 🌦 Light Showers
    '266': '',  # 🌦 Light Showers
    '281': '',  # 🌧 Light Rain
    '284': '',  # 🌧 Light Rain
    '293': '',  # 🌦 Light Showers
    '296': '',  # 🌦 Light Showers
    '299': '',  # 🌧 Light Rain
    '302': '',  # 🌧 Light Rain
    '305': '',  # 🌧 Light Rain
    '308': '',  # 🌧 Light Rain
    '311': '',  # 🌧 Light Rain
    '314': '',  # 🌧 Light Rain
    '317': '',  # 🌧 Light Rain
    '320': '',  # 🌨 Snow
    '323': '',  # 🌨 Snow
    '326': '',  # 🌨 Snow
    '329': '',  # ❄️ Snowflake
    '332': '',  # ❄️ Snowflake
    '335': '',  # ❄️ Snowflake
    '338': '',  # ❄️ Snowflake
    '350': '',  # 🌧 Light Rain
    '353': '',  # 🌦 Light Showers
    '356': '',  # 🌧 Light Rain
    '359': '',  # 🌧 Light Rain
    '362': '',  # 🌧 Light Rain
    '365': '',  # 🌧 Light Rain
    '368': '',  # 🌨 Snow
    '371': '',  # ❄️ Snowflake
    '374': '',  # 🌧 Light Rain
    '377': '',  # 🌧 Light Rain
    '386': '',  # ⛈ Thunderstorm
    '389': '',  # 🌩 Lightning
    '392': '',  # ⛈ Thunderstorm
    '395': '',  # ❄️ Snowflake
}

data = {}


weather = requests.get("https://wttr.in/?format=j1").json()


def format_time(time):
    return time.replace("00", "").zfill(2)


def format_temp(temp):
    return (hour['FeelsLikeC']+"°").ljust(3)


def format_chances(hour):
    chances = {
        "chanceoffog": "Fog",
        "chanceoffrost": "Frost",
        "chanceofovercast": "Overcast",
        "chanceofrain": "Rain",
        "chanceofsnow": "Snow",
        "chanceofsunshine": "Sunshine",
        "chanceofthunder": "Thunder",
        "chanceofwindy": "Wind"
    }

    conditions = []
    for event in chances.keys():
        if int(hour[event]) > 0:
            conditions.append(chances[event]+" "+hour[event]+"%")
    return ", ".join(conditions)


data['text'] = WEATHER_CODES[weather['current_condition'][0]['weatherCode']] + \
    " "+weather['current_condition'][0]['FeelsLikeC']+"°"

data['tooltip'] = f"<b>{weather['current_condition'][0]['weatherDesc'][0]['value']} {weather['current_condition'][0]['temp_C']}°C</b>\n"
data['tooltip'] += f"Feels like: {weather['current_condition'][0]['FeelsLikeC']}°C\n"
data['tooltip'] += f"Wind: {weather['current_condition'][0]['windspeedKmph']}Km/h\n"
data['tooltip'] += f"Humidity: {weather['current_condition'][0]['humidity']}%\n"
for i, day in enumerate(weather['weather']):
    data['tooltip'] += f"\n<b>"
    if i == 0:
        data['tooltip'] += "Today, "
    if i == 1:
        data['tooltip'] += "Tomorrow, "
    data['tooltip'] += f"{day['date']}</b>\n"
    data['tooltip'] += f"⬆️ {day['maxtempC']}° ⬇️ {day['mintempC']}° "
    data['tooltip'] += f"🌅 {day['astronomy'][0]['sunrise']} 🌇 {day['astronomy'][0]['sunset']}\n"
    for hour in day['hourly']:
        if i == 0:
            if int(format_time(hour['time'])) < datetime.now().hour-2:
                continue
        data['tooltip'] += f"{format_time(hour['time'])} {WEATHER_CODES[hour['weatherCode']]} {format_temp(hour['FeelsLikeC'])} {hour['weatherDesc'][0]['value']}, {format_chances(hour)}\n"


print(json.dumps(data))

