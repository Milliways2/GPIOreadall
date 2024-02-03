#!/bin/bash
# Show movie on Pi
#VIDEO=$1
#VIDEO="/media/TSB USB DRV/Midsomer Murders/Surviving Midsomer - An Insiders Guide (24 May 2008) [TVRip (XviD)].avi"
#VIDEO="/media/TSB USB DRV/Midsomer Murders/Super Sleuths- Midsomer Murders - [ABC1 2012-04-08]!!.divx"
VIDEO="/home/pi/Super Sleuths- Midsomer Murders - [ABC1 2012-04-08]!!.divx"
# omxplayer Surviving\ Midsomer\ -\ An\ Insiders\ Guide\ \(24\ May\ 2008\)\ \[TVRip\ \(XviD\)\].avi 
setterm -clear -blank 0 -cursor off
omxplayer "$VIDEO" >null
setterm -blank 1 -cursor on
