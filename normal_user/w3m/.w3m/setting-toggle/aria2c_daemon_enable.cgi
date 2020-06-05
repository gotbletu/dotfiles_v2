#!/usr/bin/env sh
###             _   _     _      _         
###  __ _  ___ | |_| |__ | | ___| |_ _   _ 
### / _` |/ _ \| __| '_ \| |/ _ \ __| | | |
###| (_| | (_) | |_| |_) | |  __/ |_| |_| |
### \__, |\___/ \__|_.__/|_|\___|\__|\__,_|
### |___/                                  
###       https://www.youtube.com/user/gotbletu
###       https://lbry.tv/@gotbletu
###       https://twitter.com/gotbletu
###       https://github.com/gotbletu
###       gotbletu@gmail.com
###
### Author          : gotbletu
### Name            : aria2c_daemon_enable.cgi
### Version         : 0.1
### Date            : 2020-04-28
### Description     : start aria2c daemon using dad(diana aria2c daemon)
### Depends On      : coreutils dad (https://github.com/baskerville/diana)
### Video Demo      : https://youtu.be/p5NZb8f8AHA
### References      : https://github.com/felipesaa/A-vim-like-firefox-like-configuration-for-w3m

clear

# if directory doesnt exist or variable not set then use default and create directory structure
if [ "$PATH_ARIA_DAEMON_DOWNLOAD_DIR" = "" ]; then PATH_ARIA_DAEMON_DOWNLOAD_DIR=$HOME/Downloads/Aria ; fi
mkdir -p "$PATH_ARIA_DAEMON_DOWNLOAD_DIR"

# start aria2c daemon using dad(diana aria2c daemon)
printf '%s\n' "Starting Aria2c Daemon..."
printf '%s\n' "Download To: $PATH_ARIA_DAEMON_DOWNLOAD_DIR"
dad -d "$PATH_ARIA_DAEMON_DOWNLOAD_DIR" start
