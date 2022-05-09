# doc: https://github.com/olivierverdier/zsh-git-prompt

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[blue]%})"
ZSH_THEME_GIT_PROMPT_SEPARATOR=""
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[red]%}"
ZSH_THEME_GIT_PROMPT_STAGED=""
ZSH_THEME_GIT_PROMPT_CONFLICTS=""
ZSH_THEME_GIT_PROMPT_CHANGED=""
ZSH_THEME_GIT_PROMPT_BEHIND=""
ZSH_THEME_GIT_PROMPT_AHEAD=""
ZSH_THEME_GIT_PROMPT_UNTRACKED=""
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}!"

git_super_status() {
	precmd_update_git_vars
	if [ "$__CURRENT_GIT_STATUS" != ": 0 0 0 0 0 0" ]; then
		STATUS="$ZSH_THEME_GIT_PROMPT_PREFIX"

		if [ "$ZSH_THEME_GIT_PROMPT_BRANCH" != "" ]; then
			STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_BRANCH$GIT_BRANCH%{${reset_color}%}"
		fi
		if [ "$GIT_BEHIND" -ne "0" ] && [ "$ZSH_THEME_GIT_PROMPT_BEHIND" != "" ]; then
			STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_BEHIND$GIT_BEHIND%{${reset_color}%}"
		fi
		if [ "$GIT_AHEAD" -ne "0" ] && [ "$ZSH_THEME_GIT_PROMPT_AHEAD" != "" ]; then
			STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_AHEAD$GIT_AHEAD%{${reset_color}%}"
		fi
		STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_SEPARATOR"
		if [ "$GIT_STAGED" -ne "0" ] && [ "$ZSH_THEME_GIT_PROMPT_STAGED" != "" ]; then
			STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_STAGED$GIT_STAGED%{${reset_color}%}"
		fi
		if [ "$GIT_CONFLICTS" -ne "0" ] && [ "$ZSH_THEME_GIT_PROMPT_CONFLICTS" != "" ]; then
			STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_CONFLICTS$GIT_CONFLICTS%{${reset_color}%}"
		fi
		if [ "$GIT_CHANGED" -ne "0" ] && [ "$ZSH_THEME_GIT_PROMPT_CHANGED" != "" ]; then
			STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_CHANGED$GIT_CHANGED%{${reset_color}%}"
		fi
		if [ "$GIT_UNTRACKED" -ne "0" ]; then
			STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNTRACKED%{${reset_color}%}"
		fi
		if [ "$GIT_CHANGED" -eq "0" ] && [ "$GIT_CONFLICTS" -eq "0" ] && [ "$GIT_STAGED" -eq "0" ] && [ "$GIT_UNTRACKED" -eq "0" ]; then
			STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_CLEAN"
		else
			STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_DIRTY"
		fi
		STATUS="$STATUS%{${reset_color}%}$ZSH_THEME_GIT_PROMPT_SUFFIX"
		echo "$STATUS"
	fi
}

PROMPT='%T %{$fg[green]%}%n@%m%{$reset_color%}:%{$fg[blue]%}%~%{$reset_color%} $(git_super_status) %(?:%{$fg_bold[green]%}$ :%{$fg_bold[red]%}$ %s)%{$reset_color%}'