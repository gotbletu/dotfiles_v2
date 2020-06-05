#!/bin/bash
# Bash Colors index
# http://madebynathan.com/2011/08/15/bash-color-index
# Show an index of all available bash colors
color_index() {
echo -e "\n              Usage: \\\e[*;**m or \\\033[*;**m or \\\033[*;**(;**)m"
echo -e   "            Default: \\\e[0m or \\\033[0m"
echo -e "          Example: echo -e '\\\e[1;33mHelloWorld'"
local blank_line="\033[0m\n     \033[0;30;40m$(printf "%41s")\033[0m"
echo -e "$blank_line" # Top border
for STYLE in 2 0 1 4 9; do
  echo -en "     \033[0;30;40m "
  # Display black fg on white bg
  echo -en "\033[${STYLE};30;47m${STYLE};30\033[0;30;40m "
  for FG in $(seq 31 37); do
      CTRL="\033[${STYLE};${FG};40m"
      echo -en "${CTRL}"
      echo -en "${STYLE};${FG}\033[0;30;40m "
  done
  echo -e "$blank_line" # Separators
done
echo -en "     \033[0;30;40m "
# Background colors
echo -en "\033[0;37;40m*;40\033[0;30;40m \033[0m" # Display white fg on black bg
for BG in $(seq 41 47); do
    CTRL="\033[0;30;${BG}m"
    echo -en "${CTRL}"
    echo -en "*;${BG}\033[0;30;40m "
done
echo -e "$blank_line" "\n" # Bottom border
}
color_index
