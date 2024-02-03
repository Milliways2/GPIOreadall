#! /bin/sh
# Check status of networking
# 2022-07-20
checkactive () {
if [ $(systemctl is-active $1) = 'active' ]; then
	echo $1 'active'
fi
}

checkactive 'systemd-networkd'
checkactive 'dhcpcd'
checkactive 'wpa_supplicant@wlan0'
checkactive 'wpa_supplicant@wlan'
checkactive 'wpa_supplicant'
