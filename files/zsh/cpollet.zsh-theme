local _status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ %s)"
local _host="%{$fg_bold[green]%}%n@%m%{$reset_color%}"
local _path="%{$fg_bold[blue]%}%~%{$reset_color%}"
PROMPT='%T %{$_host%}:%{$_path%} $(git_prompt_info) ${_status} %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

