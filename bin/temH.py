#!/usr/bin/env python3

# 2020-10-30
"""
    A Program to read the temperature/humidity from MQTT BROKER
"""

import paho.mqtt.client as mqtt
import json

# BROKER = 'localhost'
BROKER = 'MilliwaysPiPlus.local'

topicPrefix = "weather"

import sys
from datetime import datetime, date, time

def process__connect(client, userdata, flags, rc): #called when the broker responds to our connection
    print("Connection returned " + str(rc))

# Function to process received message
def process_message(client, userdata, message):
    sensor_data = json.loads(message.payload.decode("utf-8"))
    dt = datetime.fromisoformat(sensor_data['date'])
#     print(u"Date: {}, Temperature: {:g}\u00b0C, Humidity: {:g}%".format(dt, sensor_data['temperature'], sensor_data['humidity']))
    print(u"Time: {}, Temperature: {:g}\u00b0C, Humidity: {:g}%".format(dt.time(), sensor_data['temperature'], sensor_data['humidity']))
    client.disconnect() # disconnect after receiving 1 message

client = mqtt.Client()  # Create client
# client.on_connect = process__connect

client.connect(BROKER)  # Connect to broker
client.on_message = process_message # Assign callback function
client.subscribe(topicPrefix)   # Subscriber to topic
client.loop_forever()
