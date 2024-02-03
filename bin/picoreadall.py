#! /usr/bin/env python3
# 2021-04-02
# 2021-04-13    Fix Wrong model for Old Style revision codes
"""
Read all GPIO
This version for raspi-gpio debug tool
"""
import sys, os, time
# import subprocess
import picod


MODES=["IN", "OUT", "ALT5", "ALT4", "ALT0", "ALT1", "ALT2", "ALT3"]
HEADER = (
0, 1, 'GND', 2, 3, 4, 5, 'GND',  6, 7,
8, 9, 'GND', 10, 11, 12, 13, 'GND', 14, 15,
'VBUS', 'VSYS', 'GND', '3V3_EN','3V3(OUT)', 'ADC_VREF', 28, 'GND', 27, 26, 'RUN',
22, 'GND', 21, 20, 19, 18, 'GND', 17, 16
)
GPIO_FUNCTION = {
0: 'XIP',
1: 'SPI',
2: 'UART',
3: 'I2C',
4: 'PWM',
5: 'SIO',
5: 'GPIO',
6: 'PIO0',
7: 'PIO1',
8: 'GPCK',
9: 'USB',
15: 'NULL' }

FUNCTION = {
1: ('SPI0 RX', 'SPI0 CSn', 'SPI0 SCK', 'SPI0 TX', 'SPI0 RX', 'SPI0 CSn', 'SPI0 SCK', 'SPI0 TX', 'SPI1 RX', 'SPI1 CSn', 'SPI1 SCK', 'SPI1 TX', 'SPI1 RX', 'SPI1 CSn', 'SPI1 SCK', 'SPI1 TX', 'SPI0 RX', 'SPI0 CSn', 'SPI0 SCK', 'SPI0 TX', 'SPI0 RX', 'SPI0 CSn', 'SPI0 SCK', 'SPI0 TX', 'SPI1 RX', 'SPI1 CSn', 'SPI1 SCK', 'SPI1 TX', 'SPI1 RX', 'SPI1 CSn'),
2: ('UART0 TX', 'UART0 RX', 'UART0 CTS', 'UART0 RTS', 'UART1 TX', 'UART1 RX', 'UART1 CTS', 'UART1 RTS', 'UART1 TX', 'UART1 RX', 'UART1 CTS', 'UART1 RTS', 'UART0 TX', 'UART0 RX', 'UART0 CTS', 'UART0 RTS', 'UART0 TX', 'UART0 RX', 'UART0 CTS', 'UART0 RTS', 'UART1 TX', 'UART1 RX', 'UART1 CTS', 'UART1 RTS', 'UART1 TX', 'UART1 RX', 'UART1 CTS', 'UART1 RTS', 'UART0 TX', 'UART0 RX'),
3: ('I2C0 SDA', 'I2C0 SCL', 'I2C1 SDA', 'I2C1 SCL', 'I2C0 SDA', 'I2C0 SCL', 'I2C1 SDA', 'I2C1 SCL', 'I2C0 SDA', 'I2C0 SCL', 'I2C1 SDA', 'I2C1 SCL', 'I2C0 SDA', 'I2C0 SCL', 'I2C1 SDA', 'I2C1 SCL', 'I2C0 SDA', 'I2C0 SCL', 'I2C1 SDA', 'I2C1 SCL', 'I2C0 SDA', 'I2C0 SCL', 'I2C1 SDA', 'I2C1 SCL', 'I2C0 SDA', 'I2C0 SCL', 'I2C1 SDA', 'I2C1 SCL', 'I2C0 SDA', 'I2C0 SCL'),
4: ('PWM0 A', 'PWM0 B', 'PWM1 A', 'PWM1 B', 'PWM2 A', 'PWM2 B', 'PWM3 A', 'PWM3 B', 'PWM4 A', 'PWM4 B', 'PWM5 A', 'PWM5 B', 'PWM6 A', 'PWM6 B', 'PWM7 A', 'PWM7 B', 'PWM0 A', 'PWM0 B', 'PWM1 A', 'PWM1 B', 'PWM2 A', 'PWM2 B', 'PWM3 A', 'PWM3 B', 'PWM4 A', 'PWM4 B', 'PWM5 A', 'PWM5 B', 'PWM6 A', 'PWM6 B'),
5: ('SIO', 'SIO', 'SIO', 'SIO', 'SIO', 'SIO', 'SIO', 'SIO', 'SIO', 'SIO', 'SIO', 'SIO', 'SIO', 'SIO', 'SIO', 'SIO', 'SIO', 'SIO', 'SIO', 'SIO', 'SIO', 'SIO', 'SIO', 'SIO', 'SIO', 'SIO', 'SIO', 'SIO', 'SIO', 'SIO'),
6: ('PIO0', 'PIO0', 'PIO0', 'PIO0', 'PIO0', 'PIO0', 'PIO0', 'PIO0', 'PIO0', 'PIO0', 'PIO0', 'PIO0', 'PIO0', 'PIO0', 'PIO0', 'PIO0', 'PIO0', 'PIO0', 'PIO0', 'PIO0', 'PIO0', 'PIO0', 'PIO0', 'PIO0', 'PIO0', 'PIO0', 'PIO0', 'PIO0', 'PIO0', 'PIO0'),
7: ('PIO1', 'PIO1', 'PIO1', 'PIO1', 'PIO1', 'PIO1', 'PIO1', 'PIO1', 'PIO1', 'PIO1', 'PIO1', 'PIO1', 'PIO1', 'PIO1', 'PIO1', 'PIO1', 'PIO1', 'PIO1', 'PIO1', 'PIO1', 'PIO1', 'PIO1', 'PIO1', 'PIO1', 'PIO1', 'PIO1', 'PIO1', 'PIO1', 'PIO1', 'PIO1'),
8: ('', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'CLOCK GPIN0', 'CLOCK GPOUT0', 'CLOCK GPIN1', 'CLOCK GPOUT1', 'CLOCK GPOUT2', 'CLOCK GPOUT3', '', '', '', ''),
9: ('USB  OVCUR DET', 'USB  VBUS DET', 'USB  VBUS EN', 'USB  OVCUR DET', 'USB  VBUS DET', 'USB  VBUS EN', 'USB  OVCUR DET', 'USB  VBUS DET', 'USB  VBUS EN', 'USB  OVCUR DET', 'USB  VBUS DET', 'USB  VBUS EN', 'USB  OVCUR DET', 'USB  VBUS DET', 'USB  VBUS EN', 'USB  OVCUR DET', 'USB  VBUS DET', 'USB  VBUS EN', 'USB  OVCUR DET', 'USB  VBUS DET', 'USB VBUS EN', 'USB OVC', 'USB VBUS DET', 'USB VBUS EN', 'USB OVCUR DET', 'USB VBUS DET', 'USB VBUS EN', 'USB OVCUR DET', 'USB VBUS DET', 'USB VBUS EN')
}


RED   = '\033[1;31m'
GREEN = '\033[1;32m'
ORANGE = '\033[1;33m'
BLUE = '\033[1;34m'
LRED = '\033[1;91m'
YELLOW = '\033[1;93m'
RESET = '\033[0;0m'
CYAN   = '\033[1;36m'
COL = { # Mapping of Pin function to colour
    'GND': BLUE,
    'VBUS': RED,
    'VSYS': RED,
    '3V3_EN': ORANGE,
    '3V3(OUT)': LRED,
    'ADC_VREF': GREEN,
    'RUN': CYAN
    }

TYPE = 0
rev = 0

def pin_state(g):
    """
    Return "state" of GP g
    Return is tuple (name, mode, value)
    """
#     result = subprocess.run(['raspi-gpio', 'get', ascii(g)], stdout=subprocess.PIPE).stdout.decode('utf-8')

    mode = '88'
    name = 'Name'
    status, function = pico.gpio_get_function(g)
    if status == picod.STATUS_OKAY:
#         print("GPIO 20 function is {}".format(function))
        name = GPIO_FUNCTION[function]
    else:
        function = 0

#     Debug test!
#     if(g==16):
#         print()
#         status, levels = pico.gpio_read(16)
#         if status == picod.STATUS_OKAY:
#             print("GPIO levels is 0x{:x}".format(levels))

    status, level = pico.gpio_read(g)
    if(function == None):
        pass
    if(function == 5): # i.e. IN or OUT
        name = 'GPIO{}'.format(g)
        status, pull = pico.gpio_get_pull(g)
        mode = pull
    else:
        if(function < 9):
            name = FUNCTION[function][g]
            status, pull = pico.gpio_get_pull(g)
            mode = pull

    return name, mode, level

def print_gpio(pin_state):
    """
    Print listing of Raspberry pins, state & value
    Layout matching Pi 2 row Header
    """
    global TYPE, rev
    GPIOPINS = 40
    GPIOROWS = GPIOPINS//2
    Model = 'Pico '

    print('+-----+------------+------+---+{:^10}+---+------+-----------+-----+'.format(Model) )
    print('|  GP |    Name    | Mode | V |  Board   | V | Mode | Name      |  GP |')
    print('+-----+------------+------+---+----++----+---+------+-----------+-----+')

    for h in range(1, GPIOROWS+1 ):
    # left pin
        hh = HEADER[h-1]
        if(type(hh)==type(1)):
            print('|{0:4} | {1[0]:<10} | {1[1]:<4} | {1[2]} |{2:3} '.format(hh, pin_state(hh), h), end='|| ')
        else:
            print('|        {}{:18}   | {:2}{}'.format(COL[hh], hh, h, RESET), end=' || ')    # coloured output
    # right pin
        hh = HEADER[GPIOROWS+h-1]
        if(type(hh)==type(1)):
            print('{0:2} | {1[2]:<2}| {1[1]:<5}| {1[0]:<10}|{2:4} |'.format(GPIOPINS-h+1, pin_state(hh), hh))
        else:
            print('{}{:2} |             {:9}{}      |'.format(COL[hh], GPIOPINS-h+1, hh, RESET))    # coloured output
    print('+-----+------------+------+---+----++----+---+------+-----------+-----+')
    print('|  GP |    Name    | Mode | V |  Board   | V | Mode | Name      |  GP |')
    print('+-----+------------+------+---+{:^10}+---+------+-----------+-----+'.format(Model) )


def main():
    global pico

    pico = picod.pico()
    if not pico.connected:
       exit()

    print_gpio(pin_state)

if __name__ == '__main__':
	main()
