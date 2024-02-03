#!/usr/bin/env python3

# 2019-11-27
"""
"""
import sys, os, time
import json
# import datetime as datetime
import datetime

# sensor_data = {'date': 0, 'temperature': 0, 'humidity': 0}
# topicPrefix = "weather"

path_name = '/Users/ian/aaa/PiStuff/weather.log'

D = {}

with open(path_name, 'r') as f:
    for line in f:
        x = json.loads(line.strip())
#         print(u"Date: {:s}, Temperature: {:g}\u00b0C, Humidity: {:g}%".format(x['date'], x['temperature'], x['humidity']))
#         dt = datetime.datetime.strptime(x['date'], '%Y-%m-%dT%H:%M:%S')
#         print(dt.date.year)
        temp = x['temperature']
        t = time.strptime(x['date'], '%Y-%m-%dT%H:%M:%S') # ISO8601 to struct_time
        ts = time.mktime(t)     # struct_time to timestamp
        dt = datetime.datetime.fromtimestamp(ts)     # timestamp to datetime
        dd = datetime.date.fromtimestamp(ts)  # date in datetime format
#         print("dd", dd)
        try:
#             D[dd] += 1
            mn, mx = D[dd]
            D[dd] = (min(mn, temp), max(mn, temp))
        except KeyError:
#             D[dd] = 1
            D[dd] = (temp, temp)

# print(D)
# print(D.items())


for key in D:
    print (key, D[key])



# x = json.loads('{"temperature": 25.0, "humidity": 72.0, "date": "2019-01-22T15:01:02"}')
# t = time.strptime(x['date'], '%Y-%m-%dT%H:%M:%S') # ISO8601 to timestamp
# print(t)
# print("asctime", time.asctime(t))
#
# ts = time.mktime(t)
# dt = datetime.datetime.fromtimestamp(ts)     # timestamp to datetime
# dd = datetime.date.fromtimestamp(ts)  # date in datetime format
# print("ts", ts)
# print("dt", dt)
# print("dd", dd)
#
# print(datetime.date.fromtimestamp(ts))  # date in datetime format
# # print(datetime.time.fromtimestamp(ts))  # date in datetime format
# # print(datetime.time(ts))
# # print(datetime.date(dt))
# # print(date(dt))
