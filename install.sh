#!/bin/bash
SELF=`realpath "$0"`
DIR=`dirname "$SELF"`

command -v terminator 2>&1 >/dev/null
if [[ $? -eq 0 ]]; then
	echo "Install terminator ..."
	mkdir -p ~/.config/terminator
	[[ ! -f ~/.config/terminator/config ]] && \
		ln -s ~/.dotfiles.git/files/terminator/config ~/.config/terminator/config
fi
