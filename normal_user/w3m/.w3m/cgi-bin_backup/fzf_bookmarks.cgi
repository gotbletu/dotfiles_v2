#!/usr/bin/env bash
clear
printf "$(grep '^[[:alnum:]]' ~/.config/surfraw/bookmarks | sort -n | sed 's/%/%%/g' | fzf -e -i )" | awk '{print $2}' | xsel -p

# pidof tmux >/dev/null && tmux set-buffer $(surfraw -browser=echo $PREFIX $INPUT)


