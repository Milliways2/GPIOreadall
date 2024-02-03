#!/bin/bash
# Hardlink image files
# 2016-04-27
TARGET="/mnt/PiHDD/WANT/"
for file in *jpg *.JPG
do
	if [ -f "$file" ]; then
#		echo $file
		ln $file $TARGET
	fi
done
#Rename with jhead -nPic%Y%m%d_%H%M%S *.*
