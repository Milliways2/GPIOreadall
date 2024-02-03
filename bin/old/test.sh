#!/bin/bash
# script to customise AppleVolumes.default
# 2017-08-09

# copy sed script to a temporary file
cat << EOF > /tmp/sedscr
# Include DEFAULT line
/^:DEFAULT:/p
# Delete ALL following lines
/^:DEFAULT:/,\$d
EOF

sed -r -f /tmp/sedscr /etc/netatalk/AppleVolumes.default >/tmp/AppleVolumes.default

# Add customised access to end of file
cat >> /tmp/AppleVolumes.default << CONFIG

# By default all users have access to their home directories.
~/		\$hHome

:PIBOOT: options:upriv,usedots,noadouble
/boot	"\$hBoot"

:PIWWW: options:upriv,usedots,noadouble
/var/www	"\$h_WWW"

:PIROOT: options:ro,noadouble
/etc	"\$h_etc"
/usr	"\$h_usr"

# End of File
CONFIG

# copy modified files from /tmp
sudo cp /tmp/AppleVolumes.default /etc/netatalk/AppleVolumes.default
