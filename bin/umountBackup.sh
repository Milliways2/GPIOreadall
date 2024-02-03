#!/bin/bash
# unmount backup image

MOUNTED_IMAGE='/home/pi/MountedImages'
sudo umount $MOUNTED_IMAGE/boot; sudo umount $MOUNTED_IMAGE; sudo losetup -d /dev/loop?
