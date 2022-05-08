# TODO delete alias citrix='/opt/Citrix/ICAClient/selfservice'
# alias s='sublime_text'

alias rot13="tr 'A-Za-z' 'N-ZA-Mn-za-m'"

function yaml2json {
	python -c 'import sys, yaml, json; json.dump(yaml.load(sys.stdin), sys.stdout, indent=4)' < $1 > $2 
}

function wt() {
	clear
	date
	$@
	while sleep 2; do
		clear
		date
		$@
	done
}

function ls_colors() {
	for i in {0..255} ; do
		printf "\x1b[38;5;${i}mcolour${i}\n"
	done
}