alias 1p_login='eval $(op signin my)'

function 1p_get {
	op get item $1 | jq -r '.details.fields[] | select(.type == "P").value'
}