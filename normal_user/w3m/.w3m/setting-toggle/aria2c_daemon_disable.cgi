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
### Name            : aria2c_daemon_disable.cgi
### Version         : 0.1
### Date            : 2020-04-28
### Description     : stop aria2c daemon using dad(diana aria2c daemon)
### Depends On      : coreutils dad (https://github.com/baskerville/diana)
### Video Demo      : https://youtu.be/p5NZb8f8AHA
### References      : https://github.com/felipesaa/A-vim-like-firefox-like-configuration-for-w3m

printf '%s\n' "Stopping Aria2c Daemon..."
dad stop
