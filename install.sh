#!/bin/bash
SELF=`realpath "$0"`
DIR=`dirname "$SELF"`

[[ ! -d ~/.dotfiles.git ]] && \
	git clone https://github.com/cpollet/dotfiles.git ~/.dotfiles.git

echo "Install zsh ..."
command -v zsh 2>&1 >/dev/null
if [[ $? -ne 0 ]]; then
	echo "When in zsh, hit CTRL+D to continue."
	echo "Press enter to continue"
	read
fi

echo "Install oh-my-zsh ..."
if [[ ! -d ~/.oh-my-zsh ]]; then
	sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	mkdir -p ~/.oh-my-zsh/custom/themes
	ln -s ~/.dotfiles.git/files/zsh/cpollet.zsh-theme ~/.oh-my-zsh/custom/cpollet.zsh-theme
	sed -i 's/robbyrussell/cpollet/g' ~/.zshrc
fi

[[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ]] && \
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

sed -i 's/^plugins=.*$/plugins=(git zsh-syntax-highlighting)/g' ~/.zshrc

echo "Install tmux ..."
command -v xclip 2>&1 >/dev/null
if [[ $? -ne 0 ]]; then
	sudo apt-get install xclip
fi
mkdir -p ~/.tmux/plugins

[[ ! -d ~/.tmux/plugins/tpm ]] && \
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
[[ ! -f ~/.tmux.conf ]] && \
	ln -s ~/.dotfiles.git/files/tmux/tmux.conf ~/.tmux.conf
[[ ! -f ~/.tmux/reset.conf ]] && \
	ln -s ~/.dotfiles.git/files/tmux/reset.conf ~/.tmux/reset.conf

echo "Install git ..."
[[ ! -f ~/.gitignore ]] && \
	ln -s .dotfiles.git/files/git/gitignore ~/.gitignore
[[ ! -f ~/.gitconfig ]] && \
	ln -s .dotfiles.git/files/git/gitconfig ~/.gitconfig

if [[ `grep "source ~/.dotfiles.git/files/all" ~/.zshrc | wc -l` = "0" ]]; then
	echo "Install aliases ..."
	echo -e "\nsource ~/.dotfiles.git/files/all" >> ~/.zshrc
fi

command -v terminator 2>&1 >/dev/null
if [[ $? -eq 0 ]]; then
	echo "Install terminator ..."
	mkdir -p ~/.config/terminator
	[[ ! -f ~/.config/terminator/config ]] && \
		ln -s ~/.dotfiles.git/files/terminator/config ~/.config/terminator/config
fi

echo "Install vim..."
[[ ! -f ~/.vimrc ]] && \
	ln -s ~/.dotfiles.git/files/vim/vimrc ~/.vimrc
vim +'PlugInstall --sync' +qa

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
	wget -O ~/.dir_colors/dircolors https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-dark
	echo '[ -f ~/.dir_colors/dircolors ] && eval `dircolors ~/.dir_colors/dircolors`' >> ~/.zshrc
fi

#mkdir -p ~/.dracula
#command -v gnome-terminal 2>&1 >/dev/null
#if [[ $? -eq 0 ]]; then
#	echo "  gnome-terminal ..."
#	[[ ! -d ~/.dracula/gnome-terminal ]] && \
#		git clone https://github.com/dracula/gnome-terminal ~/.dracula/gnome-terminal
#	~/.dracula/gnome-terminal/install.sh
#fi
#command -v terminator 2>&1 >/dev/null
#if [[ $? -eq 0 ]]; then
#	echo "  terminator ..."
#	git clone https://github.com/dracula/terminator.git ~/.dracula/terminator
#	# ~/.dracula/terminator/install.sh -- skipped, already done...
#fi

command -v gnome-tweaks 2>&1 >/dev/null
if [[ $? -eq 0 ]]; then
	echo "Remap Caps Lock to CTRL. Hit enter when done."
	gnome-tweaks &
	read
fi

echo "Restart your shell / terminal"
