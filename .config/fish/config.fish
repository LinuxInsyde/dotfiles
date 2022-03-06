#!/usr/bin/fish
# -*- shell-script -*-

if status is-interactive
   # Interactive Mode commands go here
end

set EDITOR nvim
set BROWSER firefox
set TERM xterm-256color
set fish_greeting
set USERPATHS $HOME/.local/bin $HOME/.cargo/bin

set -e fish_user_paths
set -U fish_user_paths $USERPATHS $fish_user_paths

set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

abbr nv "(which nvim)"
abbr ls "ls --color=auto --group-directories-first"
abbr la "ls -ah"
abbr l "ls -lah"

abbr cat "bat"
abbr ef "(which nvim) $HOME/.config/fish/config.fish"

starship init fish | source
