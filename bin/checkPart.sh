#! /bin/sh
# 2021-02-10

#	Check consistency of Disk identifier in cmdline.txt /etc/fstab

# Determine Disk identifier
DISKID=$(sudo fdisk -l /dev/mmcblk0 | awk '/Disk identifier/ {print $3};' | sed 's/0x//')

# Use sed to delete all BEFORE PARTUUID= and all AFTER -0  in /boot/cmdline.txt
ROOTPART=$(sed -e 's/^.*PARTUUID=//' -e 's/-0.*$'// /boot/cmdline.txt)
echo "Disk ID\t\t"$DISKID
echo "root PARTUUID\t"$ROOTPART

# find first PARTUUID ext4 in /etc/fstab
EXISTFSTABPART=$(awk '/PARTUUID.*ext4/ {print $1; exit};' /etc/fstab | sed -e 's/^.*PARTUUID=//' -e 's/-0.*$'//)

echo "Existing fstab\t"$EXISTFSTABPART

if [ $DISKID = $EXISTFSTABPART ]; then
	echo "Looks OK!"
# else
fi
