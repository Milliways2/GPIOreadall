#!/bin/bash
#Print apt-get history EXCEPT for upgrades
# 2017-08-06
# 2020-10-07	Include packages installed by packagekit
# 2020-12-04	delete lines containing 'apt upgrade' and preceding line
# 2021-04-04

# Edit /etc/logrotate.d/apt for more history

if [ -e /var/log/apt/history.log.1.gz ]; then
	for logf in $(ls /var/log/apt/history.log.*.gz | sort -rV) ; \
	 do zcat $logf | grep -E -A 1 "Start-Date:|Commandline:" | sed -e '/Requested-By:/d' ; done \
	  | tac | sed -e '/^--/d' -e '/apt .*upgrade/{N;d;}' | tac
fi

# Include most recent
grep -E  -A 1  "Start-Date:|Commandline:" /var/log/apt/history.log | sed -e '/Requested-By:/d' \
  | tac | sed -e '/^--/d' -e '/apt .*upgrade/{N;d;}' | tac
