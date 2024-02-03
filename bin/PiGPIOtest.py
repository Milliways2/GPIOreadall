#! /usr/bin/env python3
import os
import subprocess

import Pi.GPIO as GPIO
# print(GPIO.RPI_INFO)
print()
print("Version ", GPIO.VERSION, '\n')

GPIO.setmode(GPIO.BCM)

TestPin=0;

print(GPIO.get_alt(TestPin))
val =  GPIO.read_gpio(TestPin)
print('Test pin', TestPin, val)
GPIO.setup(TestPin, GPIO.OUT)
GPIO.output(TestPin, GPIO.HIGH)
