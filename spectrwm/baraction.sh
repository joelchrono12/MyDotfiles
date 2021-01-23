#!/bin/bash
# Example Bar Action Script for Linux.
# Requires: acpi, iostat, lm-sensors, aptitude.
# Tested on: Debian Buster(with newest spectrwm built from source), Debian Bullseye, Devuan Chimaera, Devuan Ceres
# This config can be found on github.com/linuxdabbler

############################## 
#	    DISK
##############################
trap 'update' 5

mpd(){
	song="$(mpc current)"
	status="$(mpc status | grep paused | awk '{print $1}')"
	echo -e "$song"
}

win(){
	win_in_ws="$(~/.config/spectrwm/scripts/windows_in_workspace.sh)"
	echo -e "$win_in_ws"
}
hdd() {
	hdd="$(df -h /home | grep /dev | awk '{print $3 " / " $2}')"
	    echo -e " $hdd"
    }
##############################
#	    RAM
##############################

mem() {
used="$(free -h | grep Mem: | awk '{print $3}')"
#total="$(free | grep Mem: | awk '{print $2}')"

#totalh="$(free -h | grep Mem: | awk '{print $2}' | sed 's/Gi/G/')"

ram="$used"

echo $ram
}
##############################	
#	    CPU
##############################

cpu() {
	  read cpu a b c previdle rest < /proc/stat
	    prevtotal=$((a+b+c+previdle))
	      sleep 0.5
	        read cpu a b c idle rest < /proc/stat
		  total=$((a+b+c+idle))
		    cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
		      echo -e "  $cpu%"
	      }
##############################
#	    VOLUME
##############################
vol() {	
	vol="$(amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $2 }')"
	volstat=$(pamixer --get-volume)

vol=$(echo "$volstat")

if [ "$vol" -gt "70" ]; then
	volicon=" "
elif [ "$vol" -eq "0" ]; then
	volicon="婢"
elif [ "$vol" -lt "30" ]; then
	volicon=""
else
	volicon="墳"
fi

	echo -e "$volicon $vol"
}
##############################
#	    Packages
##############################

pkgs() {
	pkgs="$(xbps-query -l | wc -l)"
	echo -e " $pkgs"
}
##############################
#	    UPGRADES
##############################

upgrades() {
	upgrades="$(xbps-install -Sun | wc -l)"
	echo -e " $upgrades"
}
##############################
#	    VPN
##############################

vpn() {
	state="$(ip a | grep tun0 | grep inet | wc -l)"
	
if [ $state = 1 ]; then
    echo "on"
else
    echo "off"
fi
}
## WEATHER
weather() {
	wthr="$(sed 20q ~/.config/weather.txt | grep value | awk '{print $2 $3}' | sed 's/"//g')"
	echo " $wthr"
}

## TEMP
temp() {
	tmp="$(curl -s wttr.in | grep -m 1 °C | awk '{print $5 $6}')"
	##tmp="$(grep temp_F ~/.config/weather.txt | awk '{print $2}' | sed 's/"//g' | sed 's/,/ F/g')"
	echo " $tmp"
}

## BATTERY
bat() {
batstat="$(cat /sys/class/power_supply/BAT0/status)"
battery="$(cat /sys/class/power_supply/BAT0/capacity)"
    if [ $batstat = 'Unknown' ]; then
    batstat=""
    elif [[ $battery -ge 5 ]] && [[ $battery -le 19 ]]; then
    batstat=""
    elif [[ $battery -ge 20 ]] && [[ $battery -le 39 ]]; then
    batstat=""
    elif [[ $battery -ge 40 ]] && [[ $battery -le 59 ]]; then
    batstat=""
    elif [[ $battery -ge 60 ]] && [[ $battery -le 79 ]]; then
    batstat=""
    elif [[ $battery -ge 80 ]] && [[ $battery -le 95 ]]; then
    batstat=""
    elif [[ $battery -ge 96 ]] && [[ $battery -le 100 ]]; then
    batstat=""
fi

echo "$batstat  $battery"
}

network() {
wifi="$(ip a | grep wlp2s0 | grep inet | wc -l)"
## wire="$(ip a | grep eth0 | grep inet | wc -l)"
## wifi="$(ip a | grep wlan | grep inet | wc -l)"
wire="$(ip a | grep enp1s0 | grep inet | wc -l)"
if [ $wire = 1 ]; then 
    echo " "
elif [ $wifi = 1 ]; then
    echo " "
else 
    echo "睊"
fi
}
      #loops forever outputting a line every SLEEP_SEC secs
update(){
	echo "$(win) $(mpd) $(cpu) +@bg=1; +@fg=1;  $(mem) +@bg=2;  $(pkgs) +@bg=3;  $(hdd) +@bg=4; $(vol) +@bg=5; $(bat) +@bg=6; $(network)"
    wait
}    
while :; do     
    #echo "$(cpu)| $(mem)| $(pkgs)|﯁ $(upgrades)| $(hdd)| $(vpn)| $(vol)|$(bat)|$(weather) $(temp)| $(network)|"
		update
		~/.config/spectrwm/scripts/trayer_follows_ws.sh
    sleep 2 &
    wait
done
