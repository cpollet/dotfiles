alias ps_grep='ps faux | grep -i'
function ps_env() {
	if command -v grcat &>/dev/null; then
		cat /proc/$1/environ | tr '\0' '\n' | grcat conf.env
	else
		cat /proc/$1/environ | tr '\0' '\n'
	fi
}
alias ps_x="xprop | awk '/PID/ {print $3}'"