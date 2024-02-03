#! /bin/sh
# 202-04-08

# Function to print coloured headings
#  delete "tput" lines for plain output
print_head () {
 tput setaf 6
 echo $1
 tput sgr 0
}

if [ -e MountedImages/etc/rpi-issue ]; then
 print_head "- Original Installation"
 cat MountedImages/etc/rpi-issue | grep reference
fi

print_head "- hostname"
cat MountedImages/etc/hostname

print_head "- Current OS"
cat MountedImages/etc/issue.net
cat MountedImages/etc/debian_version

# Milliways Custom
if [ -e MountedImages/boot/SD* ]; then
	ls --file-type MountedImages/boot/SD* | awk -F\/ '{print $3}';
fi
# if [ -e /sys/class/net/wlan0 ]; then
# 	wpa_cli -i wlan0 status | grep -w ssid
# fi

print_head "- Kernel"
ls -l MountedImages/lib/modules/
