#!/bin/bash
# script to create pi-gpio deb
# 2022-08-04 use install, include HEADERS
# 2022-08-10 update HEADERS MANPAGES
# 2022-09-10 select dist directory
# 2022-12-02 Install python overlay
# 2022-12-12 REVISION
# 2022-12-18 /lib/python3/dist-packages/
# 2022-12-23 /usr/lib/python3/dist-packages/
# 2022-12-24 gpioStatus

if [[ $(uname -m) == "aarch64" ]]; then
	ARCH='arm64'
else
	ARCH='armhf'
fi
echo $ARCH

REVISION="$1"
if [ "${REVISION}" = "" ]; then
REVISION="1"
fi

# Select destination directory for deb
# Comment out if not required the default is current
cd $HOME/dist

LIBNAME='pi-gpio'
SOURCE="$HOME/$LIBNAME/source"
VERS=$(cat $HOME/$LIBNAME/VERSION)
VERSION="$VERS-$REVISION"
echo 'VERSION ' $VERSION

# list of headers to include
HEADERS="$LIBNAME.h pi-vers.h pi-spi.h pi-i2c.h MCP23017.h"
# list of man pages to include
MANPAGES="$LIBNAME.3 MCP23017.3"

# Rebuild library files
CURRENT_DIR=$(pwd)
cd $SOURCE
make clean
make
cd $CURRENT_DIR

DYNAMIC="lib$LIBNAME.so.$VERS"
DEB_DIR="${LIBNAME}_${VERSION}_$ARCH"
echo "DEB_DIR = $DEB_DIR"

# Make DEB structure
mkdir -p $DEB_DIR
rm -rf $DEB_DIR/*

mkdir -p $DEB_DIR/usr/lib
mkdir -p $DEB_DIR/usr/include
mkdir -p $DEB_DIR/usr/share/man/man3
mkdir -p $DEB_DIR/DEBIAN
mkdir -p $DEB_DIR/usr/lib/python3/dist-packages/
mkdir -p $DEB_DIR/usr/bin


cp $SOURCE/$DYNAMIC $DEB_DIR/usr/lib/
ln -sfr $DEB_DIR/usr/lib/$DYNAMIC $DEB_DIR/usr/lib/lib${LIBNAME}.so

cd $SOURCE
install -m 0644 $HEADERS	$CURRENT_DIR/$DEB_DIR/usr/include/

install -m 0644 $MANPAGES	$CURRENT_DIR/$DEB_DIR/usr/share/man/man3/

install -m 0644 -p pi_gpio.py	$CURRENT_DIR/$DEB_DIR/usr/lib/python3/dist-packages/
sudo install -o root -m 0755 -p gpioStatus	$CURRENT_DIR/$DEB_DIR/usr/bin/

# Create DEBIAN control file
cat << EOF > $CURRENT_DIR/$DEB_DIR/DEBIAN/control
Package: $LIBNAME
Version: $VERS
Section: libraries
Priority: optional
Architecture: $ARCH
Depends: libc6
Maintainer: Ian Binnie <milliways@binnie.id.au>
Description: A dynamic C library to control Raspberry Pi GPIO channels
	includes python overlay
EOF

# Build .deb
dpkg-deb --build $CURRENT_DIR/$DEB_DIR
