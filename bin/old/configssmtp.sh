#!/bin/bash
# script to customise ssmtp
# 2017-08-10

# copy sed script to a temporary file
cat << EOF > /tmp/sedscr
/^root=/c\\
root=binnie.raspberry.pi\@gmail.com

/^mailhub=/{
a\\
\\
AuthUser=binnie.raspberry.pi@gmail.com\\
AuthPass=VsS68c9gN^%dzVwc\\
AuthMethod=LOGIN\\
UseTLS=YES\\
UseSTARTTLS=YES
c\\
mailhub=smtp.gmail.com:587
}

/rewriteDomain=/c\\
rewriteDomain=gmail.com
/hostname=/c\\
hostname=RaspberryPi.binnie.id.au
/FromLineOverride=/c\\
FromLineOverride=YES
EOF

sed -r -f /tmp/sedscr /etc/ssmtp/ssmtp.conf >/tmp/ssmtp.conf

# cat > /etc/ssmtp/revaliases << HERE
cat /etc/ssmtp/revaliases> /tmp/revaliases
cat  << HERE >> /tmp/revaliases
root:binnie.raspberry.pi@gmail.com:smtp.gmail.com:587
pi:binnie.raspberry.pi@gmail.com:smtp.gmail.com:587
HERE

# copy modified files from /tmp
sudo cp /tmp/ssmtp.conf /etc/ssmtp/ssmtp.conf
sudo cp /tmp/revaliases /etc/ssmtp/revaliases
# sudo chmod o-r /etc/ssmtp/ssmtp.conf
