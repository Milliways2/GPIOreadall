#! /bin/sh

# 2020-10-07	Include packages installed by packagekit

# delete lines containing 'apt upgrade' and preceding line
# useful for finding apt history EXCEPT for upgrades
# run on output of apthist.sh

# cat $1 | tac | sed '/apt upgrade/{N;d;}' | tac
cat $1 | tac | sed -e '/^--/d' -e '/apt .*upgrade/{N;d;}' | tac
