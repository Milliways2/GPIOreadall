#!/bin/bash
#Print login history
# 2019-04-24
# 2021-01-16
echo "This only shows last 4 weeks by default "
for logf in $(ls /var/log/kern.log.*.gz | sort -rV) ; do zcat $logf | grep -E "Booting" ; done
# Include most recent
for logf in $(ls /var/log/kern.log.* | sort -rV) ; do cat $logf | grep -E "Booting" ; done

exit

# Alternative Method
echo "_______"
for logf in $(ls /var/log/messages*.gz | sort -rV) ; do zcat $logf | grep -E "Booting" ; done
# Include most recent
for logf in $(ls /var/log/messages* | sort -rV) ; do cat $logf | grep -E "Booting" ; done
