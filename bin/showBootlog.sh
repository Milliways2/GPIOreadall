#!/bin/bash
# script to show bootlogd messages
sed 's/\^\[/\o33/g;s/\[1G\[/\[27G\[/' /var/log/boot