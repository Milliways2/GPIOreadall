#! /bin/bash
# 2020-03-09
# 2021-02-10
# Check consistency of Partition ID on mounted SD Card

BOOT_MOUNT='/mnt/SDA1'
ROOT_MOUNT='/mnt/SDA2'

# Check/create Mount Points
if [ ! -e $BOOT_MOUNT ]; then
	mkdir $BOOT_MOUNT
fi
if [ ! -e $ROOT_MOUNT ]; then
	mkdir $ROOT_MOUNT
fi
	echo "mounts " $BOOT_MOUNT  $ROOT_MOUNT
if [ -e /dev/sda ]; then
    SD1='/dev/sda1'
    SD2='/dev/sda2'
    SD='/dev/sda'
else
    SD1='/dev/sdb1'
    SD2='/dev/sdb2'
    SD='/dev/sdb'
fi
echo $SD

# Mount Partitions
if ! $(mountpoint -q $BOOT_MOUNT); then
	sudo mount $SD1 $BOOT_MOUNT	# mount partition containing boot files
fi
if ! $(mountpoint -q $ROOT_MOUNT); then
	sudo mount $SD2 $ROOT_MOUNT	# mount root partition containing OS files
fi


# Determine Disk identifier of SD Card
DISKID=$(sudo fdisk -l $SD | awk '/Disk identifier/ {print $3};' | sed 's/0x//')

# Use sed to delete all BEFORE PARTUUID= and all AFTER -0  in $BOOT_MOUNT/cmdline.txt
ROOTPART=$(sed -e 's/^.*PARTUUID=//' -e 's/-0.*$'// $BOOT_MOUNT/cmdline.txt)

echo -e "Disk ID\t\t"$DISKID
echo -e "root PARTUUID\t"$ROOTPART

# find first PARTUUID ext4 in $ROOT_MOUNT/etc/fstab
EXISTFSTABPART=$(awk '/PARTUUID.*ext4/ {print $1; exit};' $ROOT_MOUNT/etc/fstab | sed -e 's/^.*PARTUUID=//' -e 's/-0.*$'//)

echo -e "Existing fstab\t"$EXISTFSTABPART

if [ $DISKID = $EXISTFSTABPART ]; then
	echo "Looks OK!"
else
	echo "Partition ID mismatch!"
	# Edit cmdline.txt & fstab to new DISKID & create new temporary files
	sed -e "s/$ROOTPART/$DISKID/" $BOOT_MOUNT/cmdline.txt > cmdline.txt.new
	sed -e "s/$ROOTPART/$DISKID/" $ROOT_MOUNT/etc/fstab > fstab.new
	echo -n "Set DiskID to ${DISKID} on $SD (y/n)? "
	while read -r -n 1 -s answer; do
		if [[ "${answer}" = [yY] ]]; then
		  echo "Change"
		  sudo cp -v cmdline.txt.new $BOOT_MOUNT/cmdline.txt
		  sudo cp -v fstab.new $ROOT_MOUNT/etc/fstab
		  break
		else
		  echo "Aborted"
		  exit
		fi
	done
fi
