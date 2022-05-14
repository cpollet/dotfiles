export PATH=$HOME/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
export ZSH=$HOME/.config/zsh
export VISUAL=vim
export EDITOR=$VISUAL
export PAGER=less
export LESS="-R -M"
ZSH_CACHE_DIR="$HOME/.cache/zsh"

# see man zshoptions for all options

# list jobs in the long format by default.
setopt long_list_jobs

# allow comments even in interactive shells.
setopt interactive_comments
# perform implicit tees or cats when multiple redirections are attempted
setopt multios

# parameter expansion, command substitution and arithmetic expansion are performed in prompts.
setopt prompt_subst

# ^xv   edit current line in $EDITOR
autoload -U edit-command-line;
zle -N edit-command-line;
bindkey '^xv' edit-command-line;

# Load color associative array and setup LS_COLOR
autoload -Uz colors && colors
eval `dircolors ~/.config/dircolors`

find -L "$ZSH/zshrc.d" -type f | sort | while IFS= read -r file; do
	source $file
done

source $ZSH/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source $ZSH/plugins/zsh-git-prompt/zshrc.sh
source $ZSH/themes/cpollet.zsh

[ -f $HOME/.zsh_aliases ] && source ~/.zsh_aliases

# must be the last one (https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md)
source $ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
