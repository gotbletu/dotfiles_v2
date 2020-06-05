#              _   _     _      _                   _
#   __ _  ___ | |_| |__ | | ___| |_ _   _   _______| |__
#  / _` |/ _ \| __| '_ \| |/ _ \ __| | | | |_  / __| '_ \
# | (_| | (_) | |_| |_) | |  __/ |_| |_| |  / /\__ \ | | |
#  \__, |\___/ \__|_.__/|_|\___|\__|\__,_| /___|___/_| |_|
#  |___/
#
#       DESC: ZSH Configurations
#
#       http://www.youtube.com/user/gotbletu
#       https://twitter.com/gotbletu
#       https://plus.google.com/+gotbletu
#       https://github.com/gotbletu
#       gotbletu@gmail.com

# http://stackoverflow.com/questions/171563/whats-in-your-zshrc


#-------- ZSH Modules {{{
#------------------------------------------------------

# autoload -U zcalc zsh-mime-setup
# zsh-mime-setup

# }}}
#-------- Prompt {{{
#------------------------------------------------------
# https://wiki.archlinux.org/index.php/Zsh#Prompts

autoload -U promptinit && promptinit
prompt fade magenta   # set prompt theme (for listing: $ prompt -p)

# }}}
#-------- History {{{
#------------------------------------------------------
# get more info: $man zshoptions

setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_VERIFY
setopt SHARE_HISTORY
setopt INTERACTIVE_COMMENTS        # pound sign in interactive prompt
HISTFILE=~/.zsh_history            # where to save zsh history
HISTSIZE=10000
SAVEHIST=10000
cfg-history() { $EDITOR $HISTFILE ;}

#
# }}}
#-------- Globbing {{{
#------------------------------------------------------

setopt extendedglob
unsetopt caseglob

# }}}
#-------- Vim Mode {{{
#------------------------------------------------------
# enable vim mode on commmand line
bindkey -v

# edit command with editor
# http://stackoverflow.com/a/903973
# usage: type someshit then hit Esc+v
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# no delay entering normal mode
# https://github.com/pda/dotzsh/blob/master/keyboard.zsh#L10
# 10ms for key sequences
KEYTIMEOUT=1

# show vim status
# http://zshwiki.org/home/examples/zlewidgets
function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
    RPS2=$RPS1
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# add missing vim hotkeys
# fixes backspace deletion issues
# http://zshwiki.org/home/zle/vi-mode
bindkey -a u undo
# bindkey -a '^R' redo	# conflicts with history search hotkey
bindkey -a '^T' redo
bindkey '^?' backward-delete-char	#backspace

# history search in vim mode
# http://zshwiki.org./home/zle/bindkeys#why_isn_t_control-r_working_anymore
bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward

# use cursor blinker color as indicator of vi mode
# http://andreasbwagner.tumblr.com/post/804629866/zsh-cursor-color-vi-mode
# http://reza.jelveh.me/2011/09/18/zsh-tmux-vi-mode-cursor

# bug; 112 ascii randomly showing up

# zle-keymap-select () {
#  if [ $KEYMAP = vicmd ]; then
#    if [[ $TMUX = '' ]]; then
#      echo -ne "\033]12;Red\007"
#    else
#      printf '\033Ptmux;\033\033]12;red\007\033\\'
#    fi
#  else
#    if [[ $TMUX = '' ]]; then
#      echo -ne "\033]12;Grey\007"
#    else
#      printf '\033Ptmux;\033\033]12;grey\007\033\\'
#    fi
#  fi
#}
#zle-line-init () {
#  zle -K viins
#  echo -ne "\033]12;Grey\007"
#}
#zle -N zle-keymap-select
#zle -N zle-line-init

# }}}
#-------- Autocomplete {{{
#------------------------------------------------------
# http://www.refining-linux.org/archives/40/ZSH-Gem-5-Menu-selection/
# https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/completion.zsh


autoload -U compinit && compinit        # enable autocompletion
fpath+=(~/.zsh/completion)              # set path to custom autocompletion
zstyle ':completion:*' menu select      # to activate the menu, press tab twice

# do not autoselect the first completion entry
unsetopt menu_complete

# autocompletion CLI switches for aliases
setopt completealiases

zstyle ':completion:*' list-colors ''   # show colors on menu completion

# http://unix.stackexchange.com/a/297000
# tab completion from both ends
setopt complete_in_word
setopt glob_complete                    # wildcard completion eg. *-tar

# setopt auto_menu         # show completion menu on succesive tab press
# setopt always_to_end

# show dots if tab compeletion is taking long to load
expand-or-complete-with-dots() {
  echo -n "\e[31m......\e[0m"
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots

# autocomplete case-insensitive (all),partial-word and then substring
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# better completion for killall
zstyle ':completion:*:killall:*' command 'ps -u $USER -o cmd'

# when new programs is installed, auto update autocomplete without reloading shell
zstyle ':completion:*' rehash true

#}}}
#-------- Suffix Alias {{{
#------------------------------------------------------
# open file with default program base on extension
# Ex: 'alias -s avi=mplayer' makes 'file.avi' execute 'mplayer file.avi'
background() { nohup "$@" >/dev/null 2>&1& }   # background a process w/o error msg filling screen

alias -s {avi,flv,mkv,mp4,mpeg,mpg,ogv,wmv}=$PLAYER
alias -s {flac,mp3,ogg,wav}=$MUSICER
alias -s {gif,GIF,jpeg,JPEG,jpg,JPG,png,PNG}="background $IMAGEVIEWER"
alias -s {djvu,pdf,ps}="background $READER"
alias -s txt=$EDITOR
alias -s epub="background $EBOOKER"
alias -s {cbr,cbz}="background $COMICER"
# might conflict with emacs org mode
alias -s {at,ch,com,de,net,org}="background $BROWSER"

# archive extractor
alias -s ace="unace l"
alias -s rar="unrar l"
alias -s {tar,bz2,gz,xz}="tar tvf"	#tar.bz2,tar.gz,tar.xz
alias -s zip="unzip -l"

#}}}
#-------- Expanding Alias {{{
#------------------------------------------------------
# Expanding aliases in zsh
# source: http://wiki.math.cmu.edu/iki/wiki/tips/20140625-zsh-expand-alias.html
# typeset -a ealiases
# ealiases=()
# ealias() {
#   alias $1
#   ealiases+=(${1%%\=*})
# }
# expand-ealias() {
#   if [[ $LBUFFER =~ "(^|[;|&])\s*(${(j:|:)ealiases})\$" ]]; then
#     zle _expand_alias
#     zle expand-word
#   fi
#   zle magic-space
# }
# zle -N expand-ealias
# # bindkey -M viins ' '  expand-ealias   # space to expand
# bindkey -M viins '^[[Z' expand-ealias   # shift-tab to expand
# bindkey -M viins '^ '   magic-space     # control-space to bypass completion
# bindkey -M isearch " "  magic-space     # normal space during searches
#
# # Expandable Alias
# ealias TSP='TS_SOCKET=/tmp/ranger tsp'




# }}}
#-------- Global Alias {{{
#------------------------------------------------------
# Automatically Expanding Global Aliases (Space key to expand)
# references: http://blog.patshead.com/2012/11/automatically-expaning-zsh-global-aliases---simplified.html
globalias() {
  if [[ $LBUFFER =~ '[A-Z0-9]+$' ]]; then
    zle _expand_alias
    zle expand-word
  fi
  zle self-insert
}
zle -N globalias
bindkey " " globalias                 # space key to expand globalalias
# bindkey "^ " magic-space            # control-space to bypass completion
bindkey "^[[Z" magic-space            # shift-tab to bypass completion
bindkey -M isearch " " magic-space    # normal space during searches


alias -g CBD='$cbdojinshi '
alias -g CBC='$cbcomic '
alias -g TSP='TS_SOCKET=/tmp/ranger tsp'
alias -g DBZ="&& mpv volume=100 ~/.soundeffects/dbz_closing_theme.wav"
alias -g MGS="&& mpv volume=100 ~/.soundeffects/metalgear_alert.ogg"
alias -g BELL='&& sleep 2 && echo -e "\a"'


# http://www.zzapper.co.uk/zshtips.html
alias -g ND='*(/om[1])' 	      # newest directory
alias -g NF='*(.om[1])' 	      # newest file
# alias -g V='| vim -R -'
alias -g V='| vless'
alias -g L='| less -N'
alias -g W='| w3m'
alias -g G='| grep -i '
alias -g AWK="| awk -F';' '/cheat/ {print $1}'"
alias -g CUT="| cut -d' ' -f2-"
alias -g WC='| wc -l'
alias -g TP='&& tmux kill-pane'
alias -g WR='| while read line ; do echo "$line" ; done'
alias -g WRA='| while read line ; do aria2c "$line" ; done'
alias -g WRW='| while read line ; do aria2c "$line" ; done'



#alias -g NE='2>|/dev/null'
alias -g NO='&>|/dev/null'
alias -g PP='2>&1 | $PAGER'
alias -g HH='| head'
alias -g TT='| tail'
alias -g LL="2>&1 | less"
alias -g CA="2>&1 | cat -A"
alias -g NE="2> /dev/null"
alias -g NUL="> /dev/null 2>&1"
# some global aliases for redirection
alias -g NN="&>/dev/null"
alias -g 1N="1>/dev/null"
alias -g 2N="2>/dev/null"
alias -g DN="/dev/null"
alias -g PI="|"
# Paging with less / head / tail
alias -g LS='| less -S'
alias -g EL='|& less'
alias -g ELS='|& less -S'
alias -g TRIM='| cut -c 1-$COLUMNS'
alias -g HL='| head -n $(( +LINES ? LINES - 4 : 20 ))'
alias -g EH='|& head'
alias -g EHL='|& head -n $(( +LINES ? LINES - 4 : 20 ))'
alias -g TL='| tail -n $(( +LINES ? LINES - 4 : 20 ))'
alias -g ET='|& tail'
alias -g ETL='|& tail -n $(( +LINES ? LINES - 4 : 20 ))'
# Sorting / counting
alias -g CC='| wc -l'
alias -g SS='| sort'
alias -g Su='| sort -u'
alias -g Sn='| sort -n'
alias -g Snr='| sort -nr'

#}}}
#-------- External Files {{{
#------------------------------------------------------

# load alias/functions that works with both zsh/bash
if [[ -d ~/.aliasrc ]]; then
    myArray=($(ls ~/.aliasrc))
    for arg in "${myArray[@]}"; do
      source ~/.aliasrc/"$arg"
    done
fi


#}}}

#-------- Keybinding {{{
#------------------------------------------------------
# manpages for keybindings: $man zshzle

# partial history search using up and down arrow keys
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# Bang! Previous Command Hotkeys
# print previous command but only the first nth arguments
# Alt+1, Alt+2 ...etc
# http://www.softpanorama.org/Scripting/Shellorama/bash_command_history_reuse.shtml#Bang_commands
bindkey -s '\e1' "!:0 \t"        # last command
bindkey -s '\e2' "!:0-1 \t"      # last command + 1st argument
bindkey -s '\e3' "!:0-2 \t"      # last command + 1st-2nd argument
bindkey -s '\e4' "!:0-3 \t"      # last command + 1st-3rd argument
bindkey -s '\e5' "!:0-4 \t"      # last command + 1st-4th argument
bindkey -s '\e`' "!:0- \t"       # all but the last argument
bindkey -s '\e9' "!:0 !:2* \t"   # all but the 1st argument (aka 2nd word)


# history search fzf
# references: https://github.com/junegunn/fzf/wiki/examples#command-history
# fzf-history-zsh() { print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac --height 10% | sed 's/ *[0-9]* *//') ;}
# bindkey -s '^R' "fzf-history-zsh\n"


# history search fzf widget
# references: https://github.com/junegunn/fzf/wiki/examples#locate
fzf-history-widget() {
  local selected
  if selected=$( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf -q "$LBUFFER" +s -e -i --tac --height 10% | sed 's/ *[0-9]* *//' ); then
    LBUFFER=$selected
  fi
  zle redisplay
}
zle     -N   fzf-history-widget
bindkey '^R' fzf-history-widget


#}}}
#-------- ZMV {{{
#------------------------------------------------------
# http://onethingwell.org/post/24608988305/zmv
autoload zmv

# }}}

#-------- Fuzzy Finder {{{
#------------------------------------------------------
#

# function bind to a hotkey
fzf_history() { zle -I; eval $(history | fzf +s | sed 's/ *[0-9]* *//') ; }; zle -N fzf_history; bindkey '^F' fzf_history

fzf_killps() { zle -I; ps -ef | sed 1d | fzf -m | awk '{print $2}' | xargs kill -${1:-9} ; }; zle -N fzf_killps; bindkey '^Q' fzf_killps

fzf_cd() { zle -I; DIR=$(find ${1:-*} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf) && cd "$DIR" ; }; zle -N fzf_cd; bindkey '^E' fzf_cd
# }}}
#-------- Emacs Mode {{{
#------------------------------------------------------
# enable emacs mode on commmand line
# bindkey -e

# use text editor to edit commands
# autoload -U edit-command-line
# zle -N edit-command-line
# bindkey '\C-x\C-e' edit-command-line

# }}}
#-------- Empty {{{
#------------------------------------------------------
#


# }}}
#-------- Empty {{{
#------------------------------------------------------
#


# }}}

#-------- Autocomplete Custom {{{
#------------------------------------------------------
# autocomplete surfraw bookmarks
# usage: srb <bookmark_name>
_cmpl_surfraw() { reply=($(awk 'NF != 0 && !/^#/ {print $1}' ~/.config/surfraw/bookmarks | grep -v '^-' | grep -v '^}' | grep -v '^/' | sort -n)) ;}
compctl -K _cmpl_surfraw srb srg
alias srb='surfraw -browser=$BROWSERCLI'          # use for surfraw bookmarks (CLI)
alias srg='surfraw -browser=$BROWSER'             # use for surfraw bookmarks (GUI)


_cmpl_redpill() {
    reply=($(ls -1 ~/.config/redpill))
}
compctl -K _cmpl_redpill redpill

# bleachbitcli
_cmpl_bleachbit() {
	reply=($(bleachbit -l | cut -d' ' -f1))
}
compctl -K _cmpl_bleachbit bleachbit

# playonlinux
_cmpl_playonlinux() {
	myarray=($(ls ~/.PlayOnLinux/shortcuts | sed 's:\ :\\\ :g'))
	reply=(printf "%s\n" ${myarray[@]})
	# reply=(${myarray[@]})
}
compctl -K _cmpl_playonlinux playonlinux


# fzf_surfraw() { zle -I; surfraw $(cat ~/.config/surfraw/bookmarks | fzf | awk 'NF != 0 && !/^#/ {print $1}' ) ; }; zle -N fzf_surfraw; bindkey '^W' fzf_surfraw

# add sudo in front of current command
# https://www.reddit.com/r/zsh/comments/4b2lyj/send_a_simulated_keypress_from_zle_script_to/
sudo_ (){
    BUFFER="sudo $BUFFER"
    CURSOR=$#BUFFER
}
zle -N sudo_
bindkey "^f" sudo_


# }}}
#--------------------------------------------------------------------------
#http://jaredforsyth.com/blog/2010/may/30/easy-zsh-auto-completion/
## http://zshwiki.org/home/examples/compctl

# ZSH completions# {{{
# compdef _pids cpulimit
# setopt completealiases

# calibredb
# _cmpl_calibredb() {
# alias -g search="list -s"
#
#     reply=(add remove search)
# }
# compctl -K _cmpl_calibredb cmx-comic cmx-dojinshi cmx-eurotica cmx-hanime cmx-normal cmx-textbook $@

# fzf_playonlinux_run() { zle -I; playonlinux --run $(ls -1 ~/.PlayOnLinux/shortcuts | fzf) ; }; zle -N fzf_playonlinux_run; bindkey '^P' fzf_playonlinux_run

# fzf_hotkey_playonlinux() { zle -I; @dmenu ; }; zle -N fzf_hotkey_playonlinux; bindkey '^ ' fzf_hotkey_playonlinux

# fzf_surfraw() { zle -I; surfraw $(awk 'NF > 0' ~/.config/surfraw/bookmarks | fzf | awk 'NF != 0 && !/^#/ {print $1}' ) ; }; zle -N fzf_surfraw; bindkey '^W' fzf_surfraw

	# reply=($(awk 'NF != 0 && !/^#/ {print $1}' ~/.config/surfraw/bookmarks | sort -n))
# }}}

# hp: you define a function, you make a widget out of it with zle -N funcname, then you  bind that
# slmenukey() { zle -I; xe ; }; zle -N slmenukey; bindkey '^F' slmenukey
#hw() { zle -I; echo hello world; }; zle -N hw; bindkey '^[[4~' hw
#bindkey -s '^[[4~' 'echo hello\n'


# bindkey -s '^O' "fzf-dmenu\n"

bindkey -s '^O' "fzf-dmenu\n"



# disable zsh autocorrect
# https://coderwall.com/p/jaoypq
# unsetopt correct_all

# ----------------------------

# Autoload screen if we aren't in it.  (Thanks Fjord!)
# if [[ $STY = '' ]] then screen -xR; fi


# #-------- Options {{{
# #------------------------------------------------------
# # http://linux.die.net/man/1/zshoptions
#
# # Options
# # http://stackoverflow.com/a/171564
setopt AUTO_CD           # instead of 'cd folder' if you could just type 'folder'
# setopt MULTIOS           # now we can pipe to multiple outputs!
# setopt CORRECT           # spell check commands!  (Sometimes annoying)
setopt AUTO_PUSHD        # This makes cd=pushd
# setopt AUTO_NAME_DIRS    # This will use named dirs when possible
#
# # If we have a glob this will expand it
# setopt GLOB_COMPLETE
# setopt PUSHD_MINUS
#
# # No more annoying pushd messages...
# # setopt PUSHD_SILENT
#
# # blank pushd goes to home
# setopt PUSHD_TO_HOME
#
# # this will ignore multiple directories for the stack.  Useful?  I dunno.
# setopt PUSHD_IGNORE_DUPS
#
# # 10 second wait if you do something that will delete everything.  I wish I'd had this before...
# setopt RM_STAR_WAIT
#
# # use magic (this is default, but it can't hurt!)
# setopt ZLE
#
# setopt NO_HUP
#
# setopt VI
#
# # only fools wouldn't do this ;-)
# export EDITOR="vi"
#
#
# setopt IGNORE_EOF
#
# # If I could disable Ctrl-s completely I would!
# setopt NO_FLOW_CONTROL
#
# # beeps are annoying
# setopt NO_BEEP
#
# # Keep echo "station" > station from clobbering station
# setopt NO_CLOBBER
#
# # Case insensitive globbing
# setopt NO_CASE_GLOB
#
# # Be Reasonable!
# setopt NUMERIC_GLOB_SORT
#
# # I don't know why I never set this before.
# setopt EXTENDED_GLOB
#
# # hows about arrays be awesome?  (that is, frew${cool}frew has frew surrounding all the variables, not just first and last
# setopt RC_EXPAND_PARAM
#
# #
#
# # }}}
#-------- Empty {{{
#------------------------------------------------------
#


# }}}
#-------- Empty {{{
#------------------------------------------------------
#


# }}}
#-------- Empty {{{
#------------------------------------------------------
#


# }}}
#-------- Empty {{{
#------------------------------------------------------
#


# }}}




# #{{{ Completion Stuff
#
# bindkey -M viins '\C-i' complete-word
#
# # Faster! (?)
# zstyle ':completion::complete:*' use-cache 1
#
# # case insensitive completion
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
#
# zstyle ':completion:*' verbose yes
# zstyle ':completion:*:descriptions' format '%B%d%b'
# zstyle ':completion:*:messages' format '%d'
# zstyle ':completion:*:warnings' format 'No matches for: %d'
# zstyle ':completion:*' group-name ''
# #zstyle ':completion:*' completer _oldlist _expand _force_rehash _complete
# zstyle ':completion:*' completer _expand _force_rehash _complete _approximate _ignored
#
# # generate descriptions with magic.
# zstyle ':completion:*' auto-description 'specify: %d'
#
# # Don't prompt for a huge list, page it!
# zstyle ':completion:*:default' list-prompt '%S%M matches%s'
#
# # Don't prompt for a huge list, menu it!
# zstyle ':completion:*:default' menu 'select=0'
#
# # Have the newer files last so I see them first
# zstyle ':completion:*' file-sort modification reverse
#
# # color code completion!!!!  Wohoo!
# zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=36=31"
#
# unsetopt LIST_AMBIGUOUS
# setopt  COMPLETE_IN_WORD
#
# # Separate man page sections.  Neat.
# zstyle ':completion:*:manuals' separate-sections true
#
# # Egomaniac!
# zstyle ':completion:*' list-separator 'fREW'
#
# # complete with a menu for xwindow ids
# zstyle ':completion:*:windows' menu on=0
# zstyle ':completion:*:expand:*' tag-order all-expansions
#
# # more errors allowed for large words and fewer for small words
# zstyle ':completion:*:approximate:*' max-errors 'reply=(  $((  ($#PREFIX+$#SUFFIX)/3  ))  )'
#
# # Errors format
# zstyle ':completion:*:corrections' format '%B%d (errors %e)%b'
#
# # Don't complete stuff already on the line
# zstyle ':completion::*:(rm|vi):*' ignore-line true
#
# # Don't complete directory we are already in (../here)
# zstyle ':completion:*' ignore-parents parent pwd
#
# zstyle ':completion::approximate*:*' prefix-needed false
#
# #}}}

# #{{{ Key bindings
#
# # Who doesn't want home and end to work?
# bindkey '\e[1~' beginning-of-line
# bindkey '\e[4~' end-of-line
#
# # Incremental search is elite!
# bindkey -M vicmd "/" history-incremental-search-backward
# bindkey -M vicmd "?" history-incremental-search-forward
#
# # Search based on what you typed in already
# bindkey -M vicmd "//" history-beginning-search-backward
# bindkey -M vicmd "??" history-beginning-search-forward
#
# bindkey "\eOP" run-help
#
# # oh wow!  This is killer...  try it!
# bindkey -M vicmd "q" push-line
#
# # Ensure that arrow keys work as they should
# bindkey '\e[A' up-line-or-history
# bindkey '\e[B' down-line-or-history
#
# bindkey '\eOA' up-line-or-history
# bindkey '\eOB' down-line-or-history
#
# bindkey '\e[C' forward-char
# bindkey '\e[D' backward-char
#
# bindkey '\eOC' forward-char
# bindkey '\eOD' backward-char
#
# bindkey -M viins 'jj' vi-cmd-mode
# bindkey -M vicmd 'u' undo
#
# # Rebind the insert key.  I really can't stand what it currently does.
# bindkey '\e[2~' overwrite-mode
#
# # Rebind the delete key. Again, useless.
# bindkey '\e[3~' delete-char
#
# bindkey -M vicmd '!' edit-command-output
#
# # it's like, space AND completion.  Gnarlbot.
# bindkey -M viins ' ' magic-space
#
# #}}}

# copy current command to clipboard (Ctrl+X)
# https://www.reddit.com/r/commandline/comments/4fjpb0/question_how_to_copy_the_command_to_clipboard/
zle -N copyx; copyx() { echo -E $BUFFER | xsel -ib }; bindkey '^X' copyx





# # ALT-I - Paste the selected entry from locate output into the command line
# fzf-locate-widget() {
#   local selected
#   if selected=$(fasd -d | fzf -q "$LBUFFER"); then
#     LBUFFER=$selected
#   fi
#   zle redisplay
# }
# zle     -N    fzf-locate-widget
# bindkey '\ei' fzf-locate-widget


vvv() {
  local file
  file="$(fasd -Rfl "$1" | fzf -1 -0 --no-sort +m)" && vi "${file}" || return 1
}

