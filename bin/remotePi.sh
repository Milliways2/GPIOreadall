#!/bin/bash
# Mount Remote Pi HOME directory
# 2018-12-15

R_MOUNT='/mnt/remotePi'

# Check/create Mount Point
if [ ! -e $R_MOUNT ]; then
	sudo mkdir $R_MOUNT
fi

if [ $# -eq 0 ] ; then
	REMOTENAME='BinniePi3Plus'
else
	REMOTENAME=$1
fi

if [  $# -eq 2 ] ; then
	USERNAME=$2
else
	USERNAME='pi'
fi

echo "USER" $USERNAME
REMOTENAME+=".local"
echo $REMOTENAME
REMOTEDIR=$REMOTENAME
REMOTEDIR+=':/home/'
REMOTEDIR+=$USERNAME
REMOTEDIR+='/'
echo $REMOTEDIR

if [ ! -z "$(ls -A $R_MOUNT)" ]; then
	sudo umount /mnt/remotePi
fi

# sudo mount $REMOTENAME:/home/pi/ /mnt/remotePi/
sudo mount $REMOTEDIR /mnt/remotePi/
