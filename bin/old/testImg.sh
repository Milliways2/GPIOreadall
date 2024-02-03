#!/bin/bash
IMGFILE='/mnt/Image/JessieBackup.img'
sfdisk -d "${IMGFILE}"

INFO1="$(sfdisk -d "${IMGFILE}")"
echo "INFO1" $INFO1

START1=$(grep type=c <<< "${INFO1}" | sed -n 's|^.*start=\s\+\([0-9]\+\).*$|\1|p')
if [ -z $START1 ]; then
	START1=$(grep 'Id= c' <<< "${INFO1}" | sed -n 's|^.*start=\s\+\([0-9]\+\).*$|\1|p')
fi
echo "START1" $START1

SIZE1=$(grep type=c <<< "${INFO1}" | sed -n 's|^.*size=\s\+\([0-9]\+\).*$|\1|p')
if [ -z $SIZE1 ]; then
	SIZE1=$(grep 'Id= c' <<< "${INFO1}" | sed -n 's|^.*size=\s\+\([0-9]\+\).*$|\1|p')
fi
echo "SIZE1" $SIZE1


echo "----"


INFO2="$(sfdisk -d "${IMGFILE}")"
START2=$(grep type=83 <<< "${INFO2}" | sed -n 's|^.*start=\s\+\([0-9]\+\).*$|\1|p')
if [ -z $START2 ]; then
  START2=$(grep Id=83 <<< "${INFO2}" | sed -n 's|^.*start=\s\+\([0-9]\+\).*$|\1|p')
fi
echo "START2" $START2

SIZE2=$(grep type=83 <<< "${INFO2}" | sed -n 's|^.*size=\s\+\([0-9]\+\).*$|\1|p')
if [ -z $SIZE2 ]; then
	SIZE2=$(grep Id=83 <<< "${INFO2}" | sed -n 's|^.*size=\s\+\([0-9]\+\).*$|\1|p')
fi
echo "SIZE2" $SIZE2

echo "----"


# grep type=c <<< "${INFO1}"

exit

#   START1=$(grep type=c <<< "${INFO1}" | sed -n 's|^.*start=\s\+\([0-9]\+\).*$|\1|p')
#   SIZE1=$(grep type=c <<< "${INFO1}" | sed -n 's|^.*size=\s\+\([0-9]\+\).*$|\1|p')
#   LOOP1="$(losetup -f --show -o $((${START1} * 512)) --sizelimit $((${SIZE1} * 512)) "${IMGFILE}")"
#
#
#
#
# grep type=c <<< "${INFO1}" | sed -n 's|^.*start=\s\+\([0-9]\+\).*$|\1|p
# grep type=c <<< "${INFO1}" | sed -n 's|^.*start=\s\+\([0-9]\+\).*$|\1|p'
# echo $START1
# echo $INFO1
# ll /etc/wpa_supplicant/wpa_supplicant.conf
# findmnt
# sudo reboot
# sudo mount.cifs //Milliways.local/Images /mnt/Image -o user=ian
