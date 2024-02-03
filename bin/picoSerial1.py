#! /usr/bin/env python3
"""
Pico GPIO test
"""
import sys, os, time
import picod

def main():
    global pico

    pico = picod.pico()
    if not pico.connected:
       exit()
    pico.reset()

    status, speed = pico.serial_open(1, 4, 5, 9600)
    if status == picod.STATUS_OKAY:
       print("opened okay, baud={}".format(speed))
    else:
       print("open failed with status {}".format(status))

if __name__ == '__main__':
	main()
