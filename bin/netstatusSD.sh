#! /bin/sh
# Script to list networking files  using systemd-networkd
# 2022-07-25

SD='/mnt/SDA2'

ls -la $SD/etc/wpa_supplicant/
ls -la $SD/etc/systemd/network/

# sudo systemctl status systemd-networkd

# systemctl list-units --type=service | grep wpa_supplicant
