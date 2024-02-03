#! /usr/bin/env python3
"""
Pico reset
"""
import sys, os, time
import picod

pico = picod.pico()
if not pico.connected:
   exit()
pico.reset()
print("Pico reset")
