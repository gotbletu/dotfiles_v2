#!/usr/bin/env bash
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
### Name            : tmux
### Version         : 0.1
### Date            : 20161221
### Description     : A terminal multiplexer
### Depends On      : ncurses  libevent  libutempter
### Video Demo      : https://youtu.be/dTpEuQZRRDM
### Source          : https://gist.github.com/fxsjy/5465353
### References      : http://mannned.org/wget

# clear screen
clear
pidof tmux >/dev/null && tmux clear-history

# ! env | sort | less
# W3M_URL - w3m current url browser is on
# W3M_CURRENT_LINK - w3m current cursor url
lynx -listonly -nonumbers -dump "$W3M_URL" |grep \.7z | less


# # user input extensions
# printf '%s\n'
# read -p ">>> Enter File Extension(s) To Bulk Download (e.g mp3 mp4) (.* = All): " INPUT
#
# # clear screen
# clear
# pidof tmux >/dev/null && tmux clear-history
#
# # results filtered
# EXTENSION=$(printf '%s\n' "$INPUT" | sed -e 's@ @\\|.@g')
# URI=$(lynx -listonly -nonumbers -dump "$W3M_URL" | grep ."$EXTENSION")
# printf '%s\n' "$URI"
# printf '%s\n'
#
#
# # user input add or add paused
# read -p ">>> Add These URI To The Aria2c Daemon? (a = Add, p = Add PAUSED): " CHOICES
# if [[ $CHOICES =~ ^[Aa]$ ]]
# then
#   printf '%s\n' "$URI" | while read URI_LINKS ; do diana add "$URI_LINKS"; done
# elif [[ $CHOICES =~ ^[Pp]$ ]]
# then
#     printf '%s\n' "$URI" | while read URI_LINKS ; do diana --pause add "$URI_LINKS"; done
# else
#   exit
# fi
#
#
# printf '%s\n'
# read -rsp $'Press any key to continue...\n' -n1 key
#
#
#
