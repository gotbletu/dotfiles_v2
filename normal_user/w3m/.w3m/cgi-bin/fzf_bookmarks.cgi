#!/usr/bin/env sh
printf '%s' "$(grep '^[[:alnum:]]' ~/.config/surfraw/bookmarks | sort -n | sed 's/%/%%/g' | fzf -e -i )" | awk '{print $2}' | xsel -p
