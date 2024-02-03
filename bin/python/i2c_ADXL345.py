#!/usr/bin/env python

# i2c_ADXL345.py
# 2015-04-01
# Public Domain

import time
import struct
import sys

import pigpio # http://abyz.co.uk/rpi/pigpio/python.html

if sys.version > '3':
   buffer = memoryview

BUS=1

ADXL345_I2C_ADDR=0x53

RUNTIME=60.0

pi=pigpio.pi() # open local Pi

h = pi.i2c_open(BUS, ADXL345_I2C_ADDR)

if h >= 0: # Connected OK?

   # Initialise ADXL345.
   pi.i2c_write_byte_data(h, 0x2d, 0)  # POWER_CTL reset.
   pi.i2c_write_byte_data(h, 0x2d, 8)  # POWER_CTL measure.
   pi.i2c_write_byte_data(h, 0x31, 0)  # DATA_FORMAT reset.
   pi.i2c_write_byte_data(h, 0x31, 11) # DATA_FORMAT full res +/- 16g.

   read = 0

   start_time = time.time()

   while (time.time()-start_time) < RUNTIME:

      # 0x32 = X LSB, 0x33 = X MSB
      # 0x34 = Y LSB, 0x35 = Y MSB
      # 0x36 = Z LSB, 0x37 = Z MSB

      # < = little endian

      (s, b) = pi.i2c_read_i2c_block_data(h, 0x32, 6)

      if s >= 0:
         (x, y, z) = struct.unpack('<3h', buffer(b))
         print("{} {} {}".format(x, y, z))
         read += 1

   pi.i2c_close(h)

pi.stop()

print(read, read/RUNTIME)

