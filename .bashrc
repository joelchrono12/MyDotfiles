

alias ls='exa -al --color=always --group-directories-first'
alias la='exa -a  --color=always --group-directories-first'
alias lt='exa -aT  --color=always --group-directories-first'
alias l.='exa -a | grep "^\."'  
alias ll='exa -l  --color=always --group-directories-first'
alias bashrc='gedit ~/.bashrc & exit'
alias rclua='gedit ~/.config/awesome/rc.lua & exit'
alias spectrwmconf='gedit ~/.spectrwm.conf & exit'
alias ..='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias xin='sudo xbps-install -S'
alias xup='sudo xbps-install -Suv'
alias xun='sudo xbps-remove -R'
alias xs='xbps-query -Rs'
alias xme='sudo xbps-query -m'
alias sysinfo='inxi -Frxz'
alias cp='cp -i'
alias df='df -h'
alias v='nvim'
alias picom='picom --experimental-backends --backend glx --blur-method 'dual_kawase' --blur-strength 6 & disown'


export PATH=$PATH:$HOME/bin:$HOME/.local/bin:$HOME/.config/spectrwm/scripts
#source $HOME/.config/bash-config/bashrc.bash
eval "$(starship init bash)"

pfetch


