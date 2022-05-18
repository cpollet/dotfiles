# inspired by https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/theme-and-appearance.zsh
# doc: https://gist.github.com/thomd/7667642

# configure colors
export LSCOLORS="Gxfxcxdxbxegedabagacad"

if [[ "$OSTYPE" == darwin* ]]; then
  # this is a good alias, it works by default just using $LSCOLORS
  ls -G . &>/dev/null && alias ls='ls -G'

  # only use coreutils ls if there is a dircolors customization present ($LS_COLORS or .dircolors file)
  # otherwise, gls will use the default color scheme which is ugly af
  [[ -n "$LS_COLORS" || -f "$HOME/.dircolors" ]] && gls --color -d . &>/dev/null && alias ls='gls --color=tty'
else
  # For GNU ls, we use the default ls color theme. They can later be overwritten by themes.
  if [[ -z "$LS_COLORS" ]]; then
    (( $+commands[dircolors] )) && eval "$(dircolors -b)"
  fi

  ls --color -d . &>/dev/null && alias ls='ls --color=tty' || { ls -G . &>/dev/null && alias ls='ls -G' }  
fi

alias ll='ls -l'
alias la='ls -a'
alias lla='ls -al'