#!/bin/bash

STATUS=$(vcgencmd get_throttled | sed -n 's|^throttled=\(.*\)|\1|p')
if [[ ${STATUS} -ne 0 ]]; then
  echo ""
  if [ $((${STATUS} & 0x00001)) -ne 0 ]; then
    echo "Power is currently Under Voltage"
  elif [ $((${STATUS} & 0x10000)) -ne 0 ]; then
    echo "Power has previously been Under Voltage"
  fi
  if [ $((${STATUS} & 0x00002)) -ne 0 ]; then
    echo "ARM Frequency is currently Capped"
  elif [ $((${STATUS} & 0x20000)) -ne 0 ]; then
    echo "ARM Frequency has previously been Capped"
  fi
  if [ $((${STATUS} & 0x00004)) -ne 0 ]; then
    echo "CPU is currently Throttled"
  elif [ $((${STATUS} & 0x40000)) -ne 0 ]; then
    echo "CPU has previously been Throttled"
  fi
  if [ $((${STATUS} & 0x00008)) -ne 0 ]; then
    echo "Currently at Soft Temperature Limit"
  elif [ $((${STATUS} & 0x80000)) -ne 0 ]; then
    echo "Previously at Soft Temperature Limit"
  fi
  echo ""
fi
