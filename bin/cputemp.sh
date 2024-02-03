#! /usr/bin/env python
import os
import time

time.sleep(1)
# CPU frequency - do this first hoping to catch idle frequency
f = os.popen('vcgencmd measure_clock arm').readline()
freq = int( f.replace("frequency(48)=", "").replace("\n", ""))/1000000

from collections import OrderedDict
import json

# Find Pi model (This may fail on some Pis?)
file = open("/sys/firmware/devicetree/base/model", "r")
model = file.read().rstrip(' \t\r\n\0')
file.close()

# USB3 Host firmware version
# f = os.popen('sudo /home/pi/vl805').readline()
# firm = f.replace("\n", "").split(": ")[1]

# CPU Temp
t = os.popen('vcgencmd measure_temp').readline()
temp = float(t.replace("temp=","").replace("'C\n",""))

## Output as JSON
jsonData = json.dumps(OrderedDict([
    ("model", model),
#     ("firmware", firm),
    ("temperature", temp),
    ("frequency", freq)
]))
print(jsonData)
