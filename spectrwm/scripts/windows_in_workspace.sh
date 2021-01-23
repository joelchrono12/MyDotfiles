#!/bin/bash
# A simple script that shows how many windows are open inside of current workspace
ws_icon="$(wmctrl -d | grep "*" | awk '{print $9}')"
windows_number="$(wmctrl -l | grep -v panel | awk '{print $2}'))"
current_ws="$(wmctrl -d | grep '*' | awk '{print $1}')"
windows_in_ws="$(echo -e "$windows_number" | grep $current_ws | wc -l)"
echo -e "[$ws_icon ] [$windows_in_ws]"

