if command -v bat &>/dev/null; then
    export FZF_DEFAULT_OPTS="--height=50% --layout=reverse --border=none --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
else
    export FZF_DEFAULT_OPTS="--height=50% --layout=reverse --border=none"
fi