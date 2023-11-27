# GPIOreadall
**GPIOreadall** is a replacement for the deprecated wiringpi gpio readall utility on Raspberry Pi.

GPIOreadall has the advantage of displaying the ACTUAL programmed GPIO function set by Device Tree on boot rather than the default.

GPIOreadall runs on all Pi models with 40 pin expansion header (excluding Pi5), including Pi4 and Raspberry Pi Model B Rev 2 with 26 pin expansion header.

GPIOreadall runs on Raspberry Pi OS Stretch, Buster and Bullseye (32 or 64 bit) and requires no additional libraries as it uses the raspi-gpio debug tool

Bookworm removes support for raspi-gpio used by GPIOreadall (although it appears to work on Pi4).
A new version **GPIOreadall5** is supported on Bookworm (although currently untested on Pi5)

GPIOreadall by default displays power pins in colour.
To restore non-coloured output uncomment the 2 lines # non-coloured output and comment out # coloured output.
