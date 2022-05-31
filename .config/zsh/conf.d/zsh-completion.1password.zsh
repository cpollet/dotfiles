command -v op &>/dev/null || return 0

if ! $(command -v _op &>/dev/null); then
	eval "$(op completion zsh)"
    compdef _op op
fi

#function _1p() {
#	local context state state_descr line ret=1
#
#	if [[ $service == 1p ]]; then
#		_arguments \
#			'(-h --help)'{-h,--help}'[Get help]' \
#			"--vault[Set <vault> to use; default: $OP_DEFAULT_VAULT]:<vault>:->vaults" \
#			"--item[Set item to fetch]:<item>:_1p_items" && return
#
#		case $state in
#			(vault)
#				local -a items=("${(@f)$(op vault list --format json | jq -r '.[].name')}")
#    			_describe 'vaults' items
#				ret=0
#				;;
#		esac
#	fi
#
#	return $ret
#}
#
#function _1p_vaults() {
#	local -a items=("${(@f)$(op vault list --format json | jq -r '.[].name')}")
#    _describe 'vault' items
#}
#
#function _1p_items() {
#	local -a items=("${(@f)$(op item list --format json | jq -r '.[].title')}")
#    _describe 'item' items
#}
#compdef _1p 1p