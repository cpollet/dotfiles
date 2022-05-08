#!/bin/bash
SELF=`realpath "$0"`
DIR=`dirname "$SELF"`

echo "Install tmux ..."
if xset q &>/dev/null; then
	command -v xclip 2>&1 >/dev/null
	if [[ $? -ne 0 ]]; then
		sudo apt-get install xclip
	fi
fi

command -v terminator 2>&1 >/dev/null
if [[ $? -eq 0 ]]; then
	echo "Install terminator ..."
	mkdir -p ~/.config/terminator
	[[ ! -f ~/.config/terminator/config ]] && \
		ln -s ~/.dotfiles.git/files/terminator/config ~/.config/terminator/config
fi


echo "Install intallij-darcula's  like theme ..."
command -v gnome-terminal 2>&1 >/dev/null
if [[ $? -eq 0 ]]; then
	echo "  gnome-terminal ..."
	echo -n "  Profile name (you may want to create a new one...)? "; read profile
	if [[ "$profile" != "" ]]; then
		$DIR/.gnome-terminal-theme.sh jetbrains-darcula $profile
	fi
fi

if [[ `grep "~/.dir_colors/dircolors" ~/.zshrc | wc -l` = "0" ]]; then
	echo "  dircolors..."
	mkdir -p ~/.dir_colors
	ln -s ~/.dotfiles/files/zsh/dircolors ~/.dir_colors/dircolors
	echo '[ -f ~/.dir_colors/dircolors ] && eval `dircolors ~/.dir_colors/dircolors`' >> ~/.zshrc
fi

command -v gnome-tweaks 2>&1 >/dev/null
if [[ $? -eq 0 ]]; then
	echo "Remap Caps Lock to CTRL. Hit enter when done."
	gnome-tweaks &
	read
fi
