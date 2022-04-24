#!/bin/bash

git clone https://github.com/cpollet/dotfiles.git ~/.dotfiles.git

echo "Install zsh ..."
echo "When in zsh, hit CTRL+D to continue."
echo "Press enter to continue"
read
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
mkdir -p ~/.oh-my-zsh/custom/themes
ln -s ~/.dotfiles.git/files/zsh/cpollet.zsh-theme ~/.oh-my-zsh/custom/cpollet.zsh-theme
sed -i 's/robbyrussell/cpollet/g' ~/.zshrc
source ~/.zshrc
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
sed -i 's/plugins=(git)/plugins=(git zsh-syntax-highlighting)/g' .zshrc

echo "Install tmux ..."
mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -s ~/.dotfiles.git/files/tmux/tmux.conf ~/.tmux.conf

echo "Install git ..."
ln -s .dotfiles.git/files/git/gitignore ~/.gitignore
ln -s .dotfiles.git/files/git/gitconfig ~/.gitconfig

echo "Install aliases ..."
echo -e "\n. ~/.dotfiles.git/files/all" >> ~/.zshrc

echo "Install terminator ..."
mkdir -p ~/.config/terminator
ln -s ~/.dotfiles.git/files/terminator/config ~/.config/terminator

echo "Install vim..."
ln -s ~/.dotfiles.git/files/vim/vimrc ~/.vimrc

echo "Install dracula theme"
mkdir -p ~/.dracula
command -v gnome-terminal 2>&1 >/dev/null
if [[ $? -eq 0 ]]; then
	git clone https://github.com/dracula/gnome-terminal ~/.dracula/gnome-terminal
	~/.dracula/gnome-terminal/install.sh
	echo '[ -f ~/.dir_colors/dircolors ] && eval `dircolors ~/.dir_colors/dircolors`' >> ~/.zshrc
	rm ~/dircolors
fi
command -v terminator 2>&1 >/dev/null
if [[ $? -eq 0 ]]; then
	git clone https://github.com/dracula/terminator.git ~/.dracula/terminator
	# ~/.dracula/terminator/install.sh -- skipped, already done...
fi

echo "Press CTRL+D to exit subshell"
zsh
