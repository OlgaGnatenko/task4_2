#!/bin/bash

NTP_CONF=/etc/ntp.conf
ST_NTP=`dirname $0`/st_ntp.conf
NTP_DIFF=`diff -q $ST_NTP $NTP_CONF | wc -l`

STATUS =`ps ax | grep ntpd | grep -v grep | wc -l`
if [ $STATUS -eq "0" ] ; then
	/etc/init.d/ntp start
fi

if [ $NTP_DIFF -eq "1" ] ; then
	echo "NOTICE: NTP_CONF was changed. Calculated diff:"
	diff -u $ST_NTP $NTP_CONF
	cp $ST_NTP $NTP_CONF
	/etc/init.d/ntp restart
fi 

