#!/bin/sh
# sudo cd /var/lib/bluetooth
# sudo -i
# cd /var/lib/bluetooth
#
#
# sudo sh -c "cd /var/lib/bluetooth; ls  DC:A6:32:02:23:26"
# sudo sh -c "cd /var/lib/bluetooth; ls  DC:A6:32:02:23:26; echo $HOME"
# sudo sh -c "cd /var/lib/bluetooth; ls  DC:A6:32:02:23:26; echo $HOME"
#
# tar cf Pi4BT.tar /var/lib/bluetooth/DC:A6:32:02:23:26
#
# sudo sh -c "tar cf Pi4BT.tar /var/lib/bluetooth/DC:A6:32:02:23:26"
#
# tar -t -fPi4BT.tar
#
# BTID=$(bluetoothctl list > awk '/Controller/ {print $2}')
# sudo sh -c "tar cf Pi4BTc.tar /var/lib/bluetooth/$BTID"

# sudo sh -c "BTID=$(bluetoothctl list > awk '/Controller/ {print $2}'); tar cf Pi4BTd.tar /var/lib/bluetooth/$BTID"

# export BTID=$(bluetoothctl list > awk '/Controller/ {print $2}')
# sudo sh -c "tar cf Pi4BTe.tar /var/lib/bluetooth/$BTID"
# sudo sh -c "tar cf Pi4BTf.tar /var/lib/bluetooth/$(bluetoothctl list > awk '/Controller/ {print $2}')"

# sudo -E sh -c "tar cf Pi4BTe.tar /var/lib/bluetooth/$BTID"
# --preserve-env=BTID

if [ $# -eq 0 ] ; then
	BTFILE="Pi4BTh.tar"
else
	BTFILE=$1
fi


# BTID=$(sudo bluetoothctl list | awk '/Controller/ {print $2}')
BTID=$(bluetoothctl list | awk '/Controller/ {print $2}')
echo "BT Controller" $BTID
# export -p

# sudo -E --preserve-env=BTID sh -c "tar cf $BTFILE /var/lib/bluetooth/$BTID"
sudo -E sh -c "tar cf $BTFILE /var/lib/bluetooth/$BTID"

tar -t -f$BTFILE
