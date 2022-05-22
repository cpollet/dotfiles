export PATH=$HOME/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
export ZSH=$HOME/.config/zsh
export VISUAL=vim
export EDITOR=$VISUAL
export PAGER=less
export LESS="-R -M"
ZSH_CACHE_DIR="$HOME/.cache/zsh"

fpath=($HOME/.config/zsh/functions/ $fpath)
autoload -Uz include

# see 'man zshoptions' for all options

# list jobs in the long format by default.
setopt long_list_jobs

# allow comments even in interactive shells.
setopt interactive_comments

# perform implicit tees or cats when multiple redirections are attempted
setopt multios

# parameter expansion, command substitution and arithmetic expansion are performed in prompts.
setopt prompt_subst

# load color associative array and setup LS_COLOR
autoload -Uz colors && colors
eval `dircolors ~/.config/dircolors`

CONF_D="$ZSH/conf.d"
find -L "$CONF_D" -type f | sort | while IFS= read -r file; do
	source $file
done

ZVM_LINE_INIT_MODE='i'
source $ZSH/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

source $ZSH/plugins/zsh-git-prompt/zshrc.sh
source $ZSH/themes/cpollet.zsh

include $HOME/.zsh_aliases

# must be the last one
# ref: https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md
source $ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh