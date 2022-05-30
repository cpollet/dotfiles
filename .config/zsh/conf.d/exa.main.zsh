# ref: https://github.com/ogham/exa
command -v exa &>/dev/null || return 0

alias tree='exa --long --no-permissions --no-filesize --no-time --no-user --tree --git --icons --ignore-glob .git'