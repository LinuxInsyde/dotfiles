#!/usr/bin/env zsh

export ZSH="$HOME/.oh-my-zsh"
export PLUGDIR="/usr/share/zsh/plugins"
export SHELLDIR="$HOME/.config/shell"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#999"

# Load Oh-My-ZSH
source $ZSH/oh-my-zsh.sh

# Source variables and aliases from a different file
source $SHELLDIR/varsrc
source $SHELLDIR/aliasrc
source $SHELLDIR/functions

# Source plugins
source $PLUGDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $PLUGDIR/zsh-autosuggestions/zsh-autosuggestions.zsh

installMissing
eval "$(starship init zsh)"
