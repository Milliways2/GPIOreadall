#! /usr/bin/env python3
"""
Pico GPIO test
"""
import sys, os, time
import picod

def main():
    global pico

#     print("Pico GPIO test")

    pico = picod.pico()
    if not pico.connected:
       exit()
    pico.reset()
#     print("Pico GPIO test opened")
    pico.sleep(1)
#     print("Pico GPIO test step 1")

#     pico.gpio_set_output(16, 1) # Set GPIO 16 as a high output.
#     status, levels = pico.gpio_read(16)
#     print("GPIO levels is 0x{:x}".format(levels))

#     status, levels = pico.GPIO_read()
#
#     if status == picod.STATUS_OKAY:
#        print("GPIO levels are 0x{:x}".format(levels))
#
#        if levels & (1<<16): # check gpio 6
#           print("gpio 16 is high")
#        else:
#           print("gpio 16 is low")
#     pico.gpio_set_input(6)
#     pico.gpio_set_pull(6, 2)
#     pico.gpio_set_input(7)
#     pico.gpio_set_pull(7, 0)
#     print("Pico GPIO test step 2")

#     pico.GPIO_set_dir(0xff, 0x0f, 0x05)
# Set GPIO0 - GPI22, GPIO25 - GPI28 (including LED) to Out High
#     pico.GPIO_set_dir(0x1effffff, 0x1effffff, 0x1effffff)
# Set GPIO0 - GPI22, GPIO25 - GPI28 (including LED) to Out Low
#     pico.GPIO_set_dir(0x1effffff, 0x1effffff, 0)
# Set GPIO0 - GPI22, GPIO26 - GPI28 to In
    pico.GPIO_set_dir(0x1affffff, 0, 0)
#     pico.GPIO_set_dir(0x2ffffff, 0x2ffffff, 0x27fffff)
#     pico.GPIO_set_dir(0xff, 0xff, 0x00)

# set pull-down on GPIO 15, pull-up on GPIO 6
#     pico.GPIO_set_pulls(1<<15|1<<6, picod.PULL_DOWN<<30|picod.PULL_UP<<12)
#
# set pull-up on GPIO0 - GPI22, GPIO26 - GPI28
#     pico.GPIO_set_pulls(0x1effffff, picod.PULL_DOWN<<30|picod.PULL_UP<<12)

    pico.gpio_set_pull(6, picod.PULL_DOWN)
    pico.gpio_set_pull(7, picod.PULL_UP)
    pico.gpio_set_pull(8, 0)

#     pico.serial_close(0)
#     pico.serial_close(1)

#     status, speed = pico.serial_open(0, 0, 1, 19200)
#     if status == picod.STATUS_OKAY:
#        print("opened okay, baud={}".format(speed))
#     else:
#        print("open failed with status {}".format(status))

#     status, speed = pico.serial_open(1, 4, 5, 9600)
#     if status == picod.STATUS_OKAY:
#        print("opened okay, baud={}".format(speed))
#     else:
#        print("open failed with status {}".format(status))

if __name__ == '__main__':
	main()
