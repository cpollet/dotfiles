GREP_OPTIONS=""

# check for --color=auto
echo | grep --color=auto "" &>/dev/null && GREP_OPTIONS+=" --color=auto"
echo | egrep --color=auto "" &>/dev/null && GREP_OPTIONS+=" --color=auto"
echo | fgrep --color=auto "" &>/dev/null && GREP_OPTIONS+=" --color=auto"

VCS_FOLDERS="{.bzr,CVS,.git,.hg,.svn}"

# check for --exclude-dir, falls back to --exclude if it exists
if echo | grep --exclude-dir=$VCS_FOLDERS "" &>/dev/null; then
	GREP_OPTIONS+=" --exclude-dir=$VCS_FOLDERS"
elif echo | grep --exclude=$VCS_FOLDERS "" &>/dev/null; then
	GREP_OPTIONS+=" --exclude=$VCS_FOLDERS"
fi

alias grep="grep$GREP_OPTIONS"

unset GREP_OPTIONS
unset VCS_FOLDERS