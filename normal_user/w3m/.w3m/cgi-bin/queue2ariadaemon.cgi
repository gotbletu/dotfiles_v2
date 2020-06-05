#!/usr/bin/env bash
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
### Name            : queue2ariadaemon.cgi
### Version         : 0.1
### Date            : 2020-05-07
### Description     : add extracted links to aria2 deamon dowloading queue
### Depends On      : bash  grep  gawk  coreutils  ncurses  w3m  diana (https://github.com/baskerville/diana)
### Video Demo      : https://youtu.be/dTpEuQZRRDM
### Source          : https://gist.github.com/fxsjy/5465353
### References      : http://mannned.org/wget

Color_Off='\e[0m'       # Text Reset
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Blue='\e[0;34m'         # Blue


# config requirements:
#   ~/.w3m/kepmap
## bookmark current page
#     keymap  XA      COMMAND       "EXTERN '(echo -n %s | xsel -b)' ; SHELL ~/.w3m/cgi-bin/save_bookmark.cgi"
## bookmark current cursor link
#     keymap  xa      COMMAND       "EXTERN_LINK '(echo -n %s | xsel -b)' ; SHELL ~/.w3m/cgi-bin/save_bookmark.cgi"

# get url from w3m envoriment variables (e.g !env | less)
# URL="$(xsel -b)"
URL="$W3M_URL"

clear

TEMPFILE=/tmp/queue2aria.txt
# show current url and display save location
echo -e "${Blue}>>> URL: $URL ${Color_Off}"

# ask user for bookmark name
echo -e "${Green}----------------------------------------------------------${Color_Off}"
echo -e "${Green}>>> 1) Enter Extension(s) To Filter ${Red}e.g .mp3$ or .mp3$|.png$|mp4$ ${Color_Off}"
read -rp "EXT: " EXT
EXT=$(echo "$EXT" | awk '{print $1}')
echo

w3m -dump "$W3M_URL" | grep -E "$EXT" | cut -d']' -f2- | awk '{$1=$1};1' > "$TEMPFILE"
cat "$TEMPFILE" 
echo

# y = continue ; e = edit via text editor
echo -ne "${Red}>>>Add These Links To Download Queue? or Edit List? [y/n/e] ${Color_Off}"
  read -r REPLY
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    while read -r line ; do diana add "$line" ; done < "$TEMPFILE"
  elif [[ $REPLY =~ ^[Ee]$ ]]
  then
    $EDITOR "$TEMPFILE"
    while read -r line ; do diana add "$line" ; done < "$TEMPFILE"
  else
    clear
    exit
  fi

# add links to queue via diana
# while read -r line ; do diana add "$line" ; done < "$TEMPFILE"

clear
