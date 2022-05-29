# ref: https://github.com/sharkdp/bat
! command -v bat &>/dev/null && exit 0

export MANPAGER="sh -c 'col -bx | bat -l man -p'"

alias cat='bat'

function help() {
    "$@" --help 2>&1 | bat --plain --language=help
}