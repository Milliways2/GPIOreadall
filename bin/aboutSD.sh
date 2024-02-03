#! /bin/sh
# Print details of OS installed on SD Card
# 2021-04-17
# 2021-12-15	SD version

# Function to print coloured headings
#  delete "tput" lines for plain output
print_head () {
 tput setaf 6
 echo $1
 tput sgr 0
}

BOOT_MOUNT='/mnt/SDA1'
ROOT_MOUNT='/mnt/SDA2'

if [ -e /dev/sda ]; then
    SD1='/dev/sda1'
    SD2='/dev/sda2'
    SD='/dev/sda'
else
    SD1='/dev/sdb1'
    SD2='/dev/sdb2'
    SD='/dev/sdb'
fi

# Mount Partitions
if ! $(mountpoint -q $BOOT_MOUNT); then
	mount $SD1 $BOOT_MOUNT	# mount partition containing boot files
fi
if ! $(mountpoint -q $ROOT_MOUNT); then
	mount $SD2 $ROOT_MOUNT	# mount root partition containing OS files
fi

echo

if [ -e $ROOT_MOUNT/etc/rpi-issue ]; then
 print_head "- Original Installation"
 cat $ROOT_MOUNT/etc/rpi-issue | grep reference
fi

if [ -e $ROOT_MOUNT/usr/bin/lsb_release ]; then
 print_head "- Current OS"
 $ROOT_MOUNT/usr/bin/lsb_release -irdc
fi

if [ ! -e $ROOT_MOUNT/usr/share/xsessions ]; then
	print_head "X NOT installed"
fi
print_head "- Kernel"
$ROOT_MOUNT/usr/bin/uname -r
print_head "- Architecture"
$ROOT_MOUNT/usr/bin/uname -m

print_head "- hostname"
$ROOT_MOUNT/usr/bin/hostname
# $ROOT_MOUNT/usr/bin/hostname -I

# Milliways Custom
if [ -e $BOOT_MOUNT/SD* ]; then
	ls --file-type $BOOT_MOUNT/SD* | awk -F\/ '{print $4}';
fi

# Determine Disk identifier of SD Card
DISKID=$(sudo fdisk -l $SD | awk '/Disk identifier/ {print $3};' | sed 's/0x//')
# Use sed to delete all BEFORE PARTUUID= and all AFTER -0  in $BOOT_MOUNT/cmdline.txt
ROOTPART=$(sed -e 's/^.*PARTUUID=//' -e 's/-0.*$'// $BOOT_MOUNT/cmdline.txt)

echo "Disk identifier:\t"$DISKID
echo "root PARTUUID\t\t"$ROOTPART

VERS=$($ROOT_MOUNT/usr/bin/vcgencmd version  | grep ":")
print_head "- Firmware"
echo $VERS

print_head "- Created"
sudo /usr/sbin/tune2fs -l $SD2  | grep created
