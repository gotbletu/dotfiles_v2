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
### Name            : surfraw.cgi
### Version         : 0.1
### Date            : 20190617
### Description     : interactive surfraw smart prefix search engine (mainly use within w3m web browser)
### Depends On      : surfraw  fzf  xsel  gawk  coreutils  grep
### Video Demo      : https://youtu.be/dTpEuQZRRDM
### Source          : https://gist.github.com/fxsjy/5465353
### References      : http://mannned.org/wget

# select your user agent
SELECTED=$(ls ~/.w3m/setting-toggle/* | fzf)

# exit script if no selection was made
if [ "$SELECTED" = "" ]; then exit; fi

## Default w3m hotkeys
HOTKEY_OPTIONS=':O'
HOTKEY_LINK_BEGIN='f'
HOTKEY_RELOAD='r'

# set the default w3m hotkeys if user have not use any custom binding
if [ "$W3M_HOTKEY_OPTIONS" = "" ]; then
  export W3M_HOTKEY_OPTIONS='o'
elif [ "$W3M_HOTKEY_LINK_BEGIN" = "" ]; then
  export W3M_HOTKEY_LINK_BEGIN='['
elif [ "$W3M_HOTKEY_RELOAD" = "" ]; then
  export W3M_HOTKEY_RELOAD='R'
fi

# allow external scripts to use the variable
export W3M_HOTKEY_OPTIONS
export W3M_HOTKEY_LINK_BEGIN
export W3M_HOTKEY_RELOAD
export SELECTED

# change to mode to xsession to use xdotool
export SETTING_MODE=xsession

# execute external script
(sleep 1 && "$SELECTED") &

