# ref: https://xpmo.gitlab.io/post/using-zparseopts/

command -v op &>/dev/null || return 0

export OP_ACCOUNT=my
export OP_DEFAULT_VAULT=Personal

alias 1p_login='eval $(op signin)'

function 1p_list {
	op item list --vault "${1:-$OP_DEFAULT_VAULT}"
}

# usage: 1p [--vault VAULT] [--item ITEM]
function 1p {
	zparseopts -D -E - h=help -help=help -vault:=vault -item:=item

	function _help() {
		echo "Usage: 1p [options]"
		echo "  --vault VAULT       The vault to use; default: $OP_DEFAULT_VAULT."
		echo "  --item ITEM         The item to get the password for. If not set a list is shown."
	}

	if (( $# )); then
		end_opts=$@[(i)(--|-)]
		if [[ -n ${invalid_opt::=${(M)@[0,end_opts-1]#-}} ]]; then
			echo >&2 "Invalid options"
			_help >&2
			return 1
		fi
		set -- "${@[0,end_opts-1]}" "${@[end_opts+1,-1]}"
	fi

	[ ${#help} -gt 0 ] && _help && return 0

	vault=${vault[-1]:-$OP_DEFAULT_VAULT}
	item=${item[-1]}
	[ -z "$item" ] && item=$(1p_list "$vault" | awk --field-separator ' ' '{print $2}' | fzf --preview=)

	op read --no-newline op://$vault/$item/password
}