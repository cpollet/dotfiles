export PATH=$HOME/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
export ZSH=$HOME/.config/zsh
export VISUAL=vim
export EDITOR=$VISUAL
export PAGER=less
export LESS="-R -M"
ZSH_CACHE_DIR="$HOME/.cache/zsh"

LOG=
[ ! -z "$LOG" ] && rm -rf "$LOG"
function _log() {
	[ ! -z "$LOG" ] && echo "[$(date +%s.%N)] $1" >> $LOG
}
function source() {
    _log "sourcing $1"
    builtin source "$1"
}

_log "init started"

fpath=($HOME/.config/zsh/functions/ $fpath)
for fn in $HOME/.config/zsh/functions/*; autoload -Uz "$fn"

zmodload zsh/zutil

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

function zvm_config() {
  ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
  ZVM_INIT_MODE='sourcing'
}
source $ZSH/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source $ZSH/plugins/jq-zsh-plugin/jq.plugin.zsh
source $ZSH/plugins/zsh-git-prompt/zshrc.sh

CONF_D="$ZSH/conf.d"
find -L "$CONF_D" -name "*.main.zsh" -type f | sort | while IFS= read -r file; do
	source $file
done

source $ZSH/themes/cpollet.zsh

include $HOME/.zsh_aliases

# must be the last one
# ref: https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md
source $ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

_log "init finished"

[ -f "$LOG" ] && cat "$LOG"