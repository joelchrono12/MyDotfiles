#!/bin/bash

# Simple script to handle a DIY shutdown menu. When run you should see a bunch of options (shutdown, reboot etc.)
#
# Requirements:
# - rofi
# - systemd, but you can replace the commands for OpenRC or anything else
#
# Instructions:
# - Save this file as power.sh or anything
# - Give it exec priviledge, or chmod +x /path/to/power.sh
# - Run it

chosen=$(echo -e "[Cancel]\nLogout\nShutdown\nReboot WM\nReboot System\nEdit Awesome config\nEdit Awesome theme\nEdit bashrc\nEdit power menu" | rofi -dmenu -i -p "Power Menu:")
# Info about some states are available here:
# https://www.freedesktop.org/software/systemd/man/systemd-sleep.conf.html#Description

if [[ $chosen = "Logout" ]]; then
	echo 'awesome.quit()' | awesome-client
elif [[ $chosen = "Shutdown" ]]; then
	sudo poweroff
elif [[ $chosen = "Reboot WM" ]]; then
	echo 'awesome.restart()' | awesome-client
elif [[ $chosen = "Reboot System" ]]; then
	sudo reboot
elif [[ $chosen = "Edit Awesome config" ]]; then
	gedit $HOME/.config/awesome/rc.lua
elif [[ $chosen = "Edit Awesome theme" ]]; then
	gedit $HOME/.config/awesome/themes/zenburn/theme.lua
elif [[ $chosen = "Edit bashrc" ]]; then
	gedit $HOME/.bashrc
elif [[ $chosen = "Edit power menu" ]]; then
	gedit $HOME/.config/rofi/scripts/power-menu.sh
fi
