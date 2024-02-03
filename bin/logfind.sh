#!/bin/bash
# Script to search log files for string

# LOGF="/var/log/syslog"	#log file to search
# SRCH="dhcpcd"	# string/s to search
# LOGF="/var/log/apt/history.log"	#log file to search
# SRCH="Start-Date:|Commandline:"	# string/s to search
# LOGF="/var/log/kern.log"	#log file to search
LOGF="//var/log/syslog"	#log file to search
# SRCH="kernel:|Synchronisation"	# string/s to search
# SRCH="kernel:|Network Time Synchronization"	# string/s to search
# SRCH="kernel:|Synchronization"	# string/s to search
# SRCH="kernel:|Synchronized"	# string/s to search
SRCH="kernel:|systemd-timesyncd"	# string/s to search

if [ -e $LOGF.1.gz ] || [ -e $LOGF.2.gz ]; then
	for logfile in $(ls $LOGF.*.gz | sort -rV) ; \
	do zcat $logfile | grep -E $SRCH  ; done
fi

if [ -e $LOGF.1 ]; then
	grep -E  $SRCH $LOGF.1
fi

# Include most recent
grep -E  $SRCH $LOGF

