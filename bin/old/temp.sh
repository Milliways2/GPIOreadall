#!/bin/bash
#
# read the temperature and convert “59234″ into “59.234″ (degrees celsius)
TEMPERATURE=`cat /sys/class/thermal/thermal_zone0/temp`
echo -n ${TEMPERATURE:0:2}; echo -n .; echo -n ${TEMPERATURE:2}
