#!/bin/zsh

if command grc &>/dev/null; then
    rm -f $HOME/.local/share/zsh/grc.aliases.zsh
    mkdir -p $HOME/.local/share/zsh

    for cmd in g++ gas head make ld ping6 tail traceroute6 $( ls /usr/share/grc/ ); do
        cmd="${cmd##*conf.}"
        if [ "$cmd" = "mvn" ]; then
		continue
	fi
        if type "${cmd}" &>/dev/null; then
            echo "alias ${cmd}='$( which grc ) --colour=auto ${cmd}'" >> $HOME/.local/share/zsh/grc.aliases.zsh
        fi
    done
fi
