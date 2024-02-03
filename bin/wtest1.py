#!/usr/bin/env python3

# 2019-11-24
"""
"""
import sys, os, time
import json
# import datetime as datetime
import datetime

# sensor_data = {'date': 0, 'temperature': 0, 'humidity': 0}
# topicPrefix = "weather"

path_name = '/Users/ian/aaa/PiStuff/weather.log'


"""
with open(path_name, 'r') as f:
    for line in f:
        x = json.loads(line.strip())
        print(u"Date: {:s}, Temperature: {:g}\u00b0C, Humidity: {:g}%".format(x['date'], x['temperature'], x['humidity']))
        dt = datetime.datetime.strptime(x['date'], '%Y-%m-%dT%H:%M:%S')
        print(dt.date.year)
"""
x = json.loads('{"temperature": 25.0, "humidity": 72.0, "date": "2019-01-22T15:01:02"}')
t = time.strptime(x['date'], '%Y-%m-%dT%H:%M:%S') # ISO8601 to timestamp
print(t)
print("asctime", time.asctime(t))

ts = time.mktime(t)
dt = datetime.datetime.fromtimestamp(ts)     # timestamp to datetime
dd = datetime.date.fromtimestamp(ts)  # date in datetime format
print("ts", ts)
print("dt", dt)
print("dd", dd)

print(datetime.date.fromtimestamp(ts))  # date in datetime format
# print(datetime.time.fromtimestamp(ts))  # date in datetime format
# print(datetime.time(ts))
# print(datetime.date(dt))
# print(date(dt))
