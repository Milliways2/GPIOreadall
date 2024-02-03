#! /bin/sh
# Script to list networking files  using systemd-networkd
# 2022-07-25

# ll /etc/wpa_supplicant/ && ll /etc/systemd/network/
ls -la /etc/wpa_supplicant/
ls -la /etc/systemd/network/

sudo systemctl status systemd-networkd

systemctl list-units --type=service | grep wpa_supplicant
