alias -s xml='function _() { [ -f "$1" ] && [[ "$(basename "$1")" == "pom.xml" ]] && mvnci -f $@ }; _'
