To perform a fresh install on the Pi
2019-06-20-raspbian-buster.zip

	Preparation
	1. On working Pi backup home directory & ssh keys
		cd /home; sudo tar czf pi_home.tar.gz pi

		#PBackup ssh host keys & config (script sshBackup)
		# 2021-08-18
		cd /etc/ssh

		#PBackup ssh host keys
		sudo tar czf /home/pi/SshKeys.tgz *key *.pub moduli

		#PBackup ssh config
		cd /etc/ssh
		sudo tar czf /home/pi/SshConf.tgz *config

	2. Prepare list of user installed apps to install on new Pi.
	3. Backup Bluetooth
		sudo su
		tar cf bluePi4.tar /var/lib/bluetooth

pi@MilliwaysPi3Plus ~ $ file SshKeys.tgz
SshKeys.tgz: gzip compressed data, last modified: Wed Aug 18 04:14:03 2021, from Unix, original size modulo 2^32 583680
pi@MilliwaysPi3Plus ~ $ hist SshKeys
   26  2021-08-18	file SshKeys.tgz



1. Install new image on SD Card.
2. Mount boot partition, and
	touch ssh
	copy wpa_supplicant.conf
3. Boot Pi and configure (prompt on screen including update);
	change password
	Set Locale	en Au UTF-8
	Set Timezone	Sydney
	Set Keyboard	US International
	Set WiFi Country	AU
	turn off serial console & serial

Change your Appearance Settings
	Appearance Settings/Defaults/Small
	Picture to /usr/share/raspberrypi-artwork/raspberry-pi-logo-small.png
	Menu Bar Medium (24x24)

	Appearance Settings/Font 12

	https://raspberrypi.stackexchange.com/a/122127/8697

	<name>PiX</name>
	    <titleLayout>CIMNLS</titleLayout>

	copy /mnt/Pi4/.config/lxpanel/LXDE-pi/panels/panel

4 ftp pi_home.tar.gz to /home and copy contents to new Pi
	cd /home; sudo tar -xzf pi_home.tar.gz

Update .ssh/known_hosts on iMac


5 Restore ssh keys
	#Replace ssh host keys  (script sshReplace)
	# 2021-08-18
	cd /etc/ssh
	sudo tar xzf /home/pi/SshKeys.tgz

6 Set hostname
	sudo ./WhichPi2.sh
7 Customise config.txt;
	NOTE changed config
	<!-- 	sudo ./setupConfig.sh -->
	<!-- 8 General tidy - delete .Wolfram etc not installed -->
8 Customise /etc/dhcpcd.conf
	slaac hwaddr
	#slaac private
9 Install Apps	PiApps.sh
<!-- 	filezilla netatalk gparted ssmtp mailutils watchdog apt-file -->
	filezilla  gparted   watchdog apt-file

sudo apt install samba samba-common-bin smbclient cifs-utils

sudo smbpasswd -a pi
	(enter password for user within Samba - does not have to be the log in password)
sudo service smbd restart
<!--
12 Configure ssmtp ????
	configssmtp.sh
	sudo adduser pi mail
 -->
14 Customise	fstab
	configSftab.sh
15	install nfs-kernel-server

10 Customise	/etc/netatalk/afp.conf 2019-06-27
	NOTE changed config

	11	Setup VNCserver
		sudo ./setupVNC.sh
13 Restore Bluetooth 2019-06-28
	sudo su
	cd /
	tar xf /home/pi/bluePi3.tar
15	install nfs-kernel-server

	Edit /etc/logrotate.d/apt to keep 36 months


________________ 2021-08-18

sudo apt install build-essential
sudo apt-get install python3-dev

________________

16 Install NGINX 2018-11-30
	sudo apt install nginx
	sudo apt install php-fpm

16a Configure nginx
	/etc/nginx/sites-available/default
	confignginx.sh
	sudo adduser pi www-data
	sudo chown -R www-data:www-data /var/www/*
	Configure PHP (uncomment) as per https://www.raspberrypi.org/documentation/remote-access/web-server/nginx.md

dpkg-query -f '${binary:Package}\n' -W > Pi2Packages.txt
