echo "dont run me, execute all commands with copy paste"
exit 0


rm -f bindkey.sh
for m ($keymaps) bindkey -LM $m >> bindkey.sh
cat bindkey.sh | sort > bindkey.sorted.sh
rm bindkey.sh
zle -lL | sort > zle.sorted.sh
zstyle -L | sort > zstyle.sorted.sh
zmodload -L | sort > zmodload.sorted.sh
typeset -p +H -m '*' | sort > typeset.sorted.sh
functions > functions.sh
