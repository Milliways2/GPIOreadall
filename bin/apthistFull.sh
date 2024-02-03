#!/bin/bash
#Print apt-get history
# 2017-08-06
# 2020-10-07	Include packages installed by packagekit
# for logf in $(ls /var/log/apt/history.log.*.gz | sort -rV) ; do zcat $logf | grep -E "Start-Date:|Commandline:" ; done
for logf in $(ls /var/log/apt/history.log.*.gz | sort -rV) ; do zcat $logf | grep -E -A 1 "Start-Date:|Commandline:" | sed -e '/Requested-By:/d' ; done
# Include most recent
# grep -E "Start-Date:|Commandline:" /var/log/apt/history.log
grep -E  -A 1  "Start-Date:|Commandline:" /var/log/apt/history.log | sed -e '/Requested-By:/d'
