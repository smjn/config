#!/bin/bash

case "$OSTYPE" in
linux-gnu)
	if which sensors >/dev/null; then
		CPU=$(sensors | grep Tctl | awk '{print $2;}' | grep -oEi '[0-9]+.[0-9]+' | awk '{total+=$1; count+=1} END {print total/count}')
		GPU=$(sensors | grep edge | awk '{print $2;}' | grep -oEi '[0-9]+.[0-9]+')
		FAN=$(sensors | grep fan1 | awk '{print $2;}')
		printf " %2.1f C  %2.1f C  %4d rpm" $CPU $GPU $FAN
	else
		""
	fi
	;;
esac
