#!/usr/bin/env sh
if [ "$W3M_SETTING_MODE" = "xsession" ]; then
  # open settings options
  xdotool type "$W3M_HOTKEY_OPTIONS"
  # jump to inline image options
  xdotool type "45$W3M_HOTKEY_LINK_BEGIN"
  xdotool key Return
  # save changes
  xdotool type "67$W3M_HOTKEY_LINK_BEGIN"
  xdotool key Return
  # refresh page
  xdotool type "$W3M_HOTKEY_RELOAD"
elif [ "$W3M_SETTING_MODE" = "tmux" ]; then
  # open settings options
  tmux send-keys "$W3M_HOTKEY_OPTIONS"
  # jump to inline image options
  tmux send-keys "45$W3M_HOTKEY_LINK_BEGIN" 'Enter'
  # save changes
  tmux send-keys "67$W3M_HOTKEY_LINK_BEGIN" 'Enter'
  # refresh page
  tmux send-keys "$W3M_HOTKEY_RELOAD"
fi
