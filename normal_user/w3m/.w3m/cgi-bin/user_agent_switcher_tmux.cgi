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

# mode: xsession -> use xdotool ; tmux -> use tmux send-keys
export W3M_SETTING_MODE=tmux

# cgi user-agent scripts location
DIR="$HOME/.w3m/user-agent"

# select cgi file
SELECTED=$(ls "$DIR" | fzf)

# exit script if no selection was made (e.g ESC)
if [ "$SELECTED" = "" ]; then exit; fi

# set the default w3m hotkeys if empty
if [ "$W3M_HOTKEY_OPTIONS" = "" ]; then export W3M_HOTKEY_OPTIONS='o' ; fi
if [ "$W3M_HOTKEY_LINK_BEGIN" = "" ]; then export W3M_HOTKEY_LINK_BEGIN='[' ; fi
if [ "$W3M_HOTKEY_RELOAD" = "" ]; then export W3M_HOTKEY_RELOAD='R' ; fi

# execute external script
(sleep 1 && "$DIR/$SELECTED") &
