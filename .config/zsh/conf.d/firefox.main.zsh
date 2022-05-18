alias ff='firefox'
alias ffp='firefox --private-window'
alias killFirefox='kill -9 $(ps aux | grep firefox | awk "{print $2}" | tr "\n" " ")'

case "$OSTYPE" in
  darwin*) source $DOTHOME/firefox/firefox.darwin.zsh ;;
esac
