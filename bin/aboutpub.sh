#! /bin/sh
# 2021-03-06	print_head; simplified Firmware; Architecture

# Function to print coloured headings
#  delete "tput" lines for plain output
print_head () {
 tput setaf 6
 echo $1
 tput sgr 0
}

if [ -e /etc/rpi-issue ]; then
 print_head "- Original Installation"
 cat /etc/rpi-issue | grep reference
fi

if [ -e /usr/bin/lsb_release ]; then
 print_head "- Current OS"
 lsb_release -irdc
fi
if [ ! -e /usr/share/xsessions ]; then
	print_head "X NOT installed"
fi
print_head "- Kernel"
uname -r
print_head "- Architecture"
uname -m

print_head "- Model"
cat /proc/device-tree/model && echo

print_head "- hostname"
hostname
hostname -I

sudo fdisk -l /dev/mmcblk0 | grep "Disk identifier"

if [ -e /opt/vc/bin/vcgencmd -o /usr/bin/vcgencmd ]; then
	VERS=$(vcgencmd version  | grep ":")
	print_head "- Firmware"
	echo $VERS
fi
print_head "- Created"
sudo tune2fs -l $(mount -v | awk '/ on \/ / {print $1}') | grep created
