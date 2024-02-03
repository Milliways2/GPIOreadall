#!/bin/bash
# Simple mount backup image
# Assumes image location already mounted - see mountImage.sh

IMAGE_MOUNT='/mnt/Image'
# IMAGE_FILE='BullseyeBackup.img'

MOUNTED_IMAGE='/home/pi/MountedImages'

if [ $# -eq 0 ] ; then
	IMAGE_FILE='BullseyeBackup.img'
else
	IMAGE_FILE=$1
fi

# Check/create Mount Point
if [ ! -e $MOUNTED_IMAGE ]; then
	mkdir $MOUNTED_IMAGE
fi

# sudo image-utils/image-mount "$IMAGE_MOUNT/$IMAGE_FILE"  $MOUNTED_IMAGE

# To mount both boot & root
sudo image-utils/image-mount "$IMAGE_MOUNT/$IMAGE_FILE"  $MOUNTED_IMAGE; sudo image-utils/image-mount "$IMAGE_MOUNT/$IMAGE_FILE"  "$MOUNTED_IMAGE/boot" W95

