command -v op &>/dev/null || return 0

if ! $(command -v _op &>/dev/null); then
	eval "$(op completion zsh)"
    compdef _op op
fi