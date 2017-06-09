#!/bin/bash

#Find the script base path (used to find mapping file)
SCRIPT_PATH="`dirname \"$0\"`"              # relative
SCRIPT_PATH="`( cd \"$SCRIPT_PATH\" && pwd )`"  # absolutized and normalized
if [ -z "$SCRIPT_PATH" ] ; then
  # error; for some reason, the path is not accessible
  # to the script (e.g. permissions re-evaled after suid)
  exit 1  # fail
fi

if [ "$1" = "-g" ]; then
	deviceid=$(<$SCRIPT_PATH/../mapping/$2)
	if [[ $deviceid = 28-* ]]; then
		/bin/cat /sys/bus/w1/devices/$deviceid/w1_slave|grep "t="|/usr/bin/awk '{print $10}'|/bin/sed 's/t=//g'|/bin/sed 's/\(..\)\(...\)/\1.\2/'
	else
		echo "No suitable mapping found"
		exit 1 # fail
	fi
else
	echo " "
	echo "     ERROR: Not correct parameter given"
	echo "     Parameter usage: "
	echo "     	-g OID "
	echo " "
	echo "     Example: -g iso.3.6.1.4.1.65655.100.4.1.1.1.7.1"
	echo " "
fi
exit 0
