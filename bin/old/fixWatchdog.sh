#!/bin/bash
# Enable the Raspberry Pi hardware watchdog
# 2017-08-06

# adding the missing line to /lib/systemd/system/watchdog.service
cat /lib/systemd/system/watchdog.service | sed -e /[Install]/a\
WantedBy=multi-user.target>/tmp/watchdog.service

# Edit /etc/watchdog.conf to enable the watchdog device
sed -r /^#watchdog-device/s/^#// /etc/watchdog.conf >/tmp/watchdog.conf

# copy modified files from /tmp and enable watchdog.service
sudo cp /tmp/watchdog.conf /etc/watchdog.conf
sudo cp /tmp/watchdog.service /lib/systemd/system/watchdog.service
sudo systemctl enable watchdog
systemctl status watchdog.service
