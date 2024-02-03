#!/bin/bash
# script to customise ssmtp
# 2017-08-12
# 2018-11-30

# copy sed script to a temporary file
cat << EOF > /tmp/sedscr
/^\s*index/s/index/index index.php/
/^\s*location \//,/^\s*}/ {
/^\s*location \//,/^\s*}/s/ =404/ \/index.php\?\$args =404/
}

EOF

CONFIG_FILE='/etc/nginx/sites-available/default'

# Check/create Backup Config File
if [ ! -e $CONFIG_FILE.orig ]; then
	sudo cp $CONFIG_FILE $CONFIG_FILE.orig
fi

sed -f /tmp/sedscr $CONFIG_FILE >/tmp/nginx_sites

# copy modified files from /tmp
sudo cp /tmp/nginx_sites $CONFIG_FILE
