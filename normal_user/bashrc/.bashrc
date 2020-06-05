#             _   _     _      _           _               _
#  __ _  ___ | |_| |__ | | ___| |_ _   _  | |__   __ _ ___| |__
# / _` |/ _ \| __| '_ \| |/ _ \ __| | | | | '_ \ / _` / __| '_ \
#| (_| | (_) | |_| |_) | |  __/ |_| |_| | | |_) | (_| \__ \ | | |
# \__, |\___/ \__|_.__/|_|\___|\__|\__,_| |_.__/ \__,_|___/_| |_|
# |___/
#
#       DESC: BASH Configuration
#
#       http://www.youtube.com/user/gotbletu
#       https://twitter.com/gotbletu
#       https://plus.google.com/+gotbletu
#       https://github.com/gotbletu
#       gotbletu@gmail.com




#prompt with lines
# http://www.reddit.com/r/linux/comments/12wxsl/whats_in_your_bashrc/
# export PROMPT_COMMAND='q="- $(date +%T)"; while [[ ${#q} -lt $COLUMNS ]]; do q="${q:0:1}$q"; done; echo -e "\033[0;90m$q";'

# http://pastebin.com/bcsvkKVF
# PS1='\n \[\e[1;37m\]$(echo -e "\033(0lq\033(B")[\[\e[0m\] \[\e[1;36m\]\u \D{%F %a %T %p} \w\[\e[0m\]\n \[\e[1;37m\]$(echo -e "\033(0mq\033(B")[ --->\[\e[0m\] \[\e[1;32m\]'

# PS1='\e[${PROMPT_COLOR}\e[${PROMPT_COLOR2}\u@${PROMPT_HOSTNAME}\e[${PROMPT_COLOR}\[\e[1;30m\] - \[\e[34;1m\]\t\[\e[30;1m\] - \[\e[37;1m\]\w\[\e[30;1m\]\[\e[1;30m\] \nhist:\! \[\e[0;33m\] \[\e[1;31m\]$\[\e[1;32m\] '
#-------- Color Bash Prompt {{{
#------------------------------------------------------

# Bash Prompts 2012
#PS1="\[$BBlue\]\u \t \[$BWhite\]\w \n\[$BRed\]$\[$BGreen\] "

#  \n \[\e[1;37m\]+-[\[\e[1;36m\] \d \[\e[1;31m\]\T \[\e[1;37m\]] \n\[\e[1;37m\] +-[ \[\e[1;34m\]@ \[\e[1;32m\]\w \[\e[1;37m\]]\[\e[1;35m\]---> \[\e[0;37m\]


# Newest, use man strftime - Tron
#PS1="\n \[$BWhite\]+-[ \[$BCyan\]\u \D{%F %a %r} \w \n \[$BWhite\]+-[ ---> \[$BGreen\]"
#}}}

# PS1="\[\e[30;1m\](\[\e[34;1m\]\u@\h\[\e[30;1m\])-(\[\e[34;1m\]\t\[\e[30;1m\])-(\[\e[32;1m\]\w\[\e[30;1m\])\[\e[30;1m\]\nhist:\! \[\e[0;33m\] \[\e[1;31m\](jobs:\[\e[34;1m\]\j\[\e[30;1m\])\`if [ \$? -eq 0 ]; then echo \[\e[32m\] \:\-\); else echo \[\e[31m\] \:\-\( ; fi\`\[\e[0m\] $ "

# https://www.reddit.com/r/unixporn/comments/29k0iv/how_to_get_this_on_my_xterm/
export PS1="┌──\u@\h[\w]\n└─╼ "



# prompt () {
#     [[ $# = 1 ]] || exit 255
#     mode="$1"
#
#     case "$mode" in
#     none)
#         export PS1=""
#         ;;
#     off)
#         export PS1="$ "
#         ;;
#     date)
#         export PS1="[\t]\$ "
#         ;;
#     basic)
#         export PS1="\u:\w$ "
#         ;;
#     full)
#         export PS1="[\t]\u:\w$ "
#         ;;
#     esac
# }
#
#prompt basic


fh() {
eval $(history | fzf +s | sed 's/ *[0-9]* *//')
}

bind '"\C-F":"fh\n"'	# fzf history


#-------- BASH External Loading {{{
#------------------------------------------------------
# autocompletion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# alias
# if [ -f ~/.aliasrc/aliasrc ]; then
#     . ~/.aliasrc/aliasrc
# fi


# load alias/functions that works with both zsh/bash
if [[ -d ~/.aliasrc ]]; then
    myArray=($(ls ~/.aliasrc))
    for arg in "${myArray[@]}"; do
      source ~/.aliasrc/"$arg"
    done
fi

# adds autoomplete to commands that dont work
if [ "$PS1" ]; then
	complete -cf sudo man
fi
#}}}
#-------- BASH Exports {{{
#------------------------------------------------------
# http://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
shopt -s histappend	# append history not overwrite it
shopt -s checkwinsize	# check window on resize; for word wrapping
shopt -s autocd		# instead of 'cd Pictures', just run Pictures
shopt -s cdspell	# auto correct cd; cd /sur/src/linus' >> 'cd /usr/src/linux'
shopt -s cmdhist	# If set, Bash attempts to save all lines of a multiple-line command in the same history entry. This allows easy re-editing of multi-line commands.

HISTCONTROL=erasedups:ignoreboth
HISTSIZE=1000000
HISTFILESIZE=1000000
HISTIGNORE="&:ls:[bf]g:history:exit"  #ignore these commands from history

# setopt autocd
# appendhistory all your open shells share the same history which is handy if you want to refer commands from one shell in another with say Ctrl+R(reverse-history-search)
# extendedglob
# http://batsov.com/articles/2011/04/29/one-shell-to-rule-them-all/

#}}}
#-------- Keybinding {{{
#------------------------------------------------------
# movement and autocompeletion at the prompt
bind 'set completion-ignore-case on'	# case insensitive on tab completion
bind '"\t":menu-complete' 		# Tab: Cycle thru completion
bind '"\e[1;3D":backward-kill-word' 	# Alt + arrowleft : delete word backward
bind '"\e\e[D":backward-kill-word' 	# Alt + arrowleft : delete word backward
bind '"\e[1;3A":kill-whole-line' 	# Alt + arrowup : delete whole line
bind '"\e[1;3B":undo'			# Alt + arrowdown : undo
bind '"\e[1;5C":forward-word'		# Ctrl + arrowright : Jump a word forward
bind '"\e[1;5D":backward-word'		# Ctrl + arrowleft : Jump a word backward
bind '"\e[Z":menu-complete-backward'	# Shift+Tab: Cycle backwards
bind '"\e[A": history-search-backward'	# ArrowUp: history completion backwards
bind '"\e[B": history-search-forward'	# ArrowDown: history completion forward

# enable history verification:
# bang commands (!, !!, !?) will print to shell and not be auto executed
# http://superuser.com/a/7416
shopt -s histverify

# Bang! Previous Command Hotkeys
# print previous command but only the first nth arguments
# Alt+1, Alt+2 ...etc
# http://www.softpanorama.org/Scripting/Shellorama/bash_command_history_reuse.shtml#Bang_commands
bind '"\e1": "!:0 \n"'
bind '"\e2": "!:0-1 \n"'
bind '"\e3": "!:0-2 \n"'
bind '"\e4": "!:0-3 \n"'
bind '"\e5": "!:0-4 \n"'
bind '"\e`": "!:0- \n"'     # all but the last word

##


# bind '"\C-O":"fzf-dmenu\n"'

## }}}


# autocomplete surfraw bookmarks
# usage: srb <bookmark_name>
# _cmpl_surfraw() {
# 	reply=($(awk 'NF != 0 && !/^#/ {print $1}' ~/.config/surfraw/bookmarks | sort -n))
# }
# compctl -K _cmpl_surfraw srb
#

# http://fahdshariff.blogspot.com/2011/04/writing-your-own-bash-completion.html
# http://askubuntu.com/a/345150
# https://www.debian-administration.org/article/317/An_introduction_to_bash_completion_part_2
_cmpl_surfraw() {
	# reply=($(awk 'NF != 0 && !/^#/ {print $1}' ~/.config/surfraw/bookmarks | sort -n))
    local cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=($(awk 'NF != 0 && !/^#/ {print $1}' ~/.config/surfraw/bookmarks | sort -n))
	# COMPREPLY=($(awk 'NF != 0 && !/^#/ {print $1}' ~/.config/surfraw/bookmarks | sort -n))
    # local cur=${COMP_WORDS[COMP_CWORD]}
    # COMPREPLY=( $(compgen -W "fooOption barOption" -- $cur) )
}
complete -F _cmpl_surfraw srb
alias srb='surfraw -browser=$BROWSERCLI'          # use for surfraw bookmarks (CLI)
alias srg='surfraw -browser=$BROWSER'             # use for surfraw bookmarks (GUI)



