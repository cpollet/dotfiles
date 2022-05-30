command -v fzf &>/dev/null || return 0

if command -v bat &>/dev/null; then
    export FZF_DEFAULT_OPTS="--height=50% --layout=reverse --border=none --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
    export FZF_CTRL_T_OPTS="--preview="
    export FZF_CTRL_R_OPTS="--preview="
    export FZF_ALT_C_OPTS="--preview="
else
    export FZF_DEFAULT_OPTS="--height=50% --layout=reverse --border=none"
fi