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

function truecolors() {
	# ref: https://github.com/termstandard/colors
	awk 'BEGIN{
		s="          "; s=s s s s s s s s;
		for (colnum = 0; colnum<77; colnum++) {
			r = 255-(colnum*255/76);
			g = (colnum*510/76);
			b = (colnum*255/76);
			if (g>255) g = 510-g;
			printf "\033[48;2;%d;%d;%dm", r,g,b;
			printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
			printf "%s\033[0m", substr(s,colnum+1,1);
		}
		printf "\n";
	}'
}