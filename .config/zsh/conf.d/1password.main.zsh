command -v op &>/dev/null || return 0

alias op_login='eval $(op signin my)'

function op_get {
	op get item $1 | jq -r '.details.fields[] | select(.type == "P").value'
}