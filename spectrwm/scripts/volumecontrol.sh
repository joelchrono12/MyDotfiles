#!/bin/bash
#

volumecontrol() {
	pkill -SIGTRAP baraction.sh
	case $1 in
	increase)
	    amixer set Master 5%+ 
		;;
	decrease)
		amixer set Master 5%-
		;;
	toggle)
		amixer set Master toggle 
		;;
	*)
		;;
	esac;
}

volumecontrol $1
