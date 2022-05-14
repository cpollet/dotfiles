#!/bin/zsh

echo "a" >> /tmp/log

if command grc &>/dev/null; then
    rm -f .local/share/zsh/grc.aliases.zsh
    mkdir -p $HOME/.local/share/zsh

echo "b" >> /tmp/log
    for cmd in g++ gas head make ld ping6 tail traceroute6 $( ls /usr/share/grc/ ); do
echo "c$cmd" >> /tmp/log
        cmd="${cmd##*conf.}"
        if type "${cmd}" &>/dev/null; then
echo "d$cmd" >> /tmp/log
            echo "alias ${cmd}='$( which grc ) --colour=auto ${cmd}'" >> $HOME/.local/share/zsh/grc.aliases.zsh
        fi
    done
fi
echo "e" >> /tmp/log