# GPIOreadall
**GPIOreadall** is a replacement for the deprecated wiringpi gpio readall utility on Raspberry Pi.

GPIOreadall has the advantage of displaying the ACTUAL programmed GPIO function set by Device Tree on boot rather than the default.

GPIOreadall runs on all Pi models with 40 pin expansion header, including Pi4 and Raspberry Pi Model B Rev 2 with 26 pin expansion header (although currently untested on Pi5).

GPIOreadall runs on Raspberry Pi OS Stretch, Buster, Bullseye and Bookworm (32 or 64 bit) and requires no additional libraries.

GPIOreadall by default displays power pins in colour.
To restore non-coloured output uncomment the 2 lines # non-coloured output and comment out # coloured output.
