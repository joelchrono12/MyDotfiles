#!/bin/bash	
current_ws="$(wmctrl -d | grep '*' | awk '{print $1}')"
wmctrl -r panel -t $current_ws
