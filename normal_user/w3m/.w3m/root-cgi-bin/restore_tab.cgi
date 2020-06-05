#!/usr/bin/env sh
###  __      _ _                             
### / _| ___| (_)_ __   ___  ___  __ _  __ _ 
###| |_ / _ \ | | '_ \ / _ \/ __|/ _` |/ _` |
###|  _|  __/ | | |_) |  __/\__ \ (_| | (_| |
###|_|  \___|_|_| .__/ \___||___/\__,_|\__,_|
###             |_|                          
###       https://github.com/felipesaa
###
### Author          : felipesaa
### Name            : restore_tab.cgi
### Version         : 0.1
### Date            : 2018-09-30
### Description     : restore a closed tab in w3m
### Depends On      : w3m coreutils
### Video Demo      : https://www.youtube.com/watch?v=0Xhvd8ISO8g
### Source          : https://github.com/felipesaa/A-vim-like-firefox-like-configuration-for-w3m
### References      : http://w3m.sourceforge.net/MANUAL#LocalCGI
### Install         : put this script in /usr/lib/w3m/cgi-bin/

#Open the last closed tab
last_tab=$(tail -n 1 ~/.w3m/RestoreTab.txt);
#limit of tabs stored
limit=$(tail -n 20 ~/.w3m/RestoreTab.txt);
other_tabs=$(printf "%s" "$limit" | head -n -1);
printf "%s\r\n" "$other_tabs" > ~/.w3m/RestoreTab.txt;
printf "%s\r\n" "W3m-control: GOTO $last_tab";
printf "W3m-control: DELETE_PREVBUF\r\n"
