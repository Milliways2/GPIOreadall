#! /usr/bin/env python3
# 2021-04-02
# 2021-04-13    Fix Wrong model for Old Style revision codes
# 2021-12-20    Improve Old Style revision codes; ignore unwanted status bits
# 2022-03-25    Zero 2 W
# 2022-12-23    pi_gpio version
# 2023-01-16    Include PROGNAME, LIBNAME in border; fix formatting

"""
Display status of all GPIO
This version for pi_gpio
"""
import sys, os, time
import subprocess
import pi_gpio as GPIO
LIBNAME='pi_gpio'
PROGNAME='gpioStatus'

MODES=["IN", "OUT", "ALT5", "ALT4", "ALT0", "ALT1", "ALT2", "ALT3"]
HEADER = ('3.3v', '5v', 2, '5v', 3, 'GND', 4, 14, 'GND', 15, 17, 18, 27, 'GND', 22, 23, '3.3v', 24, 10, 'GND', 9, 25, 11, 8, 'GND', 7, 0, 1, 5, 'GND', 6, 12, 13, 'GND', 19, 16, 26, 20, 'GND', 21)
FUNCTION = {
'Pull': ('High', 'High', 'High', 'High', 'High', 'High', 'High', 'High', 'High', 'Low', 'Low', 'Low', 'Low', 'Low', 'Low', 'Low', 'Low', 'Low', 'Low', 'Low', 'Low', 'Low', 'Low', 'Low', 'Low', 'Low', 'Low', 'Low'),
'ALT0': ('SDA0', 'SCL0', 'SDA1', 'SCL1', 'GPCLK0', 'GPCLK1', 'GPCLK2', 'SPI0_CE1_N', 'SPI0_CE0_N', 'SPI0_MISO', 'SPI0_MOSI', 'SPI0_SCLK', 'PWM0', 'PWM1', 'TXD0', 'RXD0', 'FL0', 'FL1', 'PCM_CLK', 'PCM_FS', 'PCM_DIN', 'PCM_DOUT', 'SD0_CLK', 'SD0_XMD', 'SD0_DATO', 'SD0_DAT1', 'SD0_DAT2', 'SD0_DAT3'),
'ALT1': ('SA5', 'SA4', 'SA3', 'SA2', 'SA1', 'SAO', 'SOE_N', 'SWE_N', 'SDO', 'SD1', 'SD2', 'SD3', 'SD4', 'SD5', 'SD6', 'SD7', 'SD8', 'SD9', 'SD10', 'SD11', 'SD12', 'SD13', 'SD14', 'SD15', 'SD16', 'SD17', 'TE0', 'TE1'),
'ALT2': ('PCLK', 'DE', 'LCD_VSYNC', 'LCD_HSYNC', 'DPI_D0', 'DPI_D1', 'DPI_D2', 'DPI_D3', 'DPI_D4', 'DPI_D5', 'DPI_D6', 'DPI_D7', 'DPI_D8', 'DPI_D9', 'DPI_D10', 'DPI_D11', 'DPI_D12', 'DPI_D13', 'DPI_D14', 'DPI_D15', 'DPI_D16', 'DPI_D17', 'DPI_D18', 'DPI_D19', 'DPI_D20', 'DPI_D21', 'DPI_D22', 'DPI_D23'),
'ALT3': ('SPI3_CE0_N', 'SPI3_MISO', 'SPI3_MOSI', 'SPI3_SCLK', 'SPI4_CE0_N', 'SPI4_MISO', 'SPI4_MOSI', 'SPI4_SCLK', '_', '_', '_', '_', 'SPI5_CE0_N', 'SPI5_MISO', 'SPI5_MOSI', 'SPI5_SCLK', 'CTS0', 'RTS0', 'SPI6_CE0_N', 'SPI6_MISO', 'SPI6_MOSI', 'SPI6_SCLK', 'SD1_CLK', 'SD1_CMD', 'SD1_DAT0', 'SD1_DAT1', 'SD1_DAT2', 'SD1_DAT3'),
'ALT4': ('TXD2', 'RXD2', 'CTS2', 'RTS2', 'TXD3', 'RXD3', 'CTS3', 'RTS3', 'TXD4', 'RXD4', 'CTS4', 'RTS4', 'TXD5', 'RXD5', 'CTS5', 'RTS5', 'SPI1_CE2_N', 'SPI1_CE1_N', 'SPI1_CE0_N', 'SPI1_MISO', 'SPIl_MOSI', 'SPI1_SCLK', 'ARM_TRST', 'ARM_RTCK', 'ARM_TDO', 'ARM_TCK', 'ARM_TDI', 'ARM_TMS'),
'ALT5': ('SDA6', 'SCL6', 'SDA3', 'SCL3', 'SDA3', 'SCL3', 'SDA4', 'SCL4', 'SDA4', 'SCL4', 'SDA5', 'SCL5', 'SDA5', 'SCL5', 'TXD1', 'RXD1', 'CTS1', 'RTS1', 'PWM0', 'PWM1', 'GPCLK0', 'GPCLK1', 'SDA6', 'SCL6', 'SPI3_CE1_N', 'SPI4_CE1_N', 'SPI5_CE1_N', 'SPI6_CE1_N')
}

# https://www.raspberrypi.com/documentation/computers/raspberry-pi.html#new-style-revision-codes
PiModel = {
0: 'A',
1: 'B',
2: 'A+',
3: 'B+',
4: '2B',
6: 'CM1',
8: '3B',
9: 'Zero',
0xa: 'CM3',
0xc: 'ZeroW',
0xd: '3B+',
0xe: '3A+',
0x10: 'CM3+',
0x11: '4B',
0x12: 'Zero2W',
0x13: '400',
0x14: 'CM4'
}

RED   = '\033[1;31m'
GREEN = '\033[1;32m'
ORANGE = '\033[1;33m'
BLUE = '\033[1;34m'
LRED = '\033[1;91m'
YELLOW = '\033[1;93m'
RESET = '\033[0;0m'
COL = {
    '3.3v': LRED,
    '5v': RED,
    'GND': GREEN
}

TYPE = 0
rev = 0

def pin_state(g):
    """
    Return "state" of BCM g
    Return is tuple (name, mode, value)
    """
    mode = GPIO.gpio_function(g)
    pull = GPIO.get_pullupdn(g)
    modename = MODES[mode]
    if(mode<2): # i.e. IN or OUT
        name = 'GPIO{}'.format(g)
    else:
        name = FUNCTION[MODES[mode]][g]
    if(mode == 0 and pull):
        if(pull == 1 ):
            modename = 'IN ^'
        else:
            modename = 'IN v'
    return name, modename, GPIO.input_gpio(g)

def print_gpio(pin_state):
    """
    Print listing of Raspberry pins, state & value
    Layout matching Pi 2 row Header
    """
    global TYPE, rev
    GPIOPINS = 40
    try:
        Model = 'Pi ' + PiModel[TYPE]
    except:
        Model = 'Pi ??'
    if rev < 16 :	# older models (pre PiB+)
        GPIOPINS = 26

    print('+----------------------------+{:^10}+----------------------------+'.format(Model) )
    HEAD='| BCM | Name      | Mode | V |  Board   | V | Mode | Name      | BCM |'
    DIV='+-----+-----------+------+---+----++----+---+------+-----------+-----+'
    print(HEAD)
    print(DIV)

    for h in range(1, GPIOPINS, 2):
    # odd pin
        hh = HEADER[h-1]
        if(type(hh)==type(1)):
            print('|{0:4} | {1[0]:<10}| {1[1]:<4} | {1[2]} |{2:3} '.format(hh, pin_state(hh), h), end='|| ')
        else:
#            print('|        {:18}  | {:2}'.format(hh, h), end=' || ')    # non-coloured output
          print('|        {}{:18}  | {:2}{}'.format(COL[hh], hh, h, RESET), end=' || ')    # coloured output
    # even pin
        hh = HEADER[h]
        if(type(hh)==type(1)):
            print('{0:2} | {1[2]:<2}| {1[1]:<5}| {1[0]:<10}|{2:4} |'.format(h+1, pin_state(hh), hh))
        else:
#             print('{:2} |             {:9}      |'.format(h+1, hh))    # non-coloured output
            print('{}{:2} |             {:9}{}      |'.format(COL[hh], h+1, hh, RESET))    # coloured output
    print(DIV)
    print(HEAD)
    print('+{:-^28}+{:^10}+{:-^28}+'.format(LIBNAME, Model, PROGNAME) )

def main():
    global TYPE, rev
    rev = GPIO.get_revision()

    if(rev & 0x800000):   # New Style
        TYPE = (rev&0x00000FF0)>>4
    else:   # Old Style
        rev &= 0x1F
        MM = [0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 3, 6, 2, 3, 6, 2]
        TYPE = MM[rev] # Map Old Style revision to TYPE

    GPIO.setup()
    print_gpio(pin_state)
    GPIO.cleanup()

if __name__ == '__main__':
	main()
