#!/usr/bin/env sh
###             _   _     _      _         
###  __ _  ___ | |_| |__ | | ___| |_ _   _ 
### / _` |/ _ \| __| '_ \| |/ _ \ __| | | |
###| (_| | (_) | |_| |_) | |  __/ |_| |_| |
### \__, |\___/ \__|_.__/|_|\___|\__|\__,_|
### |___/                                  
###       https://www.youtube.com/user/gotbletu
###       https://twitter.com/gotbletu
###       https://github.com/gotbletu
###       gotbletu@gmail.com
###
### Author          : gotbletu
### Name            : user_agent_switcher_tmux.cgi
### Version         : 0.1
### Date            : 20190617
### Description     : interactive user agent switcher
### Depends On      : w3m fzf tmux coreutils
### Video Demo      : https://youtu.be/dTpEuQZRRDM
### Source          : https://gist.github.com/fxsjy/5465353
### References      : http://mannned.org/wget


# select your user agent
SELECTED=$(ls ~/.w3m/user-agent-switcher-tmux | fzf)

# exit script if nothing is selected
if [ "$SELECTED" = "" ]; then exit; fi

## Default w3m hotkeys
# HOTKEY_OPTIONS='o'
# HOTKEY_LINK_BEGIN='['
# HOTKEY_RELOAD='R'
HOTKEY_OPTIONS=':O'
HOTKEY_LINK_BEGIN='f'
HOTKEY_RELOAD='r'

# allow external scripts to use the variable
export HOTKEY_OPTIONS
export HOTKEY_LINK_BEGIN
export HOTKEY_RELOAD
export SELECTED

# change to mode to tmux
export SETTING_MODE=tmux

# execute external script to change user agent
(sleep 1 && ~/.w3m/user-agent-switcher-tmux/"$SELECTED") &
