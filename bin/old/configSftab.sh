#!/bin/bash
# script to customise fstab
# 2017-08-27

# copy sed script to a temporary file
cat << EOF > /tmp/sedscr
/# a swapfile/i\\
UUID=94dc6686-0eda-41ba-87f7-494d7e37f913       /mnt/PiData     ext4    defaults,noatime,noauto  0     0\\
UUID=8ee3d7d1-354c-30b4-8259-d8a387f422a1       /mnt/Binnie     hfsplus    ro,noauto,relatime,umask=22,uid=1000,gid=1000,nls=utf8  0     0\\
UUID=4AF49046F4903663       /mnt/SeagateBackupPlus     ntfs    ro,noauto,relatime,umask=22,uid=0,gid=0,nls=utf8	0	0\\
UUID=4AF49046F4903663       /mnt/SeagateNTFS     ntfs    rw,noauto,relatime,umask=22,uid=0,gid=0,nls=utf8	0	0\\
UUID=2dd6c96e-4655-4a04-a8ca-7a5fd39d09bb       /mnt/PiHDD     ext4    defaults,noatime,noauto  0     0\\

EOF

CONFIG_FILE='/etc/fstab'

# Check/create Backup Config File
if [ ! -e $CONFIG_FILE.orig ]; then
	sudo cp $CONFIG_FILE $CONFIG_FILE.orig
fi

sed -f /tmp/sedscr $CONFIG_FILE >/tmp/fstab

# copy modified files from /tmp
sudo cp /tmp/fstab $CONFIG_FILE

# Create Mount Points
make_mount_point () {
echo $1
	if [ ! -e "/mnt/$1" ]; then
		sudo mkdir "/mnt/$1"
	fi
}

make_mount_point 'PiData'
make_mount_point 'Binnie'
make_mount_point 'SeagateBackupPlus'
make_mount_point 'SeagateNTFS'
make_mount_point 'PiHDD'
