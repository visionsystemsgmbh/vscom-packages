#!/bin/sh

while true
do
	while logread -l 10 | grep "urb failed"
	do
		logger reinitialize usb bus
		/etc/init.d/netcom stop
		echo 0 >/sys/bus/usb/devices/usb1/authorized
		sleep 1
		echo 1 >/sys/bus/usb/devices/usb1/authorized	
		sleep 1
		/etc/init.d/netcom start
		exit 0
	done
done
