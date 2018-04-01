#!/bin/bash

apt-get install ntp -y

PWD=`dirname $0`

NTP_CONF="/etc/ntp.conf"
OLD_NTP='^pool '
NEW_NTP="pool ua.pool.ntp.org iburst"

sed -i "/$OLD_NTP/d" $NTP_CONF
echo "$NEW_NTP" >> $NTP_CONF

cat /etc/ntp.conf > $PWD/st_ntp.conf

/etc/init.d/ntp restart

PWD=`pwd`
(cat /etc/crontab | grep ntp_verify.sh) || echo "* * * * * root $PWD/ntp_verify.sh" >> /etc/crontab



