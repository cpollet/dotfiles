#!/bin/bash
# inspired by https://github.com/dracula/gnome-terminal install script

SELF=`realpath "$0"`
DIR=`dirname "$SELF"` 

dconfdir=/org/gnome/terminal/legacy/profiles:
profiles=($(dconf list $dconfdir/ | grep ^: | sed 's/\///g'))

to_dconf() {
  tr '\n' '~' | sed -e "s#~\$#']\n#" -e "s#~#', '#g" -e "s#^#['#"
}

get_uuid() {
  # Print the UUID linked to the profile name sent in parameter
  local profile_name=$1
  for i in ${!profiles[*]}
    do
      if [[ "$(dconf read $dconfdir/${profiles[i]}/visible-name)" == \
          "'$profile_name'" ]]
        then echo "${profiles[i]}"
        return 0
      fi
    done
  echo "$profile_name"
}

in_array() {
  local e
  for e in "${@:2}"; do
    [[ $e == $2 ]] && return
  done

  false 
}

validate_profile() {
  in_array $1 "${profiles[@]}"
}

set_profile_colors() {
  local profile=$1
  local profile_uuid="$(get_uuid "$profile")"

  if ! validate_profile $profile_uuid; then
    echo "invalid profile '$profile'"
    return 255
  fi

  local scheme=$2
  local scheme_file=$DIR/themes/$scheme

  local bg_color=`grep bg_color "$scheme_file" | cut -d'=' -f2`
  local fg_color=`grep fg_color "$scheme_file" | cut -d'=' -f2`

  local profile_path=$dconfdir/$profile_uuid

  dconf write $profile_path/font "'Monospace 10'"
  dconf write $profile_path/use-system-font "false"
  dconf write $profile_path/use-theme-colors "false"
  dconf write $profile_path/bold-color-same-as-fg "true"
  palette=`mktemp`
  grep color_ $DIR/themes/$scheme \
    | cut -d'=' -f2 \
    | tr '\n' '~' \
    | sed -e "s#~\$#']\n#" -e "s#~#', '#g" -e "s#^#['#" > $palette
  dconf write $profile_path/palette "$(cat $palette)"
  rm $palette
  dconf write $profile_path/background-color "'$bg_color'"
  dconf write $profile_path/foreground-color "'$fg_color'"
}

scheme=$1
profile=$2

set_profile_colors $profile $scheme

