#! /usr/bin/env python3
"""
Test Events
This version for Pi.GPIO - an enhanced RPi.GPIO
"""
import sys, os, time
# import pause
from signal import pause
import Pi.GPIO as GPIO

SigIN = 15
GPIO.setmode(GPIO.BCM)

GPIO.setup(SigIN, GPIO.IN, pull_up_down=GPIO.PUD_UP)

# wait for up to 5 seconds for a rising edge (timeout is in milliseconds)
# channel = GPIO.wait_for_edge(SigIN, GPIO.RISING, timeout=5000)
# if channel is None:
#     print('Timeout occurred')
# else:
#     print('Edge detected on channel', channel)
#
# GPIO.remove_event_detect(SigIN)



# event_detected() function

# GPIO.add_event_detect(SigIN, GPIO.FALLING)
# # do_something()
# time.sleep(15)
# if GPIO.event_detected(SigIN):
#     print('Button pressed')
#
# GPIO.remove_event_detect(SigIN)


# Threaded callbacks
# RPi.GPIO runs a second thread for callback functions. This means that callback functions can be run at the same time as your main program, in immediate response to an edge. For example:

def my_callback(channel):
    print('This is a edge event callback function!')
    print('Edge detected on channel %s'%channel)
    print('This is run in a different thread to your main program')

print('Waiting for Button press')

GPIO.add_event_detect(SigIN, GPIO.FALLING, callback=my_callback, bouncetime=300)

pause()

# pause.seconds(15)
