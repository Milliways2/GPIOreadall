#! /usr/bin/env python3
# 2020-10-17
"""
Read all GPIO
This version for pigpio daemon
display pull state on Pi4 using raspi-gpio debug tool
Code and constants imported from gpioread.py
"""
import sys, os, time
import subprocess
import pigpio
import gpioread
from gpioread import *

def get_pull(g):
    """
    Determine "pull" of GPIO using raspi-gpio debug tool
    """
    result = subprocess.run(['raspi-gpio', 'get', ascii(g)], stdout=subprocess.PIPE).stdout.decode('utf-8')
    if('UP' in result): return('IN ^')
    if('DOWN' in result): return('IN v')
    return('IN')

def pin_state(g):
    """
    Return GPIO state for BCM g as tuple(Name, Mode, Value)
    """
    mode = get_alt(g)
    modename = MODES[mode]
    if(mode==0 and TYPE>16):  # Input on Pi4
        try:
            modename = get_pull(g)  # modifies NAME to show pull
        except:
            modename = 'IN' # no pull found
    if(mode<2):
        name = 'GPIO{}'.format(g)
    else:
        name = FUNCTION[MODES[mode]][g]
    return name, modename, read_gpio(g)

def main():
    global TYPE, rev
    global get_alt, read_gpio

    if len(sys.argv) > 1:
        pi = pigpio.pi(sys.argv[1])
    else:
        pi = pigpio.pi()

    if not pi.connected:
        sys.exit(1)

# module independent references
    get_alt = pi.get_mode
    read_gpio =  pi.read

    rev = pi.get_hardware_revision()
    TYPE = (rev&0x00000FF0)>>4
    # ensure gpioread globals are initialised
    gpioread.rev = rev
    gpioread.TYPE = TYPE

    print_gpio(pin_state)   # call gpioread.print_gpio() using local pin_state())

if __name__ == '__main__':
	main()
