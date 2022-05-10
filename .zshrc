export PATH=$HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
export ZSH=$HOME/.config/zsh
export VISUAL=vim
export EDITOR=$VISUAL
export PAGER=less
export LESS=-R
ZSH_CACHE_DIR="$HOME/.cache/zsh"

setopt long_list_jobs
setopt interactivecomments
setopt multios
setopt prompt_subst

# Load color associative array and setup LS_COLOR
autoload -Uz colors && colors
eval `dircolors ~/.config/dircolors`

find -L "$ZSH/zshrc.d" -type f | sort | while IFS= read -r file; do
	source $file
done

source $ZSH/plugins/zsh-git-prompt/zshrc.sh
source $ZSH/themes/cpollet.zsh

[ -f $HOME/.zsh_aliases ] && source ~/.zsh_aliases

# must be the last one (https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md)
source $ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh