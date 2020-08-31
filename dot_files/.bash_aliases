#!/bin/bash

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Tree shortcuts
alias lt='tree -L 1 -a'
alias lt2='tree -L 2 -a'
alias lt3='tree -L 3 -a'

# Check Internet Connection
alias internet='~/.bashrc_scripts/check_internet.sh'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=critical -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# git add and commit
alias gitac='git add . && git commit -m "minor changes"'

# pytest quick test
alias pytestq='~/.bashrc_scripts/pytest_quick_test.sh'

# DTSP VPN
alias vpn_dtsp='sudo openvpn --config /home/ismet/Downloads/VPN/ismet-dtsp.ovpn'
