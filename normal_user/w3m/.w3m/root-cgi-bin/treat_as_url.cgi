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
### Name            : treat_as_url.cgi
### Version         : 0.1
### Date            : 2018-09-30
### Description     : turn all w3m plain text urls to real clickable urls (aka auto mark url).
###                 : this will mess up the numbers order in hinting mode.
### Depends On      : w3m coreutils
### Video Demo      : https://www.youtube.com/watch?v=0Xhvd8ISO8g
### Source          : https://github.com/felipesaa/A-vim-like-firefox-like-configuration-for-w3m
### References      : http://w3m.sourceforge.net/MANUAL#LocalCGI
### Install         : put this script in /usr/lib/w3m/cgi-bin/

# newsboat:
#           vim ~/.newsboat/config
#             pager "w3m /usr/lib/w3m/cgi-bin/treat_as_url.cgi %f"
#
# w3m auto mark url in regular files:
#           w3m /usr/lib/w3m/cgi-bin/treat_as_url.cgi filename.txt
#
# w3m auto mark url from websites:
#           w3m /usr/lib/w3m/cgi-bin/treat_as_url.cgi <url>
#
# alias for ~/.bashrc or ~/.zshrc:
# if [ -f "/usr/lib/w3m/cgi-bin/treat_as_url.cgi" ] ; then
#     alias w3m="w3m /usr/lib/w3m/cgi-bin/treat_as_url.cgi"
# fi

printf "%s\r\n" "W3m-control: PREV";
printf "%s\r\n" "W3m-control: MARK_URL"
