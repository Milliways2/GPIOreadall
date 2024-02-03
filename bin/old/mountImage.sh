#!/bin/bash
# 2019-09-26

IMAGE_MOUNT='/mnt/Image'

# Check/create Mount Points
if [ ! -e $IMAGE_MOUNT ]; then
	mkdir $IMAGE_MOUNT
fi
sudo mount.cifs //10.1.2.107/Images /mnt/Image -o user=ian

