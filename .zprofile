#!/usr/bin/env zsh

# Modify the PATH Variable
export USERPATHS="$HOME/.cargo/bin:$HOME/.local/bin"
export PATH="${PATH}:${USERPATHS}"

# Start an X Session when logging in via
# /dev/tty1
[ -z "$DISPLAY" ] && [ $XDG_VTNR -eq 1 ] && startx
