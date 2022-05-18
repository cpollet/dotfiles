VCS_INFO_formats () {
	setopt localoptions noksharrays NO_shwordsplit
	local msg tmp
	local -i i
	local -A hook_com
	hook_com=(action "$1" action_orig "$1" branch "$2" branch_orig "$2" base "$3" base_orig "$3" staged "$4" staged_orig "$4" unstaged "$5" unstaged_orig "$5" revision "$6" revision_orig "$6" misc "$7" misc_orig "$7" vcs "${vcs}" vcs_orig "${vcs}") 
	hook_com[base-name]="${${hook_com[base]}:t}" 
	hook_com[base-name_orig]="${hook_com[base_name]}" 
	hook_com[subdir]="$(VCS_INFO_reposub ${hook_com[base]})" 
	hook_com[subdir_orig]="${hook_com[subdir]}" 
	: vcs_info-patch-9b9840f2-91e5-4471-af84-9e9a0dc68c1b
	for tmp in base base-name branch misc revision subdir
	do
		hook_com[$tmp]="${hook_com[$tmp]//\%/%%}" 
	done
	VCS_INFO_hook 'post-backend'
	if [[ -n ${hook_com[action]} ]]
	then
		zstyle -a ":vcs_info:${vcs}:${usercontext}:${rrn}" actionformats msgs
		(( ${#msgs} < 1 )) && msgs[1]=' (%s)-[%b|%a]%u%c-' 
	else
		zstyle -a ":vcs_info:${vcs}:${usercontext}:${rrn}" formats msgs
		(( ${#msgs} < 1 )) && msgs[1]=' (%s)-[%b]%u%c-' 
	fi
	if [[ -n ${hook_com[staged]} ]]
	then
		zstyle -s ":vcs_info:${vcs}:${usercontext}:${rrn}" stagedstr tmp
		[[ -z ${tmp} ]] && hook_com[staged]='S'  || hook_com[staged]=${tmp} 
	fi
	if [[ -n ${hook_com[unstaged]} ]]
	then
		zstyle -s ":vcs_info:${vcs}:${usercontext}:${rrn}" unstagedstr tmp
		[[ -z ${tmp} ]] && hook_com[unstaged]='U'  || hook_com[unstaged]=${tmp} 
	fi
	if [[ ${quiltmode} != 'standalone' ]] && VCS_INFO_hook "pre-addon-quilt"
	then
		local REPLY
		VCS_INFO_quilt addon
		hook_com[quilt]="${REPLY}" 
		unset REPLY
	elif [[ ${quiltmode} == 'standalone' ]]
	then
		hook_com[quilt]=${hook_com[misc]} 
	fi
	(( ${#msgs} > maxexports )) && msgs[$(( maxexports + 1 )),-1]=() 
	for i in {1..${#msgs}}
	do
		if VCS_INFO_hook "set-message" $(( $i - 1 )) "${msgs[$i]}"
		then
			zformat -f msg ${msgs[$i]} a:${hook_com[action]} b:${hook_com[branch]} c:${hook_com[staged]} i:${hook_com[revision]} m:${hook_com[misc]} r:${hook_com[base-name]} s:${hook_com[vcs]} u:${hook_com[unstaged]} Q:${hook_com[quilt]} R:${hook_com[base]} S:${hook_com[subdir]}
			msgs[$i]=${msg} 
		else
			msgs[$i]=${hook_com[message]} 
		fi
	done
	hook_com=() 
	backend_misc=() 
	return 0
}
_SUSEconfig () {
	# undefined
	builtin autoload -XUz
}
__git_prompt_git () {
	GIT_OPTIONAL_LOCKS=0 command git "$@"
}
_a2ps () {
	# undefined
	builtin autoload -XUz
}
_a2utils () {
	# undefined
	builtin autoload -XUz
}
_aap () {
	# undefined
	builtin autoload -XUz
}
_absolute_command_paths () {
	# undefined
	builtin autoload -XUz
}
_acpi () {
	# undefined
	builtin autoload -XUz
}
_acpitool () {
	# undefined
	builtin autoload -XUz
}
_acroread () {
	# undefined
	builtin autoload -XUz
}
_adb () {
	# undefined
	builtin autoload -XUz
}
_add-zle-hook-widget () {
	# undefined
	builtin autoload -XUz
}
_add-zsh-hook () {
	# undefined
	builtin autoload -XUz
}
_alias () {
	# undefined
	builtin autoload -XUz
}
_aliases () {
	# undefined
	builtin autoload -XUz
}
_all_labels () {
	local __gopt __len __tmp __pre __suf __ret=1 __descr __spec __prev 
	if [[ "$1" = - ]]
	then
		__prev=- 
		shift
	fi
	__gopt=() 
	zparseopts -D -a __gopt 1 2 V J x
	__tmp=${argv[(ib:4:)-]} 
	__len=$# 
	if [[ __tmp -lt __len ]]
	then
		__pre=$(( __tmp-1 )) 
		__suf=$__tmp 
	elif [[ __tmp -eq $# ]]
	then
		__pre=-2 
		__suf=$(( __len+1 )) 
	else
		__pre=4 
		__suf=5 
	fi
	while comptags "-A$__prev" "$1" curtag __spec
	do
		(( $#funcstack > _tags_level )) && _comp_tags="${_comp_tags% * }" 
		_tags_level=$#funcstack 
		_comp_tags="$_comp_tags $__spec " 
		if [[ "$curtag" = *[^\\]:* ]]
		then
			zformat -f __descr "${curtag#*:}" "d:$3"
			_description "$__gopt[@]" "${curtag%:*}" "$2" "$__descr"
			curtag="${curtag%:*}" 
			"$4" "${(P@)2}" "${(@)argv[5,-1]}" && __ret=0 
		else
			_description "$__gopt[@]" "$curtag" "$2" "$3"
			"${(@)argv[4,__pre]}" "${(P@)2}" "${(@)argv[__suf,-1]}" && __ret=0 
		fi
	done
	return __ret
}
_all_matches () {
	# undefined
	builtin autoload -XUz
}
_alternative () {
	local tags def expl descr action mesgs nm="$compstate[nmatches]" subopts 
	local opt ws curcontext="$curcontext" 
	subopts=() 
	while getopts 'O:C:' opt
	do
		case "$opt" in
			(O) subopts=("${(@P)OPTARG}")  ;;
			(C) curcontext="${curcontext%:*}:$OPTARG"  ;;
		esac
	done
	shift OPTIND-1
	[[ "$1" = -(|-) ]] && shift
	mesgs=() 
	_tags "${(@)argv%%:*}"
	while _tags
	do
		for def
		do
			if _requested "${def%%:*}"
			then
				descr="${${def#*:}%%:*}" 
				action="${def#*:*:}" 
				_description "${def%%:*}" expl "$descr"
				if [[ "$action" = \ # ]]
				then
					mesgs=("$mesgs[@]" "${def%%:*}:$descr") 
				elif [[ "$action" = \(\(*\)\) ]]
				then
					eval ws\=\( "${action[3,-3]}" \)
					_describe -t "${def%%:*}" "$descr" ws -M 'r:|[_-]=* r:|=*' "$subopts[@]"
				elif [[ "$action" = \(*\) ]]
				then
					_all_labels "${def%%:*}" expl "$descr" compadd "$subopts[@]" - ${=action[2,-2]}
				elif [[ "$action" = \{*\} ]]
				then
					while _next_label "${def%%:*}" expl "$descr"
					do
						eval "$action[2,-2]"
					done
				elif [[ "$action" = \ * ]]
				then
					eval "action=( $action )"
					while _next_label "${def%%:*}" expl "$descr"
					do
						"$action[@]"
					done
				else
					eval "action=( $action )"
					while _next_label "${def%%:*}" expl "$descr"
					do
						"$action[1]" "$subopts[@]" "$expl[@]" "${(@)action[2,-1]}"
					done
				fi
			fi
		done
		[[ nm -ne compstate[nmatches] ]] && return 0
	done
	for descr in "$mesgs[@]"
	do
		_message -e "${descr%%:*}" "${descr#*:}"
	done
	return 1
}
_analyseplugin () {
	# undefined
	builtin autoload -XUz
}
_ant () {
	# undefined
	builtin autoload -XUz
}
_antiword () {
	# undefined
	builtin autoload -XUz
}
_apachectl () {
	# undefined
	builtin autoload -XUz
}
_apm () {
	# undefined
	builtin autoload -XUz
}
_approximate () {
	# undefined
	builtin autoload -XUz
}
_apt () {
	# undefined
	builtin autoload -XUz
}
_apt-file () {
	# undefined
	builtin autoload -XUz
}
_apt-move () {
	# undefined
	builtin autoload -XUz
}
_apt-show-versions () {
	# undefined
	builtin autoload -XUz
}
_aptitude () {
	# undefined
	builtin autoload -XUz
}
_arch_archives () {
	# undefined
	builtin autoload -XUz
}
_arch_namespace () {
	# undefined
	builtin autoload -XUz
}
_arg_compile () {
	# undefined
	builtin autoload -XUz
}
_arguments () {
	local long cmd="$words[1]" descr odescr mesg subopts opt opt2 usecc autod 
	local oldcontext="$curcontext" hasopts rawret optarg singopt alwopt 
	local setnormarg start rest
	local -a match mbegin mend
	subopts=() 
	singopt=() 
	while [[ "$1" = -([AMO]*|[CRSWnsw]) ]]
	do
		case "$1" in
			(-C) usecc=yes 
				shift ;;
			(-O) subopts=("${(@P)2}") 
				shift 2 ;;
			(-O*) subopts=("${(@P)${1[3,-1]}}") 
				shift ;;
			(-R) rawret=yes 
				shift ;;
			(-n) setnormarg=yes 
				NORMARG=-1 
				shift ;;
			(-w) optarg=yes 
				shift ;;
			(-W) alwopt=arg 
				shift ;;
			(-[Ss]) singopt+=($1) 
				shift ;;
			(-[AM]) singopt+=($1 $2) 
				shift 2 ;;
			(-[AM]*) singopt+=($1) 
				shift ;;
		esac
	done
	[[ $1 = ':' ]] && shift
	singopt+=(':') 
	[[ "$PREFIX" = [-+] ]] && alwopt=arg 
	long=$argv[(I)--] 
	if (( long ))
	then
		local name tmp tmpargv
		tmpargv=("${(@)argv[1,long-1]}") 
		name=${~words[1]}  2> /dev/null
		[[ "$name" = [^/]*/* ]] && name="$PWD/$name" 
		name="_args_cache_${name}" 
		name="${name//[^a-zA-Z0-9_]/_}" 
		if (( ! ${(P)+name} ))
		then
			local iopts sopts pattern tmpo dir cur cache
			typeset -Ua lopts
			cache=() 
			set -- "${(@)argv[long+1,-1]}"
			iopts=() 
			sopts=() 
			while [[ "$1" = -[is]* ]]
			do
				if [[ "$1" = -??* ]]
				then
					tmp="${1[3,-1]}" 
					cur=1 
				else
					tmp="$2" 
					cur=2 
				fi
				if [[ "$tmp[1]" = '(' ]]
				then
					tmp=(${=tmp[2,-2]}) 
				else
					tmp=("${(@P)tmp}") 
				fi
				if [[ "$1" = -i* ]]
				then
					iopts+=("$tmp[@]") 
				else
					sopts+=("$tmp[@]") 
				fi
				shift cur
			done
			tmp=() 
			_call_program options ${~words[1]} --help 2>&1 | while IFS= read -r opt
			do
				if (( ${#tmp} ))
				then
					if [[ $opt = [[:space:]][[:space:]][[:space:]]*[[:alpha:]]* ]]
					then
						opt=${opt##[[:space:]]##} 
						lopts+=("${^tmp[@]}":${${${opt//:/-}//\[/(}//\]/)}) 
						tmp=() 
						continue
					else
						lopts+=("${^tmp[@]}":) 
						tmp=() 
					fi
				fi
				while [[ $opt = [,[:space:]]#(#b)(-[^,[:space:]]#)(*) ]]
				do
					start=${match[1]} 
					rest=${match[2]} 
					if [[ -z ${tmp[(r)${start%%[^a-zA-Z0-9_-]#}]} ]]
					then
						if [[ $start = (#b)(*)\[(*)\](*) ]]
						then
							tmp+=("${match[1]}${match[2]}${match[3]}" "${match[1]}${match[3]}") 
						else
							tmp+=($start) 
						fi
					fi
					opt=$rest 
				done
				opt=${opt## [^[:space:]]##  } 
				opt=${opt##[[:space:]]##} 
				if [[ -n $opt ]]
				then
					lopts+=("${^tmp[@]}":${${${opt//:/-}//\[/(}//\]/)}) 
					tmp=() 
				fi
			done
			if (( ${#tmp} ))
			then
				lopts+=("${^tmp[@]}":) 
			fi
			tmp=() 
			for opt in "${(@)${(@)lopts:#--}%%[\[:=]*}"
			do
				let "$tmpargv[(I)(|\([^\)]#\))(|\*)${opt}(|[-+]|=(|-))(|\[*\])(|:*)]" || tmp+=("$lopts[(r)$opt(|[\[:=]*)]") 
			done
			lopts=("$tmp[@]") 
			while (( $#iopts ))
			do
				lopts=(${lopts:#$~iopts[1](|[\[:=]*)}) 
				shift iopts
			done
			while (( $#sopts ))
			do
				lopts+=(${lopts/$~sopts[1]/$sopts[2]}) 
				shift 2 sopts
			done
			argv+=('*=FILE*:file:_files' '*=(DIR|PATH)*:directory:_files -/' '*=*:=: ' '*: :  ') 
			while (( $# ))
			do
				pattern="${${${(M)1#*[^\\]:}[1,-2]}//\\\\:/:}" 
				descr="${1#${pattern}}" 
				if [[ "$pattern" = *\(-\) ]]
				then
					pattern="$pattern[1,-4]" 
					dir=- 
				else
					dir= 
				fi
				shift
				tmp=("${(@M)lopts:##$~pattern:*}") 
				lopts=("${(@)lopts:##$~pattern:*}") 
				(( $#tmp )) || continue
				opt='' 
				tmp=("${(@)tmp%:}") 
				tmpo=("${(@M)tmp:#[^:]##\[\=*}") 
				if (( $#tmpo ))
				then
					tmp=("${(@)tmp:#[^:]##\[\=*}") 
					for opt in "$tmpo[@]"
					do
						if [[ $opt = (#b)(*):([^:]#) ]]
						then
							opt=$match[1] 
							odescr="[${match[2]}]" 
						else
							odescr= 
						fi
						if [[ $opt = (#b)(*)\[\=* ]]
						then
							opt2=${${match[1]}//[^a-zA-Z0-9_-]}=-${dir}${odescr} 
						else
							opt2=${${opt}//[^a-zA-Z0-9_-]}=${dir}${odescr} 
						fi
						if [[ "$descr" = :\=* ]]
						then
							cache+=("${opt2}::${(L)${opt%\]}#*\=}: ") 
						elif [[ "$descr" = ::* ]]
						then
							cache+=("${opt2}${descr}") 
						else
							cache+=("${opt2}:${descr}") 
						fi
					done
				fi
				tmpo=("${(@M)tmp:#[^:]##\=*}") 
				if (( $#tmpo ))
				then
					tmp=("${(@)tmp:#[^:]##\=*}") 
					for opt in "$tmpo[@]"
					do
						if [[ $opt = (#b)(*):([^:]#) ]]
						then
							opt=$match[1] 
							odescr="[${match[2]}]" 
						else
							odescr= 
						fi
						opt2="${${opt%%\=*}//[^a-zA-Z0-9_-]}=${dir}${odescr}" 
						if [[ "$descr" = :\=* ]]
						then
							cache+=("${opt2}:${(L)${opt%\]}#*\=}: ") 
						else
							cache+=("${opt2}${descr}") 
						fi
					done
				fi
				if (( $#tmp ))
				then
					tmp=("${(@)^${(@)tmp:#^*:*}//:/[}]" "${(@)${(@)tmp:#*:*}//[^a-zA-Z0-9_-]}") 
					if [[ -n "$descr" && "$descr" != ': :  ' ]]
					then
						cache+=("${(@)^tmp}${descr}") 
					else
						cache+=("$tmp[@]") 
					fi
				fi
			done
			set -A "$name" "${(@)cache:# #}"
		fi
		set -- "$tmpargv[@]" "${(@P)name}"
	fi
	zstyle -s ":completion:${curcontext}:options" auto-description autod
	if (( $# )) && comparguments -i "$autod" "$singopt[@]" "$@"
	then
		local action noargs aret expl local tried ret=1 
		local next direct odirect equal single matcher matched ws tmp1 tmp2 tmp3
		local opts subc tc prefix suffix descrs actions subcs anum
		local origpre="$PREFIX" origipre="$IPREFIX" nm="$compstate[nmatches]" 
		if comparguments -D descrs actions subcs
		then
			if comparguments -O next direct odirect equal
			then
				opts=yes 
				_tags "$subcs[@]" options
			else
				_tags "$subcs[@]"
			fi
		else
			if comparguments -a
			then
				noargs='no more arguments' 
			else
				noargs='no arguments' 
			fi
			if comparguments -O next direct odirect equal
			then
				opts=yes 
				_tags options
			elif [[ $? -eq 2 ]]
			then
				compadd -Q - "${PREFIX}${SUFFIX}"
				return 0
			else
				_message "$noargs"
				return 1
			fi
		fi
		comparguments -M matcher
		context=() 
		state=() 
		state_descr=() 
		while true
		do
			while _tags
			do
				anum=1 
				if [[ -z "$tried" ]]
				then
					while [[ anum -le $#descrs ]]
					do
						action="$actions[anum]" 
						descr="$descrs[anum]" 
						subc="$subcs[anum++]" 
						if [[ $subc = argument* && -n $setnormarg ]]
						then
							comparguments -n NORMARG
						fi
						if [[ -n "$matched" ]] || _requested "$subc"
						then
							curcontext="${oldcontext%:*}:$subc" 
							_description "$subc" expl "$descr"
							if [[ "$action" = \=\ * ]]
							then
								action="$action[3,-1]" 
								words=("$subc" "$words[@]") 
								(( CURRENT++ ))
							fi
							if [[ "$action" = -\>* ]]
							then
								action="${${action[3,-1]##[ 	]#}%%[ 	]#}" 
								if (( ! $state[(I)$action] ))
								then
									comparguments -W line opt_args
									state+=("$action") 
									state_descr+=("$descr") 
									if [[ -n "$usecc" ]]
									then
										curcontext="${oldcontext%:*}:$subc" 
									else
										context+=("$subc") 
									fi
									compstate[restore]='' 
									aret=yes 
								fi
							else
								if [[ -z "$local" ]]
								then
									local line
									typeset -A opt_args
									local=yes 
								fi
								comparguments -W line opt_args
								if [[ "$action" = \ # ]]
								then
									_message -e "$subc" "$descr"
									mesg=yes 
									tried=yes 
									alwopt=${alwopt:-yes} 
								elif [[ "$action" = \(\(*\)\) ]]
								then
									eval ws\=\( "${action[3,-3]}" \)
									_describe -t "$subc" "$descr" ws -M "$matcher" "$subopts[@]" || alwopt=${alwopt:-yes} 
									tried=yes 
								elif [[ "$action" = \(*\) ]]
								then
									eval ws\=\( "${action[2,-2]}" \)
									_all_labels "$subc" expl "$descr" compadd "$subopts[@]" -a - ws || alwopt=${alwopt:-yes} 
									tried=yes 
								elif [[ "$action" = \{*\} ]]
								then
									while _next_label "$subc" expl "$descr"
									do
										eval "$action[2,-2]" && ret=0 
									done
									(( ret )) && alwopt=${alwopt:-yes} 
									tried=yes 
								elif [[ "$action" = \ * ]]
								then
									eval "action=( $action )"
									while _next_label "$subc" expl "$descr"
									do
										"$action[@]" && ret=0 
									done
									(( ret )) && alwopt=${alwopt:-yes} 
									tried=yes 
								else
									eval "action=( $action )"
									while _next_label "$subc" expl "$descr"
									do
										"$action[1]" "$subopts[@]" "$expl[@]" "${(@)action[2,-1]}" && ret=0 
									done
									(( ret )) && alwopt=${alwopt:-yes} 
									tried=yes 
								fi
							fi
						fi
					done
				fi
				if _requested options && [[ -z "$hasopts" && -z "$matched" && ( -z "$aret" || "$PREFIX" = "$origpre" ) ]] && {
						! zstyle -T ":completion:${oldcontext%:*}:options" prefix-needed || [[ "$origpre" = [-+]* || -z "$aret$mesg$tried" ]]
					}
				then
					local prevpre="$PREFIX" previpre="$IPREFIX" prevcontext="$curcontext" 
					curcontext="${oldcontext%:*}:options" 
					hasopts=yes 
					PREFIX="$origpre" 
					IPREFIX="$origipre" 
					if [[ -z "$alwopt" || -z "$tried" || "$alwopt" = arg ]] && comparguments -s single
					then
						if [[ "$single" = direct ]]
						then
							_all_labels options expl option compadd -QS '' - "${PREFIX}${SUFFIX}"
						elif [[ -z "$optarg" && "$single" = next ]]
						then
							_all_labels options expl option compadd -Q - "${PREFIX}${SUFFIX}"
						elif [[ "$single" = equal ]]
						then
							_all_labels options expl option compadd -QqS= - "${PREFIX}${SUFFIX}"
						else
							tmp1=("$next[@]" "$direct[@]" "$odirect[@]" "$equal[@]") 
							[[ "$PREFIX" = [-+]* ]] && tmp1=("${(@M)tmp1:#${PREFIX[1]}*}") 
							[[ "$single" = next ]] && tmp1=("${(@)tmp1:#[-+]${PREFIX[-1]}((#e)|:*)}") 
							[[ "$PREFIX" != --* ]] && tmp1=("${(@)tmp1:#--*}") 
							tmp3=("${(M@)tmp1:#[-+]?[^:]*}") 
							tmp1=("${(M@)tmp1:#[-+]?(|:*)}") 
							tmp2=("${PREFIX}${(@M)^${(@)${(@)tmp1%%:*}#[-+]}:#?}") 
							_describe -O option tmp1 tmp2 -Q -S '' -- tmp3 -Q
							[[ -n "$optarg" && "$single" = next && nm -eq $compstate[nmatches] ]] && _all_labels options expl option compadd -Q - "${PREFIX}${SUFFIX}"
						fi
						single=yes 
					else
						next+=("$odirect[@]") 
						_describe -O option next -Q -M "$matcher" -- direct -QS '' -M "$matcher" -- equal -QqS= -M "$matcher"
					fi
					PREFIX="$prevpre" 
					IPREFIX="$previpre" 
					curcontext="$prevcontext" 
				fi
				[[ -n "$tried" && "${${alwopt:+$origpre}:-$PREFIX}" != [-+]* ]] && break
			done
			if [[ -n "$opts" && -z "$aret" && -z "$matched" && ( -z "$tried" || -n "$alwopt" ) && nm -eq compstate[nmatches] ]]
			then
				PREFIX="$origpre" 
				IPREFIX="$origipre" 
				prefix="${PREFIX#*\=}" 
				suffix="$SUFFIX" 
				PREFIX="${PREFIX%%\=*}" 
				SUFFIX='' 
				compadd -M "$matcher" -D equal - "${(@)equal%%:*}"
				if [[ $#equal -eq 1 ]]
				then
					PREFIX="$prefix" 
					SUFFIX="$suffix" 
					IPREFIX="${IPREFIX}${equal[1]%%:*}=" 
					matched=yes 
					comparguments -L "${equal[1]%%:*}" descrs actions subcs
					_tags "$subcs[@]"
					continue
				fi
			fi
			break
		done
		[[ -z "$aret" || -z "$usecc" ]] && curcontext="$oldcontext" 
		if [[ -n "$aret" ]]
		then
			[[ -n $rawret ]] && return 300
		else
			[[ -n "$noargs" && nm -eq "$compstate[nmatches]" ]] && _message "$noargs"
		fi
		[[ nm -ne "$compstate[nmatches]" ]]
	else
		return 1
	fi
}
_arp () {
	# undefined
	builtin autoload -XUz
}
_arping () {
	# undefined
	builtin autoload -XUz
}
_arrays () {
	# undefined
	builtin autoload -XUz
}
_assign () {
	# undefined
	builtin autoload -XUz
}
_at () {
	# undefined
	builtin autoload -XUz
}
_attr () {
	# undefined
	builtin autoload -XUz
}
_augeas () {
	# undefined
	builtin autoload -XUz
}
_auto-apt () {
	# undefined
	builtin autoload -XUz
}
_autocd () {
	_command_names
	local ret=$? 
	[[ -o autocd ]] && _cd || return ret
}
_awk () {
	# undefined
	builtin autoload -XUz
}
_axi-cache () {
	# undefined
	builtin autoload -XUz
}
_basename () {
	# undefined
	builtin autoload -XUz
}
_bash_complete () {
	local ret=1 
	local -a suf matches
	local -x COMP_POINT COMP_CWORD
	local -a COMP_WORDS COMPREPLY BASH_VERSINFO
	local -x COMP_LINE="$words" 
	local -A savejobstates savejobtexts
	(( COMP_POINT = 1 + ${#${(j. .)words[1,CURRENT]}} + $#QIPREFIX + $#IPREFIX + $#PREFIX ))
	(( COMP_CWORD = CURRENT - 1))
	COMP_WORDS=($words) 
	BASH_VERSINFO=(2 05b 0 1 release) 
	savejobstates=(${(kv)jobstates}) 
	savejobtexts=(${(kv)jobtexts}) 
	[[ ${argv[${argv[(I)nospace]:-0}-1]} = -o ]] && suf=(-S '') 
	matches=(${(f)"$(compgen $@ -- ${words[CURRENT]})"}) 
	if [[ -n $matches ]]
	then
		if [[ ${argv[${argv[(I)filenames]:-0}-1]} = -o ]]
		then
			compset -P '*/' && matches=(${matches##*/}) 
			compset -S '/*' && matches=(${matches%%/*}) 
			compadd -Q -f "${suf[@]}" -a matches && ret=0 
		else
			compadd -Q "${suf[@]}" -a matches && ret=0 
		fi
	fi
	if (( ret ))
	then
		if [[ ${argv[${argv[(I)default]:-0}-1]} = -o ]]
		then
			_default "${suf[@]}" && ret=0 
		elif [[ ${argv[${argv[(I)dirnames]:-0}-1]} = -o ]]
		then
			_directories "${suf[@]}" && ret=0 
		fi
	fi
	return ret
}
_bash_completions () {
	# undefined
	builtin autoload -XUz
}
_baudrates () {
	# undefined
	builtin autoload -XUz
}
_baz () {
	# undefined
	builtin autoload -XUz
}
_be_name () {
	# undefined
	builtin autoload -XUz
}
_beadm () {
	# undefined
	builtin autoload -XUz
}
_beep () {
	# undefined
	builtin autoload -XUz
}
_bibtex () {
	# undefined
	builtin autoload -XUz
}
_bind_addresses () {
	# undefined
	builtin autoload -XUz
}
_bindkey () {
	# undefined
	builtin autoload -XUz
}
_bison () {
	# undefined
	builtin autoload -XUz
}
_bittorrent () {
	# undefined
	builtin autoload -XUz
}
_bogofilter () {
	# undefined
	builtin autoload -XUz
}
_bootctl () {
	# undefined
	builtin autoload -XUz
}
_bpython () {
	# undefined
	builtin autoload -XUz
}
_brace_parameter () {
	# undefined
	builtin autoload -XUz
}
_brctl () {
	# undefined
	builtin autoload -XUz
}
_bsd_pkg () {
	# undefined
	builtin autoload -XUz
}
_bsdconfig () {
	# undefined
	builtin autoload -XUz
}
_bsdinstall () {
	# undefined
	builtin autoload -XUz
}
_btrfs () {
	# undefined
	builtin autoload -XUz
}
_bts () {
	# undefined
	builtin autoload -XUz
}
_bug () {
	# undefined
	builtin autoload -XUz
}
_builtin () {
	# undefined
	builtin autoload -XUz
}
_busctl () {
	# undefined
	builtin autoload -XUz
}
_bzip2 () {
	# undefined
	builtin autoload -XUz
}
_bzr () {
	# undefined
	builtin autoload -XUz
}
_cabal () {
	# undefined
	builtin autoload -XUz
}
_cache_invalid () {
	# undefined
	builtin autoload -XUz
}
_cal () {
	# undefined
	builtin autoload -XUz
}
_calendar () {
	# undefined
	builtin autoload -XUz
}
_call_function () {
	# undefined
	builtin autoload -XUz
}
_call_program () {
	local curcontext="${curcontext}" tmp err_fd=-1 
	local -a prefix
	if [[ "$1" = -p ]]
	then
		shift
		if (( $#_comp_priv_prefix ))
		then
			curcontext="${curcontext%:*}/${${(@M)_comp_priv_prefix:#^*[^\\]=*}[1]}:" 
			zstyle -t ":completion:${curcontext}:${1}" gain-privileges && prefix=($_comp_priv_prefix) 
		fi
	fi
	if (( ${debug_fd:--1} > 2 )) || [[ ! -t 2 ]]
	then
		exec {err_fd}>&2
	else
		exec {err_fd}> /dev/null
	fi
	{
		if zstyle -s ":completion:${curcontext}:${1}" command tmp
		then
			if [[ "$tmp" = -* ]]
			then
				eval "$tmp[2,-1]" "$argv[2,-1]"
			else
				eval $prefix "$tmp"
			fi
		else
			eval $prefix "$argv[2,-1]"
		fi 2>&$err_fd
	} always {
		exec {err_fd}>&-
	}
}
_call_whatis () {
	case "$(whatis --version)" in
		("whatis from "*) local -A args
			zparseopts -D -A args s: r:
			apropos "${args[-r]:-"$@"}" | fgrep "($args[-s]" ;;
		(*) whatis "$@" ;;
	esac
}
_canonical_paths () {
	# undefined
	builtin autoload -XUz
}
_cat () {
	local -a args
	if _pick_variant gnu=GNU unix --version
	then
		args=('(-A --show-all)'{-A,--show-all}'[equivalent to -vET]' '(-b --number-nonblank -n --number)'{-b,--number-nonblank}'[number nonempty output lines, overrides -n]' '-e[equivalent to -vE]' '(-E --show-ends)'{-E,--show-ends}'[display $ at end of each line]' '(-n --number)'{-n,--number}'[number all output lines]' '(-s --squeeze-blank)'{-s,--squeeze-blank}'[suppress repeated empty output lines]' '-t[equivalent to -vT]' '(-T --show-tabs)'{-T,--show-tabs}'[display TAB characters as ^I]' '-u[ignored]' '(-v --show-nonprinting)'{-v,--show-nonprinting}'[use ^ and M- notation, except for LFD and TAB]' '(- : *)--help[display help and exit]' '(- : *)--version[output version information and exit]' '*:files:_files') 
	elif [[ "$OSTYPE" == (*bsd|dragonfly|darwin)* ]]
	then
		args=(-A "-*" '(-n)-b[number non-blank output lines]' '(-v)-e[display $ at the end of each line (implies -v)]' '-n[number all output lines]' '-s[squeeze multiple blank lines into one]' '(-v)-t[display tab as ^I (implies -v)]' '-u[do not buffer output]' '-v[display non-printing chars as ^X or M-a]' '*:files:_files') 
		[[ $OSTYPE = (free|net)bsd* ]] && args+=('-l[set a lock on the stdout file descriptor]') 
		[[ $OSTYPE = netbsd* ]] && args+=('-B+[read with buffer of specified size]:size (bytes)' '-f[only attempt to display regular files]') 
	elif [[ $OSTYPE = solaris* ]]
	then
		args=(-A "-*" '(-b)-n[number all output lines]' '(-n)-b[number non-blank output lines]' "-u[don't buffer output]" '-s[be silent about non-existent files]' '-v[display non-printing chars as ^X or M-a]' '-e[display $ at the end of each line (requires -v)]' '-t[display tab as ^I and formfeeds and ^L (requires -v)]' '*:files:_files') 
	else
		args=('-n[number all output lines]' '-u[do not buffer output]' '*:files:_files') 
	fi
	_arguments -s -S $args
}
_ccal () {
	# undefined
	builtin autoload -XUz
}
_cd () {
	_cd_options () {
		_arguments -s '-q[quiet, no output or use of hooks]' '-s[refuse to use paths with symlinks]' '(-P)-L[retain symbolic links ignoring CHASE_LINKS]' '(-L)-P[resolve symbolic links as CHASE_LINKS]'
	}
	setopt localoptions nonomatch
	local expl ret=1 curarg 
	integer argstart=2 noopts 
	if (( CURRENT > 1 ))
	then
		while [[ $words[$argstart] = -* && argstart -lt CURRENT ]]
		do
			curarg=$words[$argstart] 
			[[ $curarg = -<-> ]] && break
			(( argstart++ ))
			[[ $curarg = -- ]] && noopts=1  && break
		done
	fi
	if [[ CURRENT -eq $((argstart+1)) ]]
	then
		local rep
		rep=(${~PWD/$words[$argstart]/*}~$PWD(-/)) 
		rep=(${${rep#${PWD%%$words[$argstart]*}}%${PWD#*$words[$argstart]}}) 
		(( $#rep )) && _wanted -C replacement strings expl replacement compadd -a rep
	else
		if [[ "$PREFIX" == (#b)(\~|)[^/]# && ( -n "$match[1]" || ( CURRENT -gt 1 && ! -o cdablevars ) ) ]]
		then
			_directory_stack && ret=0 
		fi
		local -a tmpWpath
		if [[ $PREFIX = (|*/)../* ]]
		then
			local tmpprefix
			tmpprefix=$(cd ${PREFIX%/*} >&/dev/null && print $PWD) 
			if [[ -n $tmpprefix ]]
			then
				tmpWpath=(-W $tmpprefix) 
				IPREFIX=${IPREFIX}${PREFIX%/*}/ 
				PREFIX=${PREFIX##*/} 
			fi
		fi
		if [[ $PREFIX != (\~|/|./|../)* && $IPREFIX != ../* ]]
		then
			local tmpcdpath alt
			alt=() 
			tmpcdpath=(${${(@)cdpath:#.}:#$PWD}) 
			(( $#tmpcdpath )) && alt=('path-directories:directory in cdpath:_path_files -W tmpcdpath -/') 
			if [[ -o cdablevars && -n "$PREFIX" && "$PREFIX" != <-> ]]
			then
				if [[ "$PREFIX" != */* ]]
				then
					alt=("$alt[@]" 'named-directories: : _tilde') 
				else
					local oipre="$IPREFIX" opre="$PREFIX" dirpre dir 
					dirpre="${PREFIX%%/*}/" 
					IPREFIX="$IPREFIX$dirpre" 
					eval "dir=( ~$dirpre )"
					PREFIX="${PREFIX#*/}" 
					[[ $#dir -eq 1 && "$dir[1]" != "~$dirpre" ]] && _wanted named-directories expl 'directory after cdablevar' _path_files -W dir -/ && ret=0 
					PREFIX="$opre" 
					IPREFIX="$oipre" 
				fi
			fi
			[[ CURRENT -ne 1 || ( -z "$path[(r).]" && $PREFIX != */* ) ]] && alt=("${cdpath+local-}directories:${cdpath+local }directory:_path_files ${(j: :)${(@q)tmpWpath}} -/" "$alt[@]") 
			if [[ CURRENT -eq argstart && noopts -eq 0 && $PREFIX = -* ]] && zstyle -t ":completion:${curcontext}:options" complete-options
			then
				alt=("$service-options:$service option:_cd_options" "$alt[@]") 
			fi
			_alternative "$alt[@]" && ret=0 
			return ret
		fi
		[[ CURRENT -ne 1 ]] && _wanted directories expl directory _path_files $tmpWpath -/ && ret=0 
		return ret
	fi
}
_cd_options () {
	_arguments -s '-q[quiet, no output or use of hooks]' '-s[refuse to use paths with symlinks]' '(-P)-L[retain symbolic links ignoring CHASE_LINKS]' '(-L)-P[resolve symbolic links as CHASE_LINKS]'
}
_cdbs-edit-patch () {
	# undefined
	builtin autoload -XUz
}
_cdcd () {
	# undefined
	builtin autoload -XUz
}
_cdr () {
	# undefined
	builtin autoload -XUz
}
_cdrdao () {
	# undefined
	builtin autoload -XUz
}
_cdrecord () {
	# undefined
	builtin autoload -XUz
}
_chflags () {
	# undefined
	builtin autoload -XUz
}
_chkconfig () {
	# undefined
	builtin autoload -XUz
}
_chmod () {
	# undefined
	builtin autoload -XUz
}
_chown () {
	# undefined
	builtin autoload -XUz
}
_chrt () {
	# undefined
	builtin autoload -XUz
}
_chsh () {
	# undefined
	builtin autoload -XUz
}
_clay () {
	# undefined
	builtin autoload -XUz
}
_cmdambivalent () {
	# undefined
	builtin autoload -XUz
}
_cmdstring () {
	# undefined
	builtin autoload -XUz
}
_cmp () {
	# undefined
	builtin autoload -XUz
}
_combination () {
	# undefined
	builtin autoload -XUz
}
_comm () {
	# undefined
	builtin autoload -XUz
}
_command () {
	# undefined
	builtin autoload -XUz
}
_command_names () {
	local args defs ffilt
	zstyle -t ":completion:${curcontext}:commands" rehash && rehash
	zstyle -t ":completion:${curcontext}:functions" prefix-needed && [[ $PREFIX != [_.]* ]] && ffilt='[(I)[^_.]*]' 
	defs=('commands:external command:_path_commands') 
	[[ -n "$path[(r).]" || $PREFIX = */* ]] && defs+=('executables:executable file:_files -g \*\(-\*\)') 
	if [[ "$1" = -e ]]
	then
		shift
	else
		[[ "$1" = - ]] && shift
		defs=("$defs[@]" 'builtins:builtin command:compadd -Qk builtins' "functions:shell function:compadd -k 'functions$ffilt'" 'aliases:alias:compadd -Qk aliases' 'suffix-aliases:suffix alias:_suffix_alias_files' 'reserved-words:reserved word:compadd -Qk reswords' 'jobs:: _jobs -t' 'parameters:: _parameters -g "^*readonly*" -qS= -r "\n\t\- =["') 
	fi
	args=("$@") 
	local -a cmdpath
	if zstyle -a ":completion:${curcontext}" command-path cmdpath && [[ $#cmdpath -gt 0 ]]
	then
		local -a +h path
		local -A +h commands
		path=($cmdpath) 
	fi
	_alternative -O args "$defs[@]"
}
_comp_locale () {
	# undefined
	builtin autoload -XUz
}
_compadd () {
	# undefined
	builtin autoload -XUz
}
_compdef () {
	# undefined
	builtin autoload -XUz
}
_complete () {
	local comp name oldcontext ret=1 service 
	typeset -T curcontext="$curcontext" ccarray 
	oldcontext="$curcontext" 
	if [[ -n "$compcontext" ]]
	then
		if [[ "${(t)compcontext}" = *array* ]]
		then
			local expl
			_wanted values expl value compadd -a - compcontext
		elif [[ "${(t)compcontext}" = *assoc* ]]
		then
			local expl tmp i
			tmp=() 
			for i in "${(@k)compcontext[(R)*[^[:blank:]]]}"
			do
				tmp=("$tmp[@]" "${i}:${compcontext[$i]}") 
			done
			tmp=("$tmp[@]" "${(k@)compcontext[(R)[[:blank:]]#]}") 
			_describe -t values value tmp
		elif [[ "$compcontext" = *:*:* ]]
		then
			local tag="${${compcontext%%:*}:-values}" 
			local descr="${${${compcontext#${tag}:}%%:*}:-value}" 
			local action="${compcontext#${tag}:${descr}:}" expl ws ret=1 
			case "$action" in
				(\ #) _message -e "$tag" "$descr" ;;
				(\(\(*\)\)) eval ws\=\( "${action[3,-3]}" \)
					_describe -t "$tag" "$descr" ws ;;
				(\(*\)) eval ws\=\( "${action[2,-2]}" \)
					_wanted "$tag" expl "$descr" compadd -a - ws ;;
				(\{*\}) _tags "$tag"
					while _tags
					do
						while _next_label "$tag" expl "$descr"
						do
							eval "$action[2,-2]" && ret=0 
						done
						(( ret )) || break
					done ;;
				(\ *) eval ws\=\( "$action" \)
					_tags "$tag"
					while _tags
					do
						while _next_label "$tag" expl "$descr"
						do
							"$ws[@]"
						done
						(( ret )) || break
					done ;;
				(*) eval ws\=\( "$action" \)
					_tags "$tag"
					while _tags
					do
						while _next_label "$tag" expl "$descr"
						do
							"$ws[1]" "$expl[@]" "${(@)ws[2,-1]}"
						done
						(( ret )) || break
					done ;;
			esac
		else
			ccarray[3]="$compcontext" 
			comp="$_comps[$compcontext]" 
			[[ -n "$comp" ]] && eval "$comp"
		fi
		return
	fi
	comp="$_comps[-first-]" 
	if [[ -n "$comp" ]]
	then
		service="${_services[-first-]:--first-}" 
		ccarray[3]=-first- 
		eval "$comp" && ret=0 
		if [[ "$_compskip" = all ]]
		then
			_compskip= 
			return ret
		fi
	fi
	[[ -n $compstate[vared] ]] && compstate[context]=vared 
	ret=1 
	if [[ "$compstate[context]" = command ]]
	then
		curcontext="$oldcontext" 
		_normal -s && ret=0 
	else
		local cname="-${compstate[context]:s/_/-/}-" 
		ccarray[3]="$cname" 
		comp="$_comps[$cname]" 
		service="${_services[$cname]:-$cname}" 
		if [[ -z "$comp" ]]
		then
			if [[ "$_compskip" = *default* ]]
			then
				_compskip= 
				return 1
			fi
			comp="$_comps[-default-]" 
			service="${_services[-default-]:--default-}" 
		fi
		[[ -n "$comp" ]] && eval "$comp" && ret=0 
	fi
	_compskip= 
	return ret
}
_complete_debug () {
	# undefined
	builtin autoload -XUz
}
_complete_help () {
	# undefined
	builtin autoload -XUz
}
_complete_help_generic () {
	# undefined
	builtin autoload -XUz
}
_complete_tag () {
	# undefined
	builtin autoload -XUz
}
_completers () {
	# undefined
	builtin autoload -XUz
}
_compress () {
	# undefined
	builtin autoload -XUz
}
_condition () {
	# undefined
	builtin autoload -XUz
}
_configure () {
	# undefined
	builtin autoload -XUz
}
_coreadm () {
	# undefined
	builtin autoload -XUz
}
_correct () {
	# undefined
	builtin autoload -XUz
}
_correct_filename () {
	# undefined
	builtin autoload -XUz
}
_correct_word () {
	# undefined
	builtin autoload -XUz
}
_cowsay () {
	# undefined
	builtin autoload -XUz
}
_cp () {
	# undefined
	builtin autoload -XUz
}
_cpio () {
	# undefined
	builtin autoload -XUz
}
_cplay () {
	# undefined
	builtin autoload -XUz
}
_cpupower () {
	# undefined
	builtin autoload -XUz
}
_cryptsetup () {
	# undefined
	builtin autoload -XUz
}
_cscope () {
	# undefined
	builtin autoload -XUz
}
_cssh () {
	# undefined
	builtin autoload -XUz
}
_csup () {
	# undefined
	builtin autoload -XUz
}
_ctags_tags () {
	# undefined
	builtin autoload -XUz
}
_cu () {
	# undefined
	builtin autoload -XUz
}
_curl () {
	# undefined
	builtin autoload -XUz
}
_cut () {
	# undefined
	builtin autoload -XUz
}
_cvs () {
	# undefined
	builtin autoload -XUz
}
_cvsup () {
	# undefined
	builtin autoload -XUz
}
_cygcheck () {
	# undefined
	builtin autoload -XUz
}
_cygpath () {
	# undefined
	builtin autoload -XUz
}
_cygrunsrv () {
	# undefined
	builtin autoload -XUz
}
_cygserver () {
	# undefined
	builtin autoload -XUz
}
_cygstart () {
	# undefined
	builtin autoload -XUz
}
_dak () {
	# undefined
	builtin autoload -XUz
}
_darcs () {
	# undefined
	builtin autoload -XUz
}
_date () {
	# undefined
	builtin autoload -XUz
}
_date_formats () {
	# undefined
	builtin autoload -XUz
}
_dates () {
	# undefined
	builtin autoload -XUz
}
_dbus () {
	# undefined
	builtin autoload -XUz
}
_dchroot () {
	# undefined
	builtin autoload -XUz
}
_dchroot-dsa () {
	# undefined
	builtin autoload -XUz
}
_dcop () {
	# undefined
	builtin autoload -XUz
}
_dcut () {
	# undefined
	builtin autoload -XUz
}
_dd () {
	# undefined
	builtin autoload -XUz
}
_deb_architectures () {
	# undefined
	builtin autoload -XUz
}
_deb_codenames () {
	# undefined
	builtin autoload -XUz
}
_deb_packages () {
	# undefined
	builtin autoload -XUz
}
_debbugs_bugnumber () {
	# undefined
	builtin autoload -XUz
}
_debchange () {
	# undefined
	builtin autoload -XUz
}
_debcheckout () {
	# undefined
	builtin autoload -XUz
}
_debdiff () {
	# undefined
	builtin autoload -XUz
}
_debfoster () {
	# undefined
	builtin autoload -XUz
}
_debsign () {
	# undefined
	builtin autoload -XUz
}
_default () {
	local ctl
	if {
			zstyle -s ":completion:${curcontext}:" use-compctl ctl || zmodload -e zsh/compctl
		} && [[ "$ctl" != (no|false|0|off) ]]
	then
		local opt
		opt=() 
		[[ "$ctl" = *first* ]] && opt=(-T) 
		[[ "$ctl" = *default* ]] && opt=("$opt[@]" -D) 
		compcall "$opt[@]" || return 0
	fi
	_files "$@" && return 0
	if [[ -o magicequalsubst && "$PREFIX" = *\=* ]]
	then
		compstate[parameter]="${PREFIX%%\=*}" 
		compset -P 1 '*='
		_value "$@"
	else
		return 1
	fi
}
_defaults () {
	# undefined
	builtin autoload -XUz
}
_delimiters () {
	# undefined
	builtin autoload -XUz
}
_describe () {
	# undefined
	builtin autoload -XUz
}
_description () {
	local name gropt nopt xopt format gname hidden hide match opts tag sort
	opts=() 
	gropt=(-J) 
	xopt=(-X) 
	nopt=() 
	zparseopts -K -D -a nopt 1 2 V=gropt J=gropt x=xopt
	3="${${3##[[:blank:]]#}%%[[:blank:]]#}" 
	[[ -n "$3" ]] && _lastdescr=("$_lastdescr[@]" "$3") 
	zstyle -s ":completion:${curcontext}:$1" group-name gname && [[ -z "$gname" ]] && gname="$1" 
	_setup "$1" "${gname:--default-}"
	name="$2" 
	zstyle -s ":completion:${curcontext}:$1" format format || zstyle -s ":completion:${curcontext}:descriptions" format format
	if zstyle -s ":completion:${curcontext}:$1" hidden hidden && [[ "$hidden" = (all|yes|true|1|on) ]]
	then
		[[ "$hidden" = all ]] && format='' 
		opts=(-n) 
	fi
	zstyle -s ":completion:${curcontext}:$1" matcher match && opts=($opts -M "$match") 
	[[ -n "$_matcher" ]] && opts=($opts -M "$_matcher") 
	if {
			zstyle -s ":completion:${curcontext}:$1" sort sort || zstyle -s ":completion:${curcontext}:" sort sort
		} && [[ "$gropt" = -J && $sort != menu ]]
	then
		if [[ "$sort" = (yes|true|1|on) ]]
		then
			gropt=(-J) 
		else
			gropt=(-V) 
		fi
	fi
	if [[ -z "$_comp_no_ignore" ]]
	then
		zstyle -a ":completion:${curcontext}:$1" ignored-patterns _comp_ignore || _comp_ignore=() 
		if zstyle -s ":completion:${curcontext}:$1" ignore-line hidden
		then
			local -a qwords
			qwords=(${words//(#m)[\[\]()\\*?#<>~\^\|]/\\$MATCH}) 
			case "$hidden" in
				(true | yes | on | 1) _comp_ignore+=($qwords)  ;;
				(current) _comp_ignore+=($qwords[CURRENT])  ;;
				(current-shown) [[ "$compstate[old_list]" = *shown* ]] && _comp_ignore+=($qwords[CURRENT])  ;;
				(other) _comp_ignore+=($qwords[1,CURRENT-1] $qwords[CURRENT+1,-1])  ;;
			esac
		fi
		(( $#_comp_ignore )) && opts=(-F _comp_ignore $opts) 
	else
		_comp_ignore=() 
	fi
	tag="$1" 
	shift 2
	if [[ -z "$1" && $# -eq 1 ]]
	then
		format= 
	elif [[ -n "$format" ]]
	then
		zformat -f format "$format" "d:$1" "${(@)argv[2,-1]}"
	fi
	if [[ -n "$gname" ]]
	then
		if [[ -n "$format" ]]
		then
			set -A "$name" "$opts[@]" "$nopt[@]" "$gropt" "$gname" "$xopt" "$format"
		else
			set -A "$name" "$opts[@]" "$nopt[@]" "$gropt" "$gname"
		fi
	else
		if [[ -n "$format" ]]
		then
			set -A "$name" "$opts[@]" "$nopt[@]" "$gropt" -default- "$xopt" "$format"
		else
			set -A "$name" "$opts[@]" "$nopt[@]" "$gropt" -default-
		fi
	fi
	if ! (( ${funcstack[2,-1][(I)_description]} ))
	then
		local fakestyle descr
		for fakestyle in fake fake-always
		do
			zstyle -a ":completion:${curcontext}:$tag" $fakestyle match || continue
			descr=("${(@M)match:#*[^\\]:*}") 
			opts=("${(@P)name}") 
			if [[ $fakestyle = fake-always && $opts[1,2] = "-F _comp_ignore" ]]
			then
				shift 2 opts
			fi
			compadd "${(@)opts}" - "${(@)${(@)match:#*[^\\]:*}:s/\\:/:/}"
			(( $#descr )) && _describe -t "$tag" '' descr "${(@)opts}"
		done
	fi
	return 0
}
_devtodo () {
	# undefined
	builtin autoload -XUz
}
_df () {
	# undefined
	builtin autoload -XUz
}
_dhclient () {
	# undefined
	builtin autoload -XUz
}
_dhcpinfo () {
	# undefined
	builtin autoload -XUz
}
_dict () {
	# undefined
	builtin autoload -XUz
}
_dict_words () {
	# undefined
	builtin autoload -XUz
}
_diff () {
	# undefined
	builtin autoload -XUz
}
_diff_options () {
	# undefined
	builtin autoload -XUz
}
_diffstat () {
	# undefined
	builtin autoload -XUz
}
_dig () {
	# undefined
	builtin autoload -XUz
}
_dir_list () {
	# undefined
	builtin autoload -XUz
}
_directories () {
	# undefined
	builtin autoload -XUz
}
_directory_stack () {
	setopt localoptions nonomatch
	local expl list lines revlines disp sep
	[[ $PREFIX = [-+]* ]] || return 1
	zstyle -s ":completion:${curcontext}:directory-stack" list-separator sep || sep=-- 
	if zstyle -T ":completion:${curcontext}:directory-stack" verbose
	then
		lines=("${(D)dirstack[@]}") 
		if [[ ( $PREFIX[1] = - && ! -o pushdminus ) || ( $PREFIX[1] = + && -o pushdminus ) ]]
		then
			integer i
			revlines=($lines) 
			for ((i = 1; i <= $#lines; i++ )) do
				lines[$i]="$((i-1)) $sep ${revlines[-$i]##[0-9]#[	 ]#}" 
			done
		else
			for ((i = 1; i <= $#lines; i++ )) do
				lines[$i]="$i $sep ${lines[$i]##[0-9]#[	 ]#}" 
			done
		fi
		list=(${PREFIX[1]}${^lines%% *}) 
		disp=(-ld lines) 
	else
		list=(${PREFIX[1]}{0..${#dirstack}}) 
		disp=() 
	fi
	_wanted -V directory-stack expl 'directory stack' compadd "$@" "$disp[@]" -Q -a list
}
_dirs () {
	# undefined
	builtin autoload -XUz
}
_disable () {
	# undefined
	builtin autoload -XUz
}
_dispatch () {
	local comp pat val name i ret=1 _compskip="$_compskip" 
	local curcontext="$curcontext" service str noskip 
	local -a match mbegin mend
	if [[ "$1" = -s ]]
	then
		noskip=yes 
		shift
	fi
	[[ -z "$noskip" ]] && _compskip= 
	curcontext="${curcontext%:*:*}:${1}:" 
	shift
	if [[ "$_compskip" != (all|*patterns*) ]]
	then
		for str in "$@"
		do
			[[ -n "$str" ]] || continue
			service="${_services[$str]:-$str}" 
			for i in "${(@)_patcomps[(K)$str]}"
			do
				if [[ $i = (#b)"="([^=]#)"="(*) ]]
				then
					service=$match[1] 
					i=$match[2] 
				fi
				eval "$i" && ret=0 
				if [[ "$_compskip" = *patterns* ]]
				then
					break
				elif [[ "$_compskip" = all ]]
				then
					_compskip='' 
					return ret
				fi
			done
		done
	fi
	ret=1 
	for str in "$@"
	do
		[[ -n "$str" ]] || continue
		str=${(Q)str} 
		name="$str" 
		comp="${_comps[$str]}" 
		service="${_services[$str]:-$str}" 
		[[ -z "$comp" ]] || break
	done
	if [[ -n "$comp" && "$name" != "${argv[-1]}" ]]
	then
		_compskip=patterns 
		eval "$comp" && ret=0 
		[[ "$_compskip" = (all|*patterns*) ]] && return ret
	fi
	if [[ "$_compskip" != (all|*patterns*) ]]
	then
		for str
		do
			[[ -n "$str" ]] || continue
			service="${_services[$str]:-$str}" 
			for i in "${(@)_postpatcomps[(K)$str]}"
			do
				_compskip=default 
				eval "$i" && ret=0 
				if [[ "$_compskip" = *patterns* ]]
				then
					break
				elif [[ "$_compskip" = all ]]
				then
					_compskip='' 
					return ret
				fi
			done
		done
	fi
	[[ "$name" = "${argv[-1]}" && -n "$comp" && "$_compskip" != (all|*default*) ]] && service="${_services[$name]:-$name}"  && eval "$comp" && ret=0 
	_compskip='' 
	return ret
}
_django () {
	# undefined
	builtin autoload -XUz
}
_dladm () {
	# undefined
	builtin autoload -XUz
}
_dlocate () {
	# undefined
	builtin autoload -XUz
}
_dmesg () {
	# undefined
	builtin autoload -XUz
}
_dmidecode () {
	# undefined
	builtin autoload -XUz
}
_dnf () {
	# undefined
	builtin autoload -XUz
}
_doas () {
	# undefined
	builtin autoload -XUz
}
_domains () {
	# undefined
	builtin autoload -XUz
}
_dpatch-edit-patch () {
	# undefined
	builtin autoload -XUz
}
_dpkg () {
	# undefined
	builtin autoload -XUz
}
_dpkg-buildpackage () {
	# undefined
	builtin autoload -XUz
}
_dpkg-cross () {
	# undefined
	builtin autoload -XUz
}
_dpkg-repack () {
	# undefined
	builtin autoload -XUz
}
_dpkg_source () {
	# undefined
	builtin autoload -XUz
}
_dput () {
	# undefined
	builtin autoload -XUz
}
_dsh () {
	# undefined
	builtin autoload -XUz
}
_dtrace () {
	# undefined
	builtin autoload -XUz
}
_du () {
	# undefined
	builtin autoload -XUz
}
_dumpadm () {
	# undefined
	builtin autoload -XUz
}
_dumper () {
	# undefined
	builtin autoload -XUz
}
_dupload () {
	# undefined
	builtin autoload -XUz
}
_dvi () {
	# undefined
	builtin autoload -XUz
}
_dynamic_directory_name () {
	# undefined
	builtin autoload -XUz
}
_ecasound () {
	# undefined
	builtin autoload -XUz
}
_echotc () {
	# undefined
	builtin autoload -XUz
}
_echoti () {
	# undefined
	builtin autoload -XUz
}
_elfdump () {
	# undefined
	builtin autoload -XUz
}
_elinks () {
	# undefined
	builtin autoload -XUz
}
_elm () {
	# undefined
	builtin autoload -XUz
}
_email_addresses () {
	# undefined
	builtin autoload -XUz
}
_emulate () {
	# undefined
	builtin autoload -XUz
}
_enable () {
	# undefined
	builtin autoload -XUz
}
_enscript () {
	# undefined
	builtin autoload -XUz
}
_entr () {
	# undefined
	builtin autoload -XUz
}
_env () {
	# undefined
	builtin autoload -XUz
}
_equal () {
	# undefined
	builtin autoload -XUz
}
_espeak () {
	# undefined
	builtin autoload -XUz
}
_etags () {
	# undefined
	builtin autoload -XUz
}
_ethtool () {
	# undefined
	builtin autoload -XUz
}
_evince () {
	# undefined
	builtin autoload -XUz
}
_expand () {
	# undefined
	builtin autoload -XUz
}
_expand_alias () {
	# undefined
	builtin autoload -XUz
}
_expand_word () {
	# undefined
	builtin autoload -XUz
}
_extensions () {
	# undefined
	builtin autoload -XUz
}
_external_pwds () {
	# undefined
	builtin autoload -XUz
}
_fakeroot () {
	# undefined
	builtin autoload -XUz
}
_fc () {
	# undefined
	builtin autoload -XUz
}
_feh () {
	# undefined
	builtin autoload -XUz
}
_fetch () {
	# undefined
	builtin autoload -XUz
}
_fetchmail () {
	# undefined
	builtin autoload -XUz
}
_ffmpeg () {
	# undefined
	builtin autoload -XUz
}
_figlet () {
	# undefined
	builtin autoload -XUz
}
_file_descriptors () {
	# undefined
	builtin autoload -XUz
}
_file_systems () {
	# undefined
	builtin autoload -XUz
}
_files () {
	local -a match mbegin mend
	local ret=1 
	if _have_glob_qual $PREFIX
	then
		compset -p ${#match[1]}
		compset -S '[^\)\|\~]#(|\))'
		if [[ $_comp_caller_options[extendedglob] == on ]] && compset -P '\#'
		then
			_globflags && ret=0 
		else
			if [[ $_comp_caller_options[extendedglob] == on ]]
			then
				_describe -t globflags "glob flag" '(\#:introduce\ glob\ flag)' -Q -S '' && ret=0 
			fi
			_globquals && ret=0 
		fi
		return ret
	fi
	local opts tmp glob pat pats expl tag i def descr end ign tried
	local type sdef ignvars ignvar prepath oprefix rfiles rfile
	zparseopts -a opts '/=tmp' 'f=tmp' 'g+:-=tmp' q n 1 2 P: S: r: R: W: X+: M+: F: J+: V+:
	type="${(@j::M)${(@)tmp#-}#?}" 
	if (( $tmp[(I)-g*] ))
	then
		glob="${${${(@)${(@M)tmp:#-g*}#-g}##[[:blank:]]#}%%[[:blank:]]#}" 
		[[ "$glob" = *[^\\][[:blank:]]* ]] && glob="{${glob//(#b)([^\\])[[:blank:]]##/${match[1]},}}" 
		[[ "$glob" = (#b)(*\()([^\|\~]##\)) && $match[2] != \#q* ]] && glob="${match[1]}#q${match[2]}" 
	elif [[ $type = */* ]]
	then
		glob="*(#q-/)" 
	fi
	tmp=$opts[(I)-F] 
	if (( tmp ))
	then
		ignvars=($=opts[tmp+1]) 
		if [[ $ignvars = _comp_ignore ]]
		then
			ign=($_comp_ignore) 
		else
			ign=() 
			for ignvar in $ignvars
			do
				ign+=(${(P)ignvar}) 
			done
			opts[tmp+1]=_comp_ignore 
		fi
	else
		ign=() 
	fi
	if zstyle -a ":completion:${curcontext}:" file-patterns tmp
	then
		pats=() 
		for i in ${tmp//\%p/${${glob:-\*}//:/\\:}}
		do
			if [[ $i = *[^\\]:* ]]
			then
				pats+=(" $i ") 
			else
				pats+=(" ${i}:files ") 
			fi
		done
	elif zstyle -t ":completion:${curcontext}:" list-dirs-first
	then
		pats=(" *(-/):directories:directory ${${glob:-*}//:/\\:}(#q^-/):globbed-files" '*:all-files') 
	else
		pats=("${${glob:-*}//:/\\:}:globbed-files *(-/):directories" '*:all-files ') 
	fi
	tried=() 
	for def in "$pats[@]"
	do
		eval "def=( ${${def//\\:/\\\\\\:}//(#b)([][()|*?^#~<>])/\\${match[1]}} )"
		tmp="${(@M)def#*[^\\]:}" 
		(( $tried[(I)${(q)tmp}] )) && continue
		tried=("$tried[@]" "$tmp") 
		for sdef in "$def[@]"
		do
			tag="${${sdef#*[^\\]:}%%:*}" 
			pat="${${sdef%%:${tag}*}//\\:/:}" 
			if [[ "$sdef" = *:${tag}:* ]]
			then
				descr="${(Q)sdef#*:${tag}:}" 
			else
				if (( $opts[(I)-X] ))
				then
					descr= 
				else
					descr=file 
				fi
				end=yes 
			fi
			_tags "$tag"
			while _tags
			do
				_comp_ignore=() 
				while _next_label "$tag" expl "$descr"
				do
					_comp_ignore=($_comp_ignore $ign) 
					if [[ -n "$end" ]]
					then
						if _path_files -g "$pat" "$opts[@]" "$expl[@]"
						then
							ret=0 
						elif [[ $PREFIX$SUFFIX != */* ]] && zstyle -a ":completion:${curcontext}:$tag" recursive-files rfiles
						then
							local subtree
							for rfile in $rfiles
							do
								if [[ $PWD/ = ${~rfile} ]]
								then
									if [[ -z $subtree ]]
									then
										subtree=(**/*(/)) 
									fi
									for prepath in $subtree
									do
										oprefix=$PREFIX 
										PREFIX=$prepath/$PREFIX 
										_path_files -g "$pat" "$opts[@]" "$expl[@]" && ret=0 
										PREFIX=$oprefix 
									done
									break
								fi
							done
						fi
					else
						_path_files "$expl[@]" -g "$pat" "$opts[@]" && ret=0 
					fi
				done
				(( ret )) || break
			done
			[[ "$pat" = '*' ]] && return ret
		done
		(( ret )) || return 0
	done
	return 1
}
_find () {
	# undefined
	builtin autoload -XUz
}
_find_net_interfaces () {
	# undefined
	builtin autoload -XUz
}
_finger () {
	# undefined
	builtin autoload -XUz
}
_fink () {
	# undefined
	builtin autoload -XUz
}
_first () {
	
}
_flasher () {
	# undefined
	builtin autoload -XUz
}
_flex () {
	# undefined
	builtin autoload -XUz
}
_floppy () {
	# undefined
	builtin autoload -XUz
}
_flowadm () {
	# undefined
	builtin autoload -XUz
}
_fmadm () {
	# undefined
	builtin autoload -XUz
}
_fmt () {
	# undefined
	builtin autoload -XUz
}
_fortune () {
	# undefined
	builtin autoload -XUz
}
_freebsd-update () {
	# undefined
	builtin autoload -XUz
}
_fsh () {
	# undefined
	builtin autoload -XUz
}
_fstat () {
	# undefined
	builtin autoload -XUz
}
_functions () {
	# undefined
	builtin autoload -XUz
}
_fuse_arguments () {
	# undefined
	builtin autoload -XUz
}
_fuse_values () {
	# undefined
	builtin autoload -XUz
}
_fuser () {
	# undefined
	builtin autoload -XUz
}
_fusermount () {
	# undefined
	builtin autoload -XUz
}
_fw_update () {
	# undefined
	builtin autoload -XUz
}
_gcc () {
	# undefined
	builtin autoload -XUz
}
_gcore () {
	# undefined
	builtin autoload -XUz
}
_gdb () {
	# undefined
	builtin autoload -XUz
}
_generic () {
	# undefined
	builtin autoload -XUz
}
_genisoimage () {
	# undefined
	builtin autoload -XUz
}
_getclip () {
	# undefined
	builtin autoload -XUz
}
_getconf () {
	# undefined
	builtin autoload -XUz
}
_getent () {
	# undefined
	builtin autoload -XUz
}
_getfacl () {
	# undefined
	builtin autoload -XUz
}
_getmail () {
	# undefined
	builtin autoload -XUz
}
_git () {
	# undefined
	builtin autoload -XUz
}
_git-buildpackage () {
	# undefined
	builtin autoload -XUz
}
_git_log_prettily () {
	if ! [ -z $1 ]
	then
		git log --pretty=$1
	fi
}
_global () {
	# undefined
	builtin autoload -XUz
}
_global_tags () {
	# undefined
	builtin autoload -XUz
}
_globflags () {
	# undefined
	builtin autoload -XUz
}
_globqual_delims () {
	# undefined
	builtin autoload -XUz
}
_globquals () {
	# undefined
	builtin autoload -XUz
}
_gnome-gv () {
	# undefined
	builtin autoload -XUz
}
_gnu_generic () {
	# undefined
	builtin autoload -XUz
}
_gnupod () {
	# undefined
	builtin autoload -XUz
}
_gnutls () {
	# undefined
	builtin autoload -XUz
}
_go () {
	# undefined
	builtin autoload -XUz
}
_gpasswd () {
	# undefined
	builtin autoload -XUz
}
_gpg () {
	# undefined
	builtin autoload -XUz
}
_gphoto2 () {
	# undefined
	builtin autoload -XUz
}
_gprof () {
	# undefined
	builtin autoload -XUz
}
_gqview () {
	# undefined
	builtin autoload -XUz
}
_gradle () {
	# undefined
	builtin autoload -XUz
}
_graphicsmagick () {
	# undefined
	builtin autoload -XUz
}
_grep () {
	# undefined
	builtin autoload -XUz
}
_grep-excuses () {
	# undefined
	builtin autoload -XUz
}
_groff () {
	# undefined
	builtin autoload -XUz
}
_groups () {
	# undefined
	builtin autoload -XUz
}
_growisofs () {
	# undefined
	builtin autoload -XUz
}
_gs () {
	# undefined
	builtin autoload -XUz
}
_gsettings () {
	# undefined
	builtin autoload -XUz
}
_gstat () {
	# undefined
	builtin autoload -XUz
}
_guard () {
	# undefined
	builtin autoload -XUz
}
_guilt () {
	# undefined
	builtin autoload -XUz
}
_gv () {
	# undefined
	builtin autoload -XUz
}
_gzip () {
	# undefined
	builtin autoload -XUz
}
_hash () {
	# undefined
	builtin autoload -XUz
}
_have_glob_qual () {
	local complete
	[[ $2 = complete ]] && complete=")" 
	[[ -z $compstate[quote] && ( ( $_comp_caller_options[bareglobqual] == on && $1 = (#b)(((*[^\\\$]|)(\\\\)#)\()([^\)\|\~]#)$complete && ${#match[1]} -gt 1 ) || ( $_comp_caller_options[extendedglob] == on && $1 = (#b)(((*[^\\\$]|)(\\\\)#)"(#q")([^\)]#)$complete ) ) ]]
}
_hdiutil () {
	# undefined
	builtin autoload -XUz
}
_head () {
	# undefined
	builtin autoload -XUz
}
_hg () {
	# undefined
	builtin autoload -XUz
}
_history () {
	# undefined
	builtin autoload -XUz
}
_history_complete_word () {
	# undefined
	builtin autoload -XUz
}
_history_modifiers () {
	# undefined
	builtin autoload -XUz
}
_hostnamectl () {
	# undefined
	builtin autoload -XUz
}
_hosts () {
	# undefined
	builtin autoload -XUz
}
_htop () {
	# undefined
	builtin autoload -XUz
}
_hwinfo () {
	# undefined
	builtin autoload -XUz
}
_iconv () {
	# undefined
	builtin autoload -XUz
}
_iconvconfig () {
	# undefined
	builtin autoload -XUz
}
_id () {
	# undefined
	builtin autoload -XUz
}
_ifconfig () {
	# undefined
	builtin autoload -XUz
}
_iftop () {
	# undefined
	builtin autoload -XUz
}
_ignored () {
	[[ _matcher_num -gt 1 || $compstate[ignored] -eq 0 ]] && return 1
	local comp
	integer ind
	if ! zstyle -a ":completion:${curcontext}:" completer comp
	then
		comp=("${(@)_completers[1,_completer_num-1]}") 
		ind=${comp[(I)_ignored(|:*)]} 
		(( ind )) && comp=("${(@)comp[ind,-1]}") 
	fi
	local _comp_no_ignore=yes tmp expl _completer _completer_num _matcher _c_matcher _matchers _matcher_num 
	_completer_num=1 
	for tmp in "$comp[@]"
	do
		if [[ "$tmp" = *:-* ]]
		then
			_completer="${${tmp%:*}[2,-1]//_/-}${tmp#*:}" 
			tmp="${tmp%:*}" 
		elif [[ $tmp = *:* ]]
		then
			_completer="${tmp#*:}" 
			tmp="${tmp%:*}" 
		else
			_completer="${tmp[2,-1]//_/-}" 
		fi
		curcontext="${curcontext/:[^:]#:/:${_completer}:}" 
		zstyle -a ":completion:${curcontext}:" matcher-list _matchers || _matchers=('') 
		_matcher_num=1 
		_matcher='' 
		for _c_matcher in "$_matchers[@]"
		do
			if [[ "$_c_matcher" == +* ]]
			then
				_matcher="$_matcher $_c_matcher[2,-1]" 
			else
				_matcher="$_c_matcher" 
			fi
			if [[ "$tmp" != _ignored ]] && "$tmp"
			then
				if zstyle -s ":completion:${curcontext}:" single-ignored tmp && [[ $compstate[old_list] != shown && $compstate[nmatches] -eq 1 ]]
				then
					case "$tmp" in
						(show) compstate[insert]='' compstate[list]='list force' tmp=''  ;;
						(menu) compstate[insert]=menu 
							_description original expl original
							compadd "$expl[@]" -S '' - "$PREFIX$SUFFIX" ;;
					esac
				fi
				return 0
			fi
			(( _matcher_num++ ))
		done
		(( _completer_num++ ))
	done
	return 1
}
_imagemagick () {
	# undefined
	builtin autoload -XUz
}
_in_vared () {
	# undefined
	builtin autoload -XUz
}
_inetadm () {
	# undefined
	builtin autoload -XUz
}
_init_d () {
	# undefined
	builtin autoload -XUz
}
_initctl () {
	# undefined
	builtin autoload -XUz
}
_invoke-rc.d () {
	# undefined
	builtin autoload -XUz
}
_ionice () {
	# undefined
	builtin autoload -XUz
}
_iostat () {
	# undefined
	builtin autoload -XUz
}
_ip () {
	# undefined
	builtin autoload -XUz
}
_ipadm () {
	# undefined
	builtin autoload -XUz
}
_ipset () {
	# undefined
	builtin autoload -XUz
}
_iptables () {
	# undefined
	builtin autoload -XUz
}
_irssi () {
	# undefined
	builtin autoload -XUz
}
_ispell () {
	# undefined
	builtin autoload -XUz
}
_iwconfig () {
	# undefined
	builtin autoload -XUz
}
_jails () {
	# undefined
	builtin autoload -XUz
}
_java () {
	# undefined
	builtin autoload -XUz
}
_java_class () {
	# undefined
	builtin autoload -XUz
}
_jexec () {
	# undefined
	builtin autoload -XUz
}
_jls () {
	# undefined
	builtin autoload -XUz
}
_jobs () {
	local expl disp jobs job jids pfx='%' desc how expls sep 
	if [[ "$1" = -t ]]
	then
		zstyle -T ":completion:${curcontext}:jobs" prefix-needed && [[ "$PREFIX" != %* && compstate[nmatches] -ne 0 ]] && return 1
		shift
	fi
	zstyle -t ":completion:${curcontext}:jobs" prefix-hidden && pfx='' 
	zstyle -T ":completion:${curcontext}:jobs" verbose && desc=yes 
	if [[ "$1" = -r ]]
	then
		jids=("${(@k)jobstates[(R)running*]}") 
		shift
		expls='running job' 
	elif [[ "$1" = -s ]]
	then
		jids=("${(@k)jobstates[(R)suspended*]}") 
		shift
		expls='suspended job' 
	else
		[[ "$1" = - ]] && shift
		jids=("${(@k)jobtexts}") 
		expls=job 
	fi
	if [[ -n "$desc" ]]
	then
		disp=() 
		zstyle -s ":completion:${curcontext}:jobs" list-separator sep || sep=-- 
		for job in "$jids[@]"
		do
			[[ -n "$desc" ]] && disp=("$disp[@]" "${pfx}${(r:2:: :)job} $sep ${(r:COLUMNS-8:: :)jobtexts[$job]}") 
		done
	fi
	zstyle -s ":completion:${curcontext}:jobs" numbers how
	if [[ "$how" = (yes|true|on|1) ]]
	then
		jobs=("$jids[@]") 
	else
		local texts i text str tmp num max=0 
		texts=("$jobtexts[@]") 
		jobs=() 
		for i in "$jids[@]"
		do
			text="$jobtexts[$i]" 
			str="${text%% *}" 
			if [[ "$text" = *\ * ]]
			then
				text="${text#* }" 
			else
				text="" 
			fi
			tmp=("${(@M)texts:#${str}*}") 
			num=1 
			while [[ -n "$text" && $#tmp -ge 2 ]]
			do
				str="${str} ${text%% *}" 
				if [[ "$text" = *\ * ]]
				then
					text="${text#* }" 
				else
					text="" 
				fi
				tmp=("${(@M)texts:#${str}*}") 
				(( num++ ))
			done
			[[ num -gt max ]] && max="$num" 
			jobs=("$jobs[@]" "$str") 
		done
		if [[ "$how" = [0-9]## && max -gt how ]]
		then
			jobs=("$jids[@]") 
		else
			[[ -z "$pfx" && -n "$desc" ]] && disp=("${(@)disp#%}") 
		fi
	fi
	if [[ -n "$desc" ]]
	then
		_wanted jobs expl "$expls" compadd "$@" -ld disp - "%$^jobs[@]"
	else
		_wanted jobs expl "$expls" compadd "$@" - "%$^jobs[@]"
	fi
}
_jobs_bg () {
	# undefined
	builtin autoload -XUz
}
_jobs_builtin () {
	# undefined
	builtin autoload -XUz
}
_jobs_fg () {
	# undefined
	builtin autoload -XUz
}
_joe () {
	# undefined
	builtin autoload -XUz
}
_join () {
	# undefined
	builtin autoload -XUz
}
_jot () {
	# undefined
	builtin autoload -XUz
}
_journalctl () {
	# undefined
	builtin autoload -XUz
}
_kernel-install () {
	# undefined
	builtin autoload -XUz
}
_kfmclient () {
	# undefined
	builtin autoload -XUz
}
_kill () {
	# undefined
	builtin autoload -XUz
}
_killall () {
	# undefined
	builtin autoload -XUz
}
_kld () {
	# undefined
	builtin autoload -XUz
}
_knock () {
	# undefined
	builtin autoload -XUz
}
_kpartx () {
	# undefined
	builtin autoload -XUz
}
_kvno () {
	# undefined
	builtin autoload -XUz
}
_last () {
	# undefined
	builtin autoload -XUz
}
_ld_debug () {
	# undefined
	builtin autoload -XUz
}
_ldd () {
	# undefined
	builtin autoload -XUz
}
_less () {
	# undefined
	builtin autoload -XUz
}
_lha () {
	# undefined
	builtin autoload -XUz
}
_libvirt () {
	# undefined
	builtin autoload -XUz
}
_lighttpd () {
	# undefined
	builtin autoload -XUz
}
_limit () {
	# undefined
	builtin autoload -XUz
}
_limits () {
	# undefined
	builtin autoload -XUz
}
_links () {
	# undefined
	builtin autoload -XUz
}
_lintian () {
	# undefined
	builtin autoload -XUz
}
_list () {
	# undefined
	builtin autoload -XUz
}
_list_files () {
	local stat f elt what dir
	local -a stylevals
	integer ok
	listfiles=() 
	listopts=() 
	zstyle -a ":completion:${curcontext}:" file-list stylevals || return 1
	case $WIDGETSTYLE in
		(*complete*) what=insert  ;;
		(*) what=list  ;;
	esac
	for elt in $stylevals
	do
		case $elt in
			(*($what|all|true|1|yes)*=<->) (( ${(P)#1} <= ${elt##*=} )) && (( ok = 1 ))
				break ;;
			([^=]#($what|all|true|1|yes)[^=]#) (( ok = 1 ))
				break ;;
		esac
	done
	(( ok )) || return 1
	zmodload -F zsh/stat b:zstat 2> /dev/null || return 1
	dir=${2:+$2/} 
	dir=${(Q)dir} 
	for f in ${(PQ)1}
	do
		if [[ ! -e "$dir$f" ]]
		then
			listfiles+=("$dir$f") 
			continue
		fi
		zstat -s -H stat -F "%b %e %H:%M" - "$dir$f" > /dev/null 2>&1
		listfiles+=("$stat[mode] ${(l:3:)stat[nlink]} ${(r:8:)stat[uid]}  ${(r:8:)stat[gid]} ${(l:8:)stat[size]} $stat[mtime] $f") 
	done
	(( ${#listfiles} )) && listopts=(-d listfiles -l -o) 
	return 0
}
_lldb () {
	# undefined
	builtin autoload -XUz
}
_ln () {
	# undefined
	builtin autoload -XUz
}
_loadkeys () {
	# undefined
	builtin autoload -XUz
}
_locale () {
	# undefined
	builtin autoload -XUz
}
_localectl () {
	# undefined
	builtin autoload -XUz
}
_localedef () {
	# undefined
	builtin autoload -XUz
}
_locales () {
	# undefined
	builtin autoload -XUz
}
_locate () {
	# undefined
	builtin autoload -XUz
}
_logical_volumes () {
	# undefined
	builtin autoload -XUz
}
_loginctl () {
	# undefined
	builtin autoload -XUz
}
_look () {
	# undefined
	builtin autoload -XUz
}
_losetup () {
	# undefined
	builtin autoload -XUz
}
_lp () {
	# undefined
	builtin autoload -XUz
}
_ls () {
	# undefined
	builtin autoload -XUz
}
_lsblk () {
	# undefined
	builtin autoload -XUz
}
_lscfg () {
	# undefined
	builtin autoload -XUz
}
_lsdev () {
	# undefined
	builtin autoload -XUz
}
_lslv () {
	# undefined
	builtin autoload -XUz
}
_lsof () {
	# undefined
	builtin autoload -XUz
}
_lspv () {
	# undefined
	builtin autoload -XUz
}
_lsusb () {
	# undefined
	builtin autoload -XUz
}
_lsvg () {
	# undefined
	builtin autoload -XUz
}
_ltrace () {
	# undefined
	builtin autoload -XUz
}
_lynx () {
	# undefined
	builtin autoload -XUz
}
_lzop () {
	# undefined
	builtin autoload -XUz
}
_mac_applications () {
	# undefined
	builtin autoload -XUz
}
_mac_files_for_application () {
	# undefined
	builtin autoload -XUz
}
_madison () {
	# undefined
	builtin autoload -XUz
}
_mail () {
	# undefined
	builtin autoload -XUz
}
_mailboxes () {
	# undefined
	builtin autoload -XUz
}
_main_complete () {
	local IFS=$' \t\n\0' 
	eval "$_comp_setup"
	local func funcs ret=1 tmp _compskip format nm call match min max i num _completers _completer _completer_num curtag _comp_force_list _matchers _matcher _c_matcher _matcher_num _comp_tags _comp_mesg mesg str context state state_descr line opt_args val_args curcontext="$curcontext" _last_nmatches=-1 _last_menu_style _def_menu_style _menu_style sel _tags_level=0 _saved_exact="${compstate[exact]}" _saved_lastprompt="${compstate[last_prompt]}" _saved_list="${compstate[list]}" _saved_insert="${compstate[insert]}" _saved_colors="$ZLS_COLORS" _saved_colors_set=${+ZLS_COLORS} _ambiguous_color='' 
	local _comp_priv_prefix
	unset _comp_priv_prefix
	local -a precommands
	typeset -U _lastdescr _comp_ignore _comp_colors
	{
		[[ -z "$curcontext" ]] && curcontext=::: 
		zstyle -s ":completion:${curcontext}:" insert-tab tmp || tmp=yes 
		if [[ ( "$tmp" = *pending(|[[:blank:]]*) && PENDING -gt 0 ) || ( "$tmp" = *pending=(#b)([0-9]##)(|[[:blank:]]*) && PENDING -ge $match[1] ) ]]
		then
			compstate[insert]=tab 
			return 0
		fi
		if [[ "$compstate[insert]" = tab* ]]
		then
			if [[ "$tmp" = (|*[[:blank:]])(yes|true|on|1)(|[[:blank:]]*) ]]
			then
				if [[ "$curcontext" != :* || -z "$compstate[vared]" ]] || zstyle -t ":completion:vared${curcontext}:" insert-tab
				then
					return 0
				fi
			fi
			compstate[insert]="${compstate[insert]//tab /}" 
		fi
		if [[ "$compstate[pattern_match]" = "*" && "$_lastcomp[unambiguous]" = "$PREFIX" && -n "$_lastcomp[unambiguous_cursor]" ]]
		then
			integer upos="$_lastcomp[unambiguous_cursor]" 
			SUFFIX="$PREFIX[upos,-1]$SUFFIX" 
			PREFIX="$PREFIX[1,upos-1]" 
		fi
		if [[ -z "$compstate[quote]" ]]
		then
			if [[ -o equals ]] && compset -P 1 '='
			then
				compstate[context]=equal 
			elif [[ "$PREFIX" != */* && "$PREFIX[1]" = '~' ]]
			then
				compset -p 1
				compstate[context]=tilde 
			fi
		fi
		_setup default
		_def_menu_style=("$_last_menu_style[@]") 
		_last_menu_style=() 
		if zstyle -s ":completion:${curcontext}:default" list-prompt tmp
		then
			LISTPROMPT="$tmp" 
			zmodload -i zsh/complist
		fi
		if zstyle -s ":completion:${curcontext}:default" select-prompt tmp
		then
			MENUPROMPT="$tmp" 
			zmodload -i zsh/complist
		fi
		if zstyle -s ":completion:${curcontext}:default" select-scroll tmp
		then
			MENUSCROLL="$tmp" 
			zmodload -i zsh/complist
		fi
		if (( $# ))
		then
			if [[ "$1" = - ]]
			then
				if [[ $# -lt 3 ]]
				then
					_completers=() 
				else
					_completers=("$2") 
					call=yes 
				fi
			else
				_completers=("$@") 
			fi
		else
			zstyle -a ":completion:${curcontext}:" completer _completers || _completers=(_complete _ignored) 
		fi
		_completer_num=1 
		integer SECONDS=0 
		TRAPINT () {
			zle -M "Killed by signal in ${funcstack[2]} after ${SECONDS}s"
			zle -R
			return 130
		}
		TRAPQUIT () {
			zle -M "Killed by signal in ${funcstack[2]} after ${SECONDS}s"
			zle -R
			return 131
		}
		funcs=("$compprefuncs[@]") 
		compprefuncs=() 
		for func in "$funcs[@]"
		do
			"$func"
		done
		for tmp in "$_completers[@]"
		do
			if [[ -n "$call" ]]
			then
				_completer="${tmp}" 
			elif [[ "$tmp" = *:-* ]]
			then
				_completer="${${tmp%:*}[2,-1]//_/-}${tmp#*:}" 
				tmp="${tmp%:*}" 
			elif [[ $tmp = *:* ]]
			then
				_completer="${tmp#*:}" 
				tmp="${tmp%:*}" 
			else
				_completer="${tmp[2,-1]//_/-}" 
			fi
			curcontext="${curcontext/:[^:]#:/:${_completer}:}" 
			zstyle -t ":completion:${curcontext}:" show-completer && zle -R "Trying completion for :completion:${curcontext}"
			zstyle -a ":completion:${curcontext}:" matcher-list _matchers || _matchers=('') 
			_matcher_num=1 
			_matcher='' 
			for _c_matcher in "$_matchers[@]"
			do
				if [[ "$_c_matcher" == +* ]]
				then
					_matcher="$_matcher $_c_matcher[2,-1]" 
				else
					_matcher="$_c_matcher" 
				fi
				_comp_mesg= 
				if [[ -n "$call" ]]
				then
					if "${(@)argv[3,-1]}"
					then
						ret=0 
						break 2
					fi
				elif "$tmp"
				then
					ret=0 
					break 2
				fi
				(( _matcher_num++ ))
			done
			[[ -n "$_comp_mesg" ]] && break
			(( _completer_num++ ))
		done
		curcontext="${curcontext/:[^:]#:/::}" 
		if [[ $compstate[old_list] = keep ]]
		then
			nm=$_lastcomp[nmatches] 
		else
			nm=$compstate[nmatches] 
		fi
		if [[ $compstate[old_list] = keep || nm -gt 1 ]]
		then
			[[ _last_nmatches -ge 0 && _last_nmatches -ne nm ]] && _menu_style=("$_last_menu_style[@]" "$_menu_style[@]") 
			tmp=$(( compstate[list_lines] + BUFFERLINES + 1 )) 
			_menu_style=("$_menu_style[@]" "$_def_menu_style[@]") 
			if [[ "$compstate[list]" = *list && tmp -gt LINES && ( -n "$_menu_style[(r)select=long-list]" || -n "$_menu_style[(r)(yes|true|on|1)=long-list]" ) ]]
			then
				compstate[insert]=menu 
			elif [[ "$compstate[insert]" = "$_saved_insert" ]]
			then
				if [[ -n "$compstate[insert]" && -n "$_menu_style[(r)(yes|true|1|on)=long]" && tmp -gt LINES ]]
				then
					compstate[insert]=menu 
				else
					sel=("${(@M)_menu_style:#(yes|true|1|on)*}") 
					if (( $#sel ))
					then
						min=9999999 
						for i in "$sel[@]"
						do
							if [[ "$i" = *\=[0-9]* ]]
							then
								num="${i#*\=}" 
								[[ num -lt 0 ]] && num=0 
							elif [[ "$i" != *\=* ]]
							then
								num=0 
							else
								num=9999999 
							fi
							[[ num -lt min ]] && min="$num" 
							(( min )) || break
						done
					fi
					sel=("${(@M)_menu_style:#(no|false|0|off)*}") 
					if (( $#sel ))
					then
						max=9999999 
						for i in "$sel[@]"
						do
							if [[ "$i" = *\=[0-9]* ]]
							then
								num="${i#*\=}" 
								[[ num -lt 0 ]] && num=0 
							elif [[ "$i" != *\=* ]]
							then
								num=0 
							else
								num=9999999 
							fi
							[[ num -lt max ]] && max="$num" 
							(( max )) || break
						done
					fi
					if [[ ( -n "$min" && nm -ge min && ( -z "$max" || nm -lt max ) ) || ( -n "$_menu_style[(r)auto*]" && "$compstate[insert]" = automenu ) ]]
					then
						compstate[insert]=menu 
					elif [[ -n "$max" && nm -ge max ]]
					then
						compstate[insert]=unambiguous 
					elif [[ -n "$_menu_style[(r)auto*]" && "$compstate[insert]" != automenu ]]
					then
						compstate[insert]=automenu-unambiguous 
					fi
				fi
			fi
			if [[ "$compstate[insert]" = *menu* ]]
			then
				[[ "$MENUSELECT" = 00 ]] && MENUSELECT=0 
				if [[ -n "$_menu_style[(r)no-select*]" ]]
				then
					unset MENUSELECT
				elif [[ -n "$_menu_style[(r)select=long*]" ]]
				then
					if [[ tmp -gt LINES ]]
					then
						zmodload -i zsh/complist
						MENUSELECT=00 
					fi
				fi
				if [[ "$MENUSELECT" != 00 ]]
				then
					sel=("${(@M)_menu_style:#select*}") 
					if (( $#sel ))
					then
						min=9999999 
						for i in "$sel[@]"
						do
							if [[ "$i" = *\=[0-9]* ]]
							then
								num="${i#*\=}" 
								[[ num -lt 0 ]] && num=0 
							elif [[ "$i" != *\=* ]]
							then
								num=0 
							else
								num=9999999 
							fi
							[[ num -lt min ]] && min="$num" 
							(( min )) || break
						done
						zmodload -i zsh/complist
						MENUSELECT="$min" 
					else
						unset MENUSELECT
					fi
				fi
				if [[ -n "$MENUSELECT" ]]
				then
					if [[ -n "$_menu_style[(r)interactive*]" ]]
					then
						MENUMODE=interactive 
					elif [[ -n "$_menu_style[(r)search*]" ]]
					then
						if [[ -n "$_menu_style[(r)*backward*]" ]]
						then
							MENUMODE=search-backward 
						else
							MENUMODE=search-forward 
						fi
					else
						unset MENUMODE
					fi
				fi
			fi
		elif [[ nm -lt 1 && -n "$_comp_mesg" ]]
		then
			compstate[insert]='' 
			compstate[list]='list force' 
		elif [[ nm -eq 0 && -z "$_comp_mesg" && $#_lastdescr -ne 0 && $compstate[old_list] != keep ]] && zstyle -s ":completion:${curcontext}:warnings" format format
		then
			compstate[list]='list force' 
			compstate[insert]='' 
			tmp=("\`${(@)^_lastdescr:#}'") 
			case $#tmp in
				(1) str="$tmp[1]"  ;;
				(2) str="$tmp[1] or $tmp[2]"  ;;
				(*) str="${(j:, :)tmp[1,-2]}, or $tmp[-1]"  ;;
			esac
			_setup warnings
			zformat -f mesg "$format" "d:$str" "D:${(F)${(@)_lastdescr:#}}"
			compadd -x "$mesg"
		fi
		if [[ -n "$_ambiguous_color" ]]
		then
			local toquote='[=\(\)\|~^?*[\]#<>]' 
			local prefix=${${compstate[unambiguous]}[1,${compstate[unambiguous_cursor]}-1]} 
			[[ -n $prefix ]] && _comp_colors+=("=(#i)${prefix[1,-2]//?/(}${prefix[1,-2]//(#m)?/${MATCH/$~toquote/\\$MATCH}|)}${prefix[-1]//(#m)$~toquote/\\$MATCH}(#b)(?|)*==$_ambiguous_color") 
		fi
		[[ "$_comp_force_list" = always || ( "$_comp_force_list" = ?* && nm -ge _comp_force_list ) ]] && compstate[list]="${compstate[list]//messages} force" 
	} always {
		if [[ "$compstate[old_list]" = keep ]]
		then
			if [[ $_saved_colors_set = 1 ]]
			then
				ZLS_COLORS="$_saved_colors" 
			else
				unset ZLS_COLORS
			fi
		elif (( $#_comp_colors ))
		then
			ZLS_COLORS="${(j.:.)_comp_colors}" 
		else
			unset ZLS_COLORS
		fi
	}
	funcs=("$comppostfuncs[@]") 
	comppostfuncs=() 
	for func in "$funcs[@]"
	do
		"$func"
	done
	_lastcomp=("${(@kv)compstate}") 
	_lastcomp[nmatches]=$nm 
	_lastcomp[completer]="$_completer" 
	_lastcomp[prefix]="$PREFIX" 
	_lastcomp[suffix]="$SUFFIX" 
	_lastcomp[iprefix]="$IPREFIX" 
	_lastcomp[isuffix]="$ISUFFIX" 
	_lastcomp[qiprefix]="$QIPREFIX" 
	_lastcomp[qisuffix]="$QISUFFIX" 
	_lastcomp[tags]="$_comp_tags" 
	return ret
}
_make () {
	# undefined
	builtin autoload -XUz
}
_make-kpkg () {
	# undefined
	builtin autoload -XUz
}
_man () {
	# undefined
	builtin autoload -XUz
}
_match () {
	# undefined
	builtin autoload -XUz
}
_math () {
	# undefined
	builtin autoload -XUz
}
_math_params () {
	# undefined
	builtin autoload -XUz
}
_matlab () {
	# undefined
	builtin autoload -XUz
}
_md5sum () {
	# undefined
	builtin autoload -XUz
}
_mdadm () {
	# undefined
	builtin autoload -XUz
}
_members () {
	# undefined
	builtin autoload -XUz
}
_mencal () {
	# undefined
	builtin autoload -XUz
}
_menu () {
	# undefined
	builtin autoload -XUz
}
_mere () {
	# undefined
	builtin autoload -XUz
}
_mergechanges () {
	# undefined
	builtin autoload -XUz
}
_message () {
	# undefined
	builtin autoload -XUz
}
_metaflac () {
	# undefined
	builtin autoload -XUz
}
_mh () {
	# undefined
	builtin autoload -XUz
}
_mii-tool () {
	# undefined
	builtin autoload -XUz
}
_mime_types () {
	# undefined
	builtin autoload -XUz
}
_mixerctl () {
	# undefined
	builtin autoload -XUz
}
_mkdir () {
	# undefined
	builtin autoload -XUz
}
_mkshortcut () {
	# undefined
	builtin autoload -XUz
}
_mkzsh () {
	# undefined
	builtin autoload -XUz
}
_module () {
	# undefined
	builtin autoload -XUz
}
_module-assistant () {
	# undefined
	builtin autoload -XUz
}
_module_math_func () {
	# undefined
	builtin autoload -XUz
}
_modutils () {
	# undefined
	builtin autoload -XUz
}
_mondo () {
	# undefined
	builtin autoload -XUz
}
_monotone () {
	# undefined
	builtin autoload -XUz
}
_moosic () {
	# undefined
	builtin autoload -XUz
}
_mosh () {
	# undefined
	builtin autoload -XUz
}
_most_recent_file () {
	# undefined
	builtin autoload -XUz
}
_mount () {
	# undefined
	builtin autoload -XUz
}
_mozilla () {
	# undefined
	builtin autoload -XUz
}
_mpc () {
	# undefined
	builtin autoload -XUz
}
_mplayer () {
	# undefined
	builtin autoload -XUz
}
_mt () {
	# undefined
	builtin autoload -XUz
}
_mtools () {
	# undefined
	builtin autoload -XUz
}
_mtr () {
	# undefined
	builtin autoload -XUz
}
_multi_parts () {
	# undefined
	builtin autoload -XUz
}
_mutt () {
	# undefined
	builtin autoload -XUz
}
_my_accounts () {
	# undefined
	builtin autoload -XUz
}
_mysql_utils () {
	# undefined
	builtin autoload -XUz
}
_mysqldiff () {
	# undefined
	builtin autoload -XUz
}
_nautilus () {
	# undefined
	builtin autoload -XUz
}
_ncftp () {
	# undefined
	builtin autoload -XUz
}
_nedit () {
	# undefined
	builtin autoload -XUz
}
_net_interfaces () {
	# undefined
	builtin autoload -XUz
}
_netcat () {
	# undefined
	builtin autoload -XUz
}
_netscape () {
	# undefined
	builtin autoload -XUz
}
_netstat () {
	# undefined
	builtin autoload -XUz
}
_networkctl () {
	# undefined
	builtin autoload -XUz
}
_newsgroups () {
	# undefined
	builtin autoload -XUz
}
_next_label () {
	local __gopt __descr __spec
	__gopt=() 
	zparseopts -D -a __gopt 1 2 V J x
	if comptags -A "$1" curtag __spec
	then
		(( $#funcstack > _tags_level )) && _comp_tags="${_comp_tags% * }" 
		_tags_level=$#funcstack 
		_comp_tags="$_comp_tags $__spec " 
		if [[ "$curtag" = *[^\\]:* ]]
		then
			zformat -f __descr "${curtag#*:}" "d:$3"
			_description "$__gopt[@]" "${curtag%:*}" "$2" "$__descr"
			curtag="${curtag%:*}" 
			set -A $2 "${(P@)2}" "${(@)argv[4,-1]}"
		else
			_description "$__gopt[@]" "$curtag" "$2" "$3"
			set -A $2 "${(@)argv[4,-1]}" "${(P@)2}"
		fi
		return 0
	fi
	return 1
}
_next_tags () {
	# undefined
	builtin autoload -XUz
}
_ngrep () {
	# undefined
	builtin autoload -XUz
}
_nice () {
	# undefined
	builtin autoload -XUz
}
_nkf () {
	# undefined
	builtin autoload -XUz
}
_nl () {
	# undefined
	builtin autoload -XUz
}
_nm () {
	# undefined
	builtin autoload -XUz
}
_nmap () {
	# undefined
	builtin autoload -XUz
}
_nmcli () {
	# undefined
	builtin autoload -XUz
}
_normal () {
	local _comp_command1 _comp_command2 _comp_command skip
	if [[ "$1" = -s ]]
	then
		skip=(-s) 
	else
		skip=() 
		_compskip='' 
	fi
	if [[ -o BANG_HIST && ( ( $words[CURRENT] = \!*: && -z $compstate[quote] ) || ( $words[CURRENT] = \"\!*: && $compstate[all_quotes] = \" ) ) ]]
	then
		PREFIX=${PREFIX//\\!/!} 
		compset -P '*:'
		_history_modifiers h
		return
	fi
	if [[ CURRENT -eq 1 ]]
	then
		curcontext="${curcontext%:*:*}:-command-:" 
		comp="$_comps[-command-]" 
		[[ -n "$comp" ]] && eval "$comp" && return
		return 1
	fi
	_set_command
	_dispatch "$skip[@]" "$_comp_command" "$_comp_command1" "$_comp_command2" -default-
}
_nothing () {
	# undefined
	builtin autoload -XUz
}
_notmuch () {
	# undefined
	builtin autoload -XUz
}
_npm () {
	# undefined
	builtin autoload -XUz
}
_nslookup () {
	# undefined
	builtin autoload -XUz
}
_objdump () {
	# undefined
	builtin autoload -XUz
}
_object_classes () {
	# undefined
	builtin autoload -XUz
}
_object_files () {
	# undefined
	builtin autoload -XUz
}
_od () {
	# undefined
	builtin autoload -XUz
}
_okular () {
	# undefined
	builtin autoload -XUz
}
_oldlist () {
	# undefined
	builtin autoload -XUz
}
_omz () {
	local -a cmds subcmds
	cmds=('changelog:Print the changelog' 'help:Usage information' 'plugin:Manage plugins' 'pr:Manage Oh My Zsh Pull Requests' 'reload:Reload the current zsh session' 'theme:Manage themes' 'update:Update Oh My Zsh' 'version:Show the version') 
	if (( CURRENT == 2 ))
	then
		_describe 'command' cmds
	elif (( CURRENT == 3 ))
	then
		case "$words[2]" in
			(changelog) local -a refs
				refs=("${(@f)$(builtin cd -q "$ZSH"; command git for-each-ref --format="%(refname:short):%(subject)" refs/heads refs/tags)}") 
				_describe 'command' refs ;;
			(plugin) subcmds=('disable:Disable plugin(s)' 'enable:Enable plugin(s)' 'info:Get plugin information' 'list:List plugins' 'load:Load plugin(s)') 
				_describe 'command' subcmds ;;
			(pr) subcmds=('clean:Delete all Pull Request branches' 'test:Test a Pull Request') 
				_describe 'command' subcmds ;;
			(theme) subcmds=('list:List themes' 'set:Set a theme in your .zshrc file' 'use:Load a theme') 
				_describe 'command' subcmds ;;
		esac
	elif (( CURRENT == 4 ))
	then
		case "${words[2]}::${words[3]}" in
			(plugin::(disable|enable|load)) local -aU valid_plugins
				if [[ "${words[3]}" = disable ]]
				then
					valid_plugins=($plugins) 
				else
					valid_plugins=("$ZSH"/plugins/*/{_*,*.plugin.zsh}(-.N:h:t) "$ZSH_CUSTOM"/plugins/*/{_*,*.plugin.zsh}(-.N:h:t)) 
					[[ "${words[3]}" = enable ]] && valid_plugins=(${valid_plugins:|plugins}) 
				fi
				_describe 'plugin' valid_plugins ;;
			(plugin::info) local -aU plugins
				plugins=("$ZSH"/plugins/*/{_*,*.plugin.zsh}(-.N:h:t) "$ZSH_CUSTOM"/plugins/*/{_*,*.plugin.zsh}(-.N:h:t)) 
				_describe 'plugin' plugins ;;
			(theme::(set|use)) local -aU themes
				themes=("$ZSH"/themes/*.zsh-theme(-.N:t:r) "$ZSH_CUSTOM"/**/*.zsh-theme(-.N:r:gs:"$ZSH_CUSTOM"/themes/:::gs:"$ZSH_CUSTOM"/:::)) 
				_describe 'theme' themes ;;
		esac
	elif (( CURRENT > 4 ))
	then
		case "${words[2]}::${words[3]}" in
			(plugin::(enable|disable|load)) local -aU valid_plugins
				if [[ "${words[3]}" = disable ]]
				then
					valid_plugins=($plugins) 
				else
					valid_plugins=("$ZSH"/plugins/*/{_*,*.plugin.zsh}(-.N:h:t) "$ZSH_CUSTOM"/plugins/*/{_*,*.plugin.zsh}(-.N:h:t)) 
					[[ "${words[3]}" = enable ]] && valid_plugins=(${valid_plugins:|plugins}) 
				fi
				local -a args
				args=(${words[4,$(( CURRENT - 1))]}) 
				valid_plugins=(${valid_plugins:|args}) 
				_describe 'plugin' valid_plugins ;;
		esac
	fi
	return 0
}
_omz::changelog () {
	local version=${1:-HEAD} format=${3:-"--text"} 
	if (
			builtin cd -q "$ZSH"
			! command git show-ref --verify refs/heads/$version && ! command git show-ref --verify refs/tags/$version && ! command git rev-parse --verify "${version}^{commit}"
		) &> /dev/null
	then
		cat >&2 <<EOF
Usage: ${(j: :)${(s.::.)0#_}} [version]

NOTE: <version> must be a valid branch, tag or commit.
EOF
		return 1
	fi
	"$ZSH/tools/changelog.sh" "$version" "${2:-}" "$format"
}
_omz::confirm () {
	if [[ -n "$1" ]]
	then
		_omz::log prompt "$1" "${${functrace[1]#_}%:*}"
	fi
	read -r -k 1
	if [[ "$REPLY" != $'\n' ]]
	then
		echo
	fi
}
_omz::help () {
	cat >&2 <<EOF
Usage: omz <command> [options]

Available commands:

  help                Print this help message
  changelog           Print the changelog
  plugin <command>    Manage plugins
  pr     <command>    Manage Oh My Zsh Pull Requests
  reload              Reload the current zsh session
  theme  <command>    Manage themes
  update              Update Oh My Zsh
  version             Show the version

EOF
}
_omz::log () {
	setopt localoptions nopromptsubst
	local logtype=$1 
	local logname=${3:-${${functrace[1]#_}%:*}} 
	if [[ $logtype = debug && -z $_OMZ_DEBUG ]]
	then
		return
	fi
	case "$logtype" in
		(prompt) print -Pn "%S%F{blue}$logname%f%s: $2" ;;
		(debug) print -P "%F{white}$logname%f: $2" ;;
		(info) print -P "%F{green}$logname%f: $2" ;;
		(warn) print -P "%S%F{yellow}$logname%f%s: $2" ;;
		(error) print -P "%S%F{red}$logname%f%s: $2" ;;
	esac >&2
}
_omz::plugin () {
	(( $# > 0 && $+functions[$0::$1] )) || {
		cat >&2 <<EOF
Usage: ${(j: :)${(s.::.)0#_}} <command> [options]

Available commands:

  disable <plugin> Disable plugin(s)
  enable <plugin>  Enable plugin(s)
  info <plugin>    Get information of a plugin
  list             List all available Oh My Zsh plugins
  load <plugin>    Load plugin(s)

EOF
		return 1
	}
	local command="$1" 
	shift
	$0::$command "$@"
}
_omz::plugin::disable () {
	if [[ -z "$1" ]]
	then
		echo "Usage: ${(j: :)${(s.::.)0#_}} <plugin> [...]" >&2
		return 1
	fi
	local -a dis_plugins
	for plugin in "$@"
	do
		if [[ ${plugins[(Ie)$plugin]} -eq 0 ]]
		then
			_omz::log warn "plugin '$plugin' is not enabled."
			continue
		fi
		dis_plugins+=("$plugin") 
	done
	if [[ ${#dis_plugins} -eq 0 ]]
	then
		return 1
	fi
	local awk_subst_plugins="  gsub(/\s+(${(j:|:)dis_plugins})/, \"\") # with spaces before
  gsub(/(${(j:|:)dis_plugins})\s+/, \"\") # with spaces after
  gsub(/\((${(j:|:)dis_plugins})\)/, \"\") # without spaces (only plugin)
" 
	local awk_script="
# if plugins=() is in oneline form, substitute disabled plugins and go to next line
/^\s*plugins=\([^#]+\).*\$/ {
  $awk_subst_plugins
  print \$0
  next
}

# if plugins=() is in multiline form, enable multi flag and disable plugins if they're there
/^\s*plugins=\(/ {
  multi=1
  $awk_subst_plugins
  print \$0
  next
}

# if multi flag is enabled and we find a valid closing parenthesis, remove plugins and disable multi flag
multi == 1 && /^[^#]*\)/ {
  multi=0
  $awk_subst_plugins
  print \$0
  next
}

multi == 1 && length(\$0) > 0 {
  $awk_subst_plugins
  if (length(\$0) > 0) print \$0
  next
}

{ print \$0 }
" 
	local zdot="${ZDOTDIR:-$HOME}" 
	awk "$awk_script" "$zdot/.zshrc" > "$zdot/.zshrc.new" && command mv -f "$zdot/.zshrc" "$zdot/.zshrc.bck" && command mv -f "$zdot/.zshrc.new" "$zdot/.zshrc"
	[[ $? -eq 0 ]] || {
		local ret=$? 
		_omz::log error "error disabling plugins."
		return $ret
	}
	if ! command zsh -n "$zdot/.zshrc"
	then
		_omz::log error "broken syntax in '"${zdot/#$HOME/\~}/.zshrc"'. Rolling back changes..."
		command mv -f "$zdot/.zshrc" "$zdot/.zshrc.new"
		command mv -f "$zdot/.zshrc.bck" "$zdot/.zshrc"
		return 1
	fi
	_omz::log info "plugins disabled: ${(j:, :)dis_plugins}."
	[[ ! -o interactive ]] || _omz::reload
}
_omz::plugin::enable () {
	if [[ -z "$1" ]]
	then
		echo "Usage: ${(j: :)${(s.::.)0#_}} <plugin> [...]" >&2
		return 1
	fi
	local -a add_plugins
	for plugin in "$@"
	do
		if [[ ${plugins[(Ie)$plugin]} -ne 0 ]]
		then
			_omz::log warn "plugin '$plugin' is already enabled."
			continue
		fi
		add_plugins+=("$plugin") 
	done
	if [[ ${#add_plugins} -eq 0 ]]
	then
		return 1
	fi
	local awk_script="
# if plugins=() is in oneline form, substitute ) with new plugins and go to the next line
/^\s*plugins=\([^#]+\).*\$/ {
  sub(/\)/, \" $add_plugins&\")
  print \$0
  next
}

# if plugins=() is in multiline form, enable multi flag
/^\s*plugins=\(/ {
  multi=1
}

# if multi flag is enabled and we find a valid closing parenthesis,
# add new plugins and disable multi flag
multi == 1 && /^[^#]*\)/ {
  multi=0
  sub(/\)/, \" $add_plugins&\")
  print \$0
  next
}

{ print \$0 }
" 
	local zdot="${ZDOTDIR:-$HOME}" 
	awk "$awk_script" "$zdot/.zshrc" > "$zdot/.zshrc.new" && command mv -f "$zdot/.zshrc" "$zdot/.zshrc.bck" && command mv -f "$zdot/.zshrc.new" "$zdot/.zshrc"
	[[ $? -eq 0 ]] || {
		local ret=$? 
		_omz::log error "error enabling plugins."
		return $ret
	}
	if ! command zsh -n "$zdot/.zshrc"
	then
		_omz::log error "broken syntax in '"${zdot/#$HOME/\~}/.zshrc"'. Rolling back changes..."
		command mv -f "$zdot/.zshrc" "$zdot/.zshrc.new"
		command mv -f "$zdot/.zshrc.bck" "$zdot/.zshrc"
		return 1
	fi
	_omz::log info "plugins enabled: ${(j:, :)add_plugins}."
	[[ ! -o interactive ]] || _omz::reload
}
_omz::plugin::info () {
	if [[ -z "$1" ]]
	then
		echo "Usage: ${(j: :)${(s.::.)0#_}} <plugin>" >&2
		return 1
	fi
	local readme
	for readme in "$ZSH_CUSTOM/plugins/$1/README.md" "$ZSH/plugins/$1/README.md"
	do
		if [[ -f "$readme" ]]
		then
			(( ${+commands[less]} )) && less "$readme" || cat "$readme"
			return 0
		fi
	done
	if [[ -d "$ZSH_CUSTOM/plugins/$1" || -d "$ZSH/plugins/$1" ]]
	then
		_omz::log error "the '$1' plugin doesn't have a README file"
	else
		_omz::log error "'$1' plugin not found"
	fi
	return 1
}
_omz::plugin::list () {
	local -a custom_plugins builtin_plugins
	custom_plugins=("$ZSH_CUSTOM"/plugins/*(-/N:t)) 
	builtin_plugins=("$ZSH"/plugins/*(-/N:t)) 
	if [[ ! -t 1 ]]
	then
		print -l ${(q-)custom_plugins} ${(q-)builtin_plugins}
		return
	fi
	if (( ${#custom_plugins} ))
	then
		print -P "%U%BCustom plugins%b%u:"
		print -l ${(q-)custom_plugins} | column -x
	fi
	if (( ${#builtin_plugins} ))
	then
		(( ${#custom_plugins} )) && echo
		print -P "%U%BBuilt-in plugins%b%u:"
		print -l ${(q-)builtin_plugins} | column -x
	fi
}
_omz::plugin::load () {
	if [[ -z "$1" ]]
	then
		echo "Usage: ${(j: :)${(s.::.)0#_}} <plugin> [...]" >&2
		return 1
	fi
	local plugin base has_completion=0 
	for plugin in "$@"
	do
		if [[ -d "$ZSH_CUSTOM/plugins/$plugin" ]]
		then
			base="$ZSH_CUSTOM/plugins/$plugin" 
		elif [[ -d "$ZSH/plugins/$plugin" ]]
		then
			base="$ZSH/plugins/$plugin" 
		else
			_omz::log warn "plugin '$plugin' not found"
			continue
		fi
		if [[ ! -f "$base/_$plugin" && ! -f "$base/$plugin.plugin.zsh" ]]
		then
			_omz::log warn "'$plugin' is not a valid plugin"
			continue
		elif (( ! ${fpath[(Ie)$base]} ))
		then
			fpath=("$base" $fpath) 
		fi
		local -a comp_files
		comp_files=($base/_*(N)) 
		has_completion=$(( $#comp_files > 0 )) 
		if [[ -f "$base/$plugin.plugin.zsh" ]]
		then
			source "$base/$plugin.plugin.zsh"
		fi
	done
	if (( has_completion ))
	then
		compinit -D -d "$_comp_dumpfile"
	fi
}
_omz::pr () {
	(( $# > 0 && $+functions[$0::$1] )) || {
		cat >&2 <<EOF
Usage: ${(j: :)${(s.::.)0#_}} <command> [options]

Available commands:

  clean                       Delete all PR branches (ohmyzsh/pull-*)
  test <PR_number_or_URL>     Fetch PR #NUMBER and rebase against master

EOF
		return 1
	}
	local command="$1" 
	shift
	$0::$command "$@"
}
_omz::pr::clean () {
	(
		set -e
		builtin cd -q "$ZSH"
		local fmt branches
		fmt="%(color:bold blue)%(align:18,right)%(refname:short)%(end)%(color:reset) %(color:dim bold red)%(objectname:short)%(color:reset) %(color:yellow)%(contents:subject)" 
		branches="$(command git for-each-ref --sort=-committerdate --color --format="$fmt" "refs/heads/ohmyzsh/pull-*")" 
		if [[ -z "$branches" ]]
		then
			_omz::log info "there are no Pull Request branches to remove."
			return
		fi
		echo "$branches\n"
		_omz::confirm "do you want remove these Pull Request branches? [Y/n] "
		[[ "$REPLY" != [yY$'\n'] ]] && return
		_omz::log info "removing all Oh My Zsh Pull Request branches..."
		command git branch --list 'ohmyzsh/pull-*' | while read branch
		do
			command git branch -D "$branch"
		done
	)
}
_omz::pr::test () {
	if [[ "$1" = https://* ]]
	then
		1="${1:t}" 
	fi
	if ! [[ -n "$1" && "$1" =~ ^[[:digit:]]+$ ]]
	then
		echo "Usage: ${(j: :)${(s.::.)0#_}} <PR_NUMBER_or_URL>" >&2
		return 1
	fi
	local branch
	branch=$(builtin cd -q "$ZSH"; git symbolic-ref --short HEAD)  || {
		_omz::log error "error when getting the current git branch. Aborting..."
		return 1
	}
	(
		set -e
		builtin cd -q "$ZSH"
		command git remote -v | while read remote url _
		do
			case "$url" in
				(https://github.com/ohmyzsh/ohmyzsh(|.git)) found=1 
					break ;;
				(git@github.com:ohmyzsh/ohmyzsh(|.git)) found=1 
					break ;;
			esac
		done
		(( $found )) || {
			_omz::log error "could not found the ohmyzsh git remote. Aborting..."
			return 1
		}
		_omz::log info "fetching PR #$1 to ohmyzsh/pull-$1..."
		command git fetch -f "$remote" refs/pull/$1/head:ohmyzsh/pull-$1 || {
			_omz::log error "error when trying to fetch PR #$1."
			return 1
		}
		_omz::log info "rebasing PR #$1..."
		local ret gpgsign
		{
			gpgsign=$(command git config --local commit.gpgsign 2>/dev/null)  || ret=$? 
			[[ $ret -ne 129 ]] || gpgsign=$(command git config commit.gpgsign 2>/dev/null) 
			command git config commit.gpgsign false
			command git rebase master ohmyzsh/pull-$1 || {
				command git rebase --abort &> /dev/null
				_omz::log warn "could not rebase PR #$1 on top of master."
				_omz::log warn "you might not see the latest stable changes."
				_omz::log info "run \`zsh\` to test the changes."
				return 1
			}
		} always {
			case "$gpgsign" in
				("") command git config --unset commit.gpgsign ;;
				(*) command git config commit.gpgsign "$gpgsign" ;;
			esac
		}
		_omz::log info "fetch of PR #${1} successful."
	)
	[[ $? -eq 0 ]] || return 1
	_omz::log info "running \`zsh\` to test the changes. Run \`exit\` to go back."
	command zsh -l
	_omz::confirm "do you want to go back to the previous branch? [Y/n] "
	[[ "$REPLY" != [yY$'\n'] ]] && return
	(
		set -e
		builtin cd -q "$ZSH"
		command git checkout "$branch" -- || {
			_omz::log error "could not go back to the previous branch ('$branch')."
			return 1
		}
	)
}
_omz::reload () {
	command rm -f $_comp_dumpfile $ZSH_COMPDUMP
	local zsh="${ZSH_ARGZERO:-${functrace[-1]%:*}}" 
	[[ "$zsh" = -* || -o login ]] && exec -l "${zsh#-}" || exec "$zsh"
}
_omz::theme () {
	(( $# > 0 && $+functions[$0::$1] )) || {
		cat >&2 <<EOF
Usage: ${(j: :)${(s.::.)0#_}} <command> [options]

Available commands:

  list            List all available Oh My Zsh themes
  set <theme>     Set a theme in your .zshrc file
  use <theme>     Load a theme

EOF
		return 1
	}
	local command="$1" 
	shift
	$0::$command "$@"
}
_omz::theme::list () {
	local -a custom_themes builtin_themes
	custom_themes=("$ZSH_CUSTOM"/**/*.zsh-theme(-.N:r:gs:"$ZSH_CUSTOM"/themes/:::gs:"$ZSH_CUSTOM"/:::)) 
	builtin_themes=("$ZSH"/themes/*.zsh-theme(-.N:t:r)) 
	if [[ ! -t 1 ]]
	then
		print -l ${(q-)custom_themes} ${(q-)builtin_themes}
		return
	fi
	if [[ -n "$ZSH_THEME" ]]
	then
		print -Pn "%U%BCurrent theme%b%u: "
		[[ $ZSH_THEME = random ]] && echo "$RANDOM_THEME (via random)" || echo "$ZSH_THEME"
		echo
	fi
	if (( ${#custom_themes} ))
	then
		print -P "%U%BCustom themes%b%u:"
		print -l ${(q-)custom_themes} | column -x
		echo
	fi
	print -P "%U%BBuilt-in themes%b%u:"
	print -l ${(q-)builtin_themes} | column -x
}
_omz::theme::set () {
	if [[ -z "$1" ]]
	then
		echo "Usage: ${(j: :)${(s.::.)0#_}} <theme>" >&2
		return 1
	fi
	if [[ ! -f "$ZSH_CUSTOM/$1.zsh-theme" ]] && [[ ! -f "$ZSH_CUSTOM/themes/$1.zsh-theme" ]] && [[ ! -f "$ZSH/themes/$1.zsh-theme" ]]
	then
		_omz::log error "%B$1%b theme not found"
		return 1
	fi
	local awk_script='
!set && /^\s*ZSH_THEME=[^#]+.*$/ {
  set=1
  sub(/^\s*ZSH_THEME=[^#]+.*$/, "ZSH_THEME=\"'$1'\" # set by `omz`")
  print $0
  next
}

{ print $0 }

END {
  # If no ZSH_THEME= line was found, return an error
  if (!set) exit 1
}
' 
	local zdot="${ZDOTDIR:-$HOME}" 
	awk "$awk_script" "$zdot/.zshrc" > "$zdot/.zshrc.new" || {
		cat <<EOF
ZSH_THEME="$1" # set by \`omz\`

EOF
		cat "$zdot/.zshrc"
	} > "$zdot/.zshrc.new" && command mv -f "$zdot/.zshrc" "$zdot/.zshrc.bck" && command mv -f "$zdot/.zshrc.new" "$zdot/.zshrc"
	[[ $? -eq 0 ]] || {
		local ret=$? 
		_omz::log error "error setting theme."
		return $ret
	}
	if ! command zsh -n "$zdot/.zshrc"
	then
		_omz::log error "broken syntax in '"${zdot/#$HOME/\~}/.zshrc"'. Rolling back changes..."
		command mv -f "$zdot/.zshrc" "$zdot/.zshrc.new"
		command mv -f "$zdot/.zshrc.bck" "$zdot/.zshrc"
		return 1
	fi
	_omz::log info "'$1' theme set correctly."
	[[ ! -o interactive ]] || _omz::reload
}
_omz::theme::use () {
	if [[ -z "$1" ]]
	then
		echo "Usage: ${(j: :)${(s.::.)0#_}} <theme>" >&2
		return 1
	fi
	if [[ -f "$ZSH_CUSTOM/$1.zsh-theme" ]]
	then
		source "$ZSH_CUSTOM/$1.zsh-theme"
	elif [[ -f "$ZSH_CUSTOM/themes/$1.zsh-theme" ]]
	then
		source "$ZSH_CUSTOM/themes/$1.zsh-theme"
	elif [[ -f "$ZSH/themes/$1.zsh-theme" ]]
	then
		source "$ZSH/themes/$1.zsh-theme"
	else
		_omz::log error "%B$1%b theme not found"
		return 1
	fi
	ZSH_THEME="$1" 
	[[ $1 = random ]] || unset RANDOM_THEME
}
_omz::update () {
	local last_commit=$(builtin cd -q "$ZSH"; git rev-parse HEAD) 
	if [[ "$1" != --unattended ]]
	then
		ZSH="$ZSH" command zsh -f "$ZSH/tools/upgrade.sh" --interactive || return $?
	else
		ZSH="$ZSH" command zsh -f "$ZSH/tools/upgrade.sh" || return $?
	fi
	zmodload zsh/datetime
	echo "LAST_EPOCH=$(( EPOCHSECONDS / 60 / 60 / 24 ))" >| "${ZSH_CACHE_DIR}/.zsh-update"
	command rm -rf "$ZSH/log/update.lock"
	if [[ "$1" != --unattended && "$(builtin cd -q "$ZSH"; git rev-parse HEAD)" != "$last_commit" ]]
	then
		local zsh="${ZSH_ARGZERO:-${functrace[-1]%:*}}" 
		[[ "$zsh" = -* || -o login ]] && exec -l "${zsh#-}" || exec "$zsh"
	fi
}
_omz::version () {
	(
		builtin cd -q "$ZSH"
		local version
		version=$(command git describe --tags HEAD 2>/dev/null)  || version=$(command git symbolic-ref --quiet --short HEAD 2>/dev/null)  || version=$(command git name-rev --no-undefined --name-only --exclude="remotes/*" HEAD 2>/dev/null)  || version="<detached>" 
		local commit=$(command git rev-parse --short HEAD 2>/dev/null) 
		printf "%s (%s)\n" "$version" "$commit"
	)
}
_omz_diag_dump_check_core_commands () {
	builtin echo "Core command check:"
	local redefined name builtins externals reserved_words
	redefined=() 
	reserved_words=(do done esac then elif else fi for case if while function repeat time until select coproc nocorrect foreach end '!' '[[' '{' '}') 
	builtins=(alias autoload bg bindkey break builtin bye cd chdir command comparguments compcall compctl compdescribe compfiles compgroups compquote comptags comptry compvalues continue dirs disable disown echo echotc echoti emulate enable eval exec exit false fc fg functions getln getopts hash jobs kill let limit log logout noglob popd print printf pushd pushln pwd r read rehash return sched set setopt shift source suspend test times trap true ttyctl type ulimit umask unalias unfunction unhash unlimit unset unsetopt vared wait whence where which zcompile zle zmodload zparseopts zregexparse zstyle) 
	if is-at-least 5.1
	then
		reserved_word+=(declare export integer float local readonly typeset) 
	else
		builtins+=(declare export integer float local readonly typeset) 
	fi
	builtins_fatal=(builtin command local) 
	externals=(zsh) 
	for name in $reserved_words
	do
		if [[ $(builtin whence -w $name) != "$name: reserved" ]]
		then
			builtin echo "reserved word '$name' has been redefined"
			builtin which $name
			redefined+=$name 
		fi
	done
	for name in $builtins
	do
		if [[ $(builtin whence -w $name) != "$name: builtin" ]]
		then
			builtin echo "builtin '$name' has been redefined"
			builtin which $name
			redefined+=$name 
		fi
	done
	for name in $externals
	do
		if [[ $(builtin whence -w $name) != "$name: command" ]]
		then
			builtin echo "command '$name' has been redefined"
			builtin which $name
			redefined+=$name 
		fi
	done
	if [[ -n "$redefined" ]]
	then
		builtin echo "SOME CORE COMMANDS HAVE BEEN REDEFINED: $redefined"
	else
		builtin echo "All core commands are defined normally"
	fi
}
_omz_diag_dump_echo_file_w_header () {
	local file=$1 
	if [[ -f $file || -h $file ]]
	then
		builtin echo "========== $file =========="
		if [[ -h $file ]]
		then
			builtin echo "==========    ( => ${file:A} )   =========="
		fi
		command cat $file
		builtin echo "========== end $file =========="
		builtin echo
	elif [[ -d $file ]]
	then
		builtin echo "File '$file' is a directory"
	elif [[ ! -e $file ]]
	then
		builtin echo "File '$file' does not exist"
	else
		command ls -lad "$file"
	fi
}
_omz_diag_dump_one_big_text () {
	local program programs progfile md5
	builtin echo oh-my-zsh diagnostic dump
	builtin echo
	builtin echo $outfile
	builtin echo
	command date
	command uname -a
	builtin echo OSTYPE=$OSTYPE
	builtin echo ZSH_VERSION=$ZSH_VERSION
	builtin echo User: $USERNAME
	builtin echo umask: $(umask)
	builtin echo
	_omz_diag_dump_os_specific_version
	builtin echo
	programs=(sh zsh ksh bash sed cat grep ls find git posh) 
	local progfile="" extra_str="" sha_str="" 
	for program in $programs
	do
		extra_str="" sha_str="" 
		progfile=$(builtin which $program) 
		if [[ $? == 0 ]]
		then
			if [[ -e $progfile ]]
			then
				if builtin whence shasum &> /dev/null
				then
					sha_str=($(command shasum $progfile)) 
					sha_str=$sha_str[1] 
					extra_str+=" SHA $sha_str" 
				fi
				if [[ -h "$progfile" ]]
				then
					extra_str+=" ( -> ${progfile:A} )" 
				fi
			fi
			builtin printf '%-9s %-20s %s\n' "$program is" "$progfile" "$extra_str"
		else
			builtin echo "$program: not found"
		fi
	done
	builtin echo
	builtin echo Command Versions:
	builtin echo "zsh: $(zsh --version)"
	builtin echo "this zsh session: $ZSH_VERSION"
	builtin echo "bash: $(bash --version | command grep bash)"
	builtin echo "git: $(git --version)"
	builtin echo "grep: $(grep --version)"
	builtin echo
	_omz_diag_dump_check_core_commands || return 1
	builtin echo
	builtin echo Process state:
	builtin echo pwd: $PWD
	if builtin whence pstree &> /dev/null
	then
		builtin echo Process tree for this shell:
		pstree -p $$
	else
		ps -fT
	fi
	builtin set | command grep -a '^\(ZSH\|plugins\|TERM\|LC_\|LANG\|precmd\|chpwd\|preexec\|FPATH\|TTY\|DISPLAY\|PATH\)\|OMZ'
	builtin echo
	builtin echo Exported:
	builtin echo $(builtin export | command sed 's/=.*//')
	builtin echo
	builtin echo Locale:
	command locale
	builtin echo
	builtin echo Zsh configuration:
	builtin echo setopt: $(builtin setopt)
	builtin echo
	builtin echo zstyle:
	builtin zstyle
	builtin echo
	builtin echo 'compaudit output:'
	compaudit
	builtin echo
	builtin echo '$fpath directories:'
	command ls -lad $fpath
	builtin echo
	builtin echo oh-my-zsh installation:
	command ls -ld ~/.z*
	command ls -ld ~/.oh*
	builtin echo
	builtin echo oh-my-zsh git state:
	(
		builtin cd $ZSH && builtin echo "HEAD: $(git rev-parse HEAD)" && git remote -v && git status | command grep "[^[:space:]]"
	)
	if [[ $verbose -ge 1 ]]
	then
		(
			builtin cd $ZSH && git reflog --date=default | command grep pull
		)
	fi
	builtin echo
	if [[ -e $ZSH_CUSTOM ]]
	then
		local custom_dir=$ZSH_CUSTOM 
		if [[ -h $custom_dir ]]
		then
			custom_dir=$(builtin cd $custom_dir && pwd -P) 
		fi
		builtin echo "oh-my-zsh custom dir:"
		builtin echo "   $ZSH_CUSTOM ($custom_dir)"
		(
			builtin cd ${custom_dir:h} && command find ${custom_dir:t} -name .git -prune -o -print
		)
		builtin echo
	fi
	if [[ $verbose -ge 1 ]]
	then
		builtin echo "bindkey:"
		builtin bindkey
		builtin echo
		builtin echo "infocmp:"
		command infocmp -L
		builtin echo
	fi
	local zdotdir=${ZDOTDIR:-$HOME} 
	builtin echo "Zsh configuration files:"
	local cfgfile cfgfiles
	cfgfiles=(/etc/zshenv /etc/zprofile /etc/zshrc /etc/zlogin /etc/zlogout $zdotdir/.zshenv $zdotdir/.zprofile $zdotdir/.zshrc $zdotdir/.zlogin $zdotdir/.zlogout ~/.zsh.pre-oh-my-zsh /etc/bashrc /etc/profile ~/.bashrc ~/.profile ~/.bash_profile ~/.bash_logout) 
	command ls -lad $cfgfiles 2>&1
	builtin echo
	if [[ $verbose -ge 1 ]]
	then
		for cfgfile in $cfgfiles
		do
			_omz_diag_dump_echo_file_w_header $cfgfile
		done
	fi
	builtin echo
	builtin echo "Zsh compdump files:"
	local dumpfile dumpfiles
	command ls -lad $zdotdir/.zcompdump*
	dumpfiles=($zdotdir/.zcompdump*(N)) 
	if [[ $verbose -ge 2 ]]
	then
		for dumpfile in $dumpfiles
		do
			_omz_diag_dump_echo_file_w_header $dumpfile
		done
	fi
}
_omz_diag_dump_os_specific_version () {
	local osname osver version_file version_files
	case "$OSTYPE" in
		(darwin*) osname=$(command sw_vers -productName) 
			osver=$(command sw_vers -productVersion) 
			builtin echo "OS Version: $osname $osver build $(sw_vers -buildVersion)" ;;
		(cygwin) command systeminfo | command head -n 4 | command tail -n 2 ;;
	esac
	if builtin which lsb_release > /dev/null
	then
		builtin echo "OS Release: $(command lsb_release -s -d)"
	fi
	version_files=(/etc/*-release(N) /etc/*-version(N) /etc/*_version(N)) 
	for version_file in $version_files
	do
		builtin echo "$version_file:"
		command cat "$version_file"
		builtin echo
	done
}
_open () {
	# undefined
	builtin autoload -XUz
}
_openstack () {
	# undefined
	builtin autoload -XUz
}
_options () {
	# undefined
	builtin autoload -XUz
}
_options_set () {
	# undefined
	builtin autoload -XUz
}
_options_unset () {
	# undefined
	builtin autoload -XUz
}
_osc () {
	# undefined
	builtin autoload -XUz
}
_other_accounts () {
	# undefined
	builtin autoload -XUz
}
_pack () {
	# undefined
	builtin autoload -XUz
}
_parameter () {
	# undefined
	builtin autoload -XUz
}
_parameters () {
	local expl pattern fakes faked tmp pfilt
	if compset -P '*:'
	then
		_history_modifiers p
		return
	fi
	pattern=(-g \*) 
	zparseopts -D -K -E g:=pattern
	fakes=() 
	faked=() 
	if zstyle -a ":completion:${curcontext}:" fake-parameters tmp
	then
		for i in "$tmp[@]"
		do
			if [[ "$i" = *:* ]]
			then
				faked=("$faked[@]" "$i") 
			else
				fakes=("$fakes[@]" "$i") 
			fi
		done
	fi
	zstyle -t ":completion:${curcontext}:parameters" prefix-needed && [[ $PREFIX != [_.]* ]] && pfilt='[^_.]' 
	_wanted parameters expl parameter compadd "$@" -Q - "${(@M)${(@k)parameters[(R)${pattern[2]}~*local*]}:#${~pfilt}*}" "$fakes[@]" "${(@)${(@M)faked:#${~pattern[2]}}%%:*}"
}
_paste () {
	# undefined
	builtin autoload -XUz
}
_patch () {
	# undefined
	builtin autoload -XUz
}
_patchutils () {
	# undefined
	builtin autoload -XUz
}
_path_commands () {
	local need_desc expl ret=1 
	if zstyle -t ":completion:${curcontext}:" extra-verbose
	then
		local update_policy first
		if [[ $+_command_descriptions -eq 0 ]]
		then
			first=yes 
			typeset -A -g _command_descriptions
		fi
		zstyle -s ":completion:${curcontext}:" cache-policy update_policy
		[[ -z "$update_policy" ]] && zstyle ":completion:${curcontext}:" cache-policy _path_commands_caching_policy
		if (
				[[ -n $first ]] || _cache_invalid command-descriptions
			) && ! _retrieve_cache command-descriptions
		then
			local line
			for line in "${(f)$(_call_program command-descriptions _call_whatis -s 1 -r .\\\*\; _call_whatis -s 6 -r .\\\* 2>/dev/null)}"
			do
				[[ -n ${line:#(#b)([^ ]#) #\([^ ]#\)( #\[[^ ]#\]|)[ -]#(*)} ]] && continue
				[[ -z $match[1] || -z $match[3] || -z ${${match[1]}:#*:*} ]] && continue
				_command_descriptions[$match[1]]=$match[3] 
			done
			_store_cache command-descriptions _command_descriptions
		fi
		(( $#_command_descriptions )) && need_desc=yes 
	fi
	if [[ -n $need_desc ]]
	then
		typeset -a dcmds descs cmds matches
		local desc cmd sep
		compadd "$@" -O matches -k commands
		for cmd in $matches
		do
			desc=$_command_descriptions[$cmd] 
			if [[ -z $desc ]]
			then
				cmds+=$cmd 
			else
				dcmds+=$cmd 
				descs+="$cmd:$desc" 
			fi
		done
		zstyle -s ":completion:${curcontext}:" list-separator sep || sep=-- 
		zformat -a descs " $sep " $descs
		descs=("${(@r:COLUMNS-1:)descs}") 
		_wanted commands expl 'external command' compadd "$@" -ld descs -a dcmds && ret=0 
		_wanted commands expl 'external command' compadd "$@" -a cmds && ret=0 
	else
		_wanted commands expl 'external command' compadd "$@" -k commands && ret=0 
	fi
	if [[ -o path_dirs ]]
	then
		local -a path_dirs
		path_dirs=(${^path}/*(/N:t)) 
		(( ${#path_dirs} )) && _wanted path-dirs expl 'directory in path' compadd "$@" -a path_dirs && ret=0 
		if [[ $PREFIX$SUFFIX = */* ]]
		then
			_wanted commands expl 'external command' _path_files -W path -g '*(*)' && ret=0 
		fi
	fi
	return $ret
}
_path_commands_caching_policy () {
	local file
	local -a oldp dbfiles
	oldp=("$1"(Nmw+1)) 
	(( $#oldp )) && return 0
	dbfiles=(/usr/share/man/index.(bt|db|dir|pag)(N) /usr/man/index.(bt|db|dir|pag)(N) /var/cache/man/index.(bt|db|dir|pag)(N) /var/catman/index.(bt|db|dir|pag)(N) /usr/share/man/*/whatis(N)) 
	for file in $dbfiles
	do
		[[ $file -nt $1 ]] && return 0
	done
	return 1
}
_path_files () {
	local -a match mbegin mend
	if _have_glob_qual $PREFIX
	then
		local ret=1 
		compset -p ${#match[1]}
		compset -S '[^\)\|\~]#(|\))'
		if [[ $_comp_caller_options[extendedglob] == on ]] && compset -P '\#'
		then
			_globflags && ret=0 
		else
			if [[ $_comp_caller_options[extendedglob] == on ]]
			then
				local -a flags
				flags=('#:introduce glob flag') 
				_describe -t globflags "glob flag" flags -Q -S '' && ret=0 
			fi
			_globquals && ret=0 
		fi
		return ret
	fi
	local linepath realpath donepath prepath testpath exppath skips skipped
	local tmp1 tmp2 tmp3 tmp4 i orig eorig pre suf tpre tsuf opre osuf cpre
	local pats haspats ignore pfx pfxsfx sopt gopt opt sdirs ignpar cfopt listsfx
	local nm=$compstate[nmatches] menu matcher mopts sort mid accex fake 
	local listfiles listopts tmpdisp origtmp1 Uopt
	local accept_exact_dirs path_completion
	integer npathcheck
	local -a Mopts
	typeset -U prepaths exppaths
	exppaths=() 
	zparseopts -a mopts 'P:=pfx' 'S:=pfxsfx' 'q=pfxsfx' 'r:=pfxsfx' 'R:=pfxsfx' 'W:=prepaths' 'F:=ignore' 'M+:=matcher' J+: V+: X+: 1 2 n 'f=tmp1' '/=tmp1' 'g+:-=tmp1'
	sopt="-${(@j::M)${(@)tmp1#-}#?}" 
	(( $tmp1[(I)-[/g]*] )) && haspats=yes 
	(( $tmp1[(I)-g*] )) && gopt=yes 
	if (( $tmp1[(I)-/] ))
	then
		pats="${(@)${(@M)tmp1:#-g*}#-g}" 
		pats=('*(-/)' ${${(z):-x $pats}[2,-1]}) 
	else
		pats="${(@)${(@M)tmp1:#-g*}#-g}" 
		pats=(${${(z):-x $pats}[2,-1]}) 
	fi
	pats=("${(@)pats:# #}") 
	if (( $#pfx ))
	then
		compset -P "${(b)pfx[2]}" || pfxsfx=("$pfx[@]" "$pfxsfx[@]") 
	fi
	if (( $#prepaths ))
	then
		tmp1="${prepaths[2]}" 
		if [[ "$tmp1[1]" = '(' ]]
		then
			prepaths=(${^=tmp1[2,-2]%/}/) 
		elif [[ "$tmp1[1]" = '/' ]]
		then
			prepaths=("${tmp1%/}/") 
		else
			prepaths=(${(P)^tmp1%/}/) 
			(( ! $#prepaths )) && prepaths=(${tmp1%/}/) 
		fi
		(( ! $#prepaths )) && prepaths=('') 
	else
		prepaths=('') 
	fi
	if (( $#ignore ))
	then
		if [[ "${ignore[2]}" = \(* ]]
		then
			ignore=(${=ignore[2][2,-2]}) 
		else
			ignore=(${(P)ignore[2]}) 
		fi
	fi
	if [[ "$sopt" = -(f|) ]]
	then
		if [[ -z "$gopt" ]]
		then
			sopt='-f' 
			pats=('*') 
		else
			unset sopt
		fi
	fi
	if (( ! $mopts[(I)-[JVX]] ))
	then
		local expl
		if [[ -z "$gopt" && "$sopt" = -/ ]]
		then
			_description directories expl directory
		else
			_description files expl file
		fi
		tmp1=$expl[(I)-M*] 
		if (( tmp1 ))
		then
			if (( $#matcher ))
			then
				matcher[2]="$matcher[2] $expl[1+tmp1]" 
			else
				matcher=(-M "$expl[1+tmp1]") 
			fi
		fi
		mopts=("$mopts[@]" "$expl[@]") 
	fi
	[[ -z "$_comp_no_ignore" && $#ignore -eq 0 && ( -z $gopt || "$pats" = \ #\*\ # ) && -n $FIGNORE ]] && ignore=("?*${^fignore[@]}") 
	if (( $#ignore ))
	then
		_comp_ignore=("$_comp_ignore[@]" "$ignore[@]") 
		(( $mopts[(I)-F] )) || mopts=("$mopts[@]" -F _comp_ignore) 
	fi
	if [[ $#matcher -eq 0 && -o nocaseglob ]]
	then
		matcher=(-M 'm:{a-zA-Z}={A-Za-z}') 
	fi
	if (( $#matcher ))
	then
		mopts=("$mopts[@]" "$matcher[@]") 
	fi
	if zstyle -s ":completion:${curcontext}:" file-sort tmp1
	then
		case "$tmp1" in
			(*size*) sort=oL  ;;
			(*links*) sort=ol  ;;
			(*(time|date|modi)*) sort=om  ;;
			(*access*) sort=oa  ;;
			(*(inode|change)*) sort=oc  ;;
			(*) sort=on  ;;
		esac
		[[ "$tmp1" = *rev* ]] && sort[1]=O 
		[[ "$tmp1" = *follow* ]] && sort="-${sort}-" 
		if [[ "$sort" = on ]]
		then
			sort= 
		else
			mopts=("${(@)mopts/#-J/-V}") 
			tmp2=() 
			for tmp1 in "$pats[@]"
			do
				if _have_glob_qual "$tmp1" complete
				then
					tmp2+=("${match[1]}#q${sort})(${match[5]})") 
				else
					tmp2+=("${tmp1}(${sort})") 
				fi
			done
			pats=("$tmp2[@]") 
		fi
	fi
	if zstyle -t ":completion:${curcontext}:paths" squeeze-slashes
	then
		skips='((.|..|)/)##' 
	else
		skips='((.|..)/)##' 
	fi
	zstyle -s ":completion:${curcontext}:paths" special-dirs sdirs
	zstyle -t ":completion:${curcontext}:paths" list-suffixes && listsfx=yes 
	[[ "$pats" = ((|*[[:blank:]])\*(|[[:blank:]]*|\([^[:blank:]]##\))|*\([^[:blank:]]#/[^[:blank:]]#\)*) ]] && sopt=$sopt/ 
	zstyle -a ":completion:${curcontext}:paths" accept-exact accex
	zstyle -a ":completion:${curcontext}:" fake-files fake
	zstyle -s ":completion:${curcontext}:" ignore-parents ignpar
	zstyle -t ":completion:${curcontext}:paths" accept-exact-dirs && accept_exact_dirs=1 
	zstyle -T ":completion:${curcontext}:paths" path-completion && path_completion=1 
	if [[ -n "$compstate[pattern_match]" ]]
	then
		if {
				[[ -z "$SUFFIX" ]] && _have_glob_qual "$PREFIX" complete
			} || _have_glob_qual "$SUFFIX" complete
		then
			tmp3=${match[5]} 
			if [[ -n "$SUFFIX" ]]
			then
				SUFFIX=${match[2]} 
			else
				PREFIX=${match[2]} 
			fi
			tmp2=() 
			for tmp1 in "$pats[@]"
			do
				if _have_glob_qual "$tmp1" complete
				then
					tmp2+=("${match[1]}${tmp3}${match[5]})") 
				else
					tmp2+=("${tmp1}(${tmp3})") 
				fi
			done
			pats=("$tmp2[@]") 
		fi
	fi
	pre="$PREFIX" 
	suf="$SUFFIX" 
	opre="$PREFIX" 
	osuf="$SUFFIX" 
	orig="${PREFIX}${SUFFIX}" 
	eorig="$orig" 
	[[ $compstate[insert] = (*menu|[0-9]*) || -n "$_comp_correct" || ( -n "$compstate[pattern_match]" && "${orig#\~}" != (|*[^\\])[][*?#~^\|\<\>]* ) ]] && menu=yes 
	if [[ -n "$_comp_correct" ]]
	then
		cfopt=- 
		Uopt=-U 
	else
		Mopts=(-M "r:|/=* r:|=*") 
	fi
	if [[ "$pre" = [^][*?#^\|\<\>\\]#(\`[^\`]#\`|\$)*/* && "$compstate[quote]" != \' ]]
	then
		linepath="${(M)pre##*\$[^/]##/}" 
		() {
			setopt localoptions nounset
			eval 'realpath=${(e)~linepath}' 2> /dev/null
		}
		[[ -z "$realpath" || "$realpath" = "$linepath" ]] && return 1
		pre="${pre#${linepath}}" 
		i='[^/]' 
		i="${#linepath//$i}" 
		orig="${orig[1,(in:i:)/][1,-2]}" 
		donepath= 
		prepaths=('') 
	elif [[ "$pre[1]" = \~ && "$compstate[quote]" = (|\`) ]]
	then
		linepath="${pre[2,-1]%%/*}" 
		if [[ -z "$linepath" ]]
		then
			realpath="${HOME%/}/" 
		elif [[ "$linepath" = ([-+]|)[0-9]## ]]
		then
			if [[ "$linepath" != [-+]* ]]
			then
				tmp1="$linepath" 
			else
				if [[ "$linepath" = -* ]]
				then
					tmp1=$(( $#dirstack $linepath )) 
				else
					tmp1=$linepath[2,-1] 
				fi
				[[ -o pushdminus ]] && tmp1=$(( $#dirstack - $tmp1 )) 
			fi
			if (( ! tmp1 ))
			then
				realpath=$PWD/ 
			elif [[ tmp1 -le $#dirstack ]]
			then
				realpath=$dirstack[tmp1]/ 
			else
				_message 'not enough directory stack entries'
				return 1
			fi
		elif [[ "$linepath" = [-+] ]]
		then
			realpath=${~:-\~$linepath}/ 
		else
			eval "realpath=~${linepath}/" 2> /dev/null
			if [[ -z "$realpath" ]]
			then
				_message "unknown user \`$linepath'"
				return 1
			fi
		fi
		linepath="~${linepath}/" 
		[[ "$realpath" = "$linepath" ]] && return 1
		pre="${pre#*/}" 
		orig="${orig#*/}" 
		donepath= 
		prepaths=('') 
	else
		linepath= 
		realpath= 
		if zstyle -s ":completion:${curcontext}:" preserve-prefix tmp1 && [[ -n "$tmp1" && "$pre" = (#b)(${~tmp1})* ]]
		then
			pre="$pre[${#match[1]}+1,-1]" 
			orig="$orig[${#match[1]}+1,-1]" 
			donepath="$match[1]" 
			prepaths=('') 
		elif [[ "$pre[1]" = / ]]
		then
			pre="$pre[2,-1]" 
			orig="$orig[2,-1]" 
			donepath='/' 
			prepaths=('') 
		else
			[[ "$pre" = (.|..)/* ]] && prepaths=('') 
			donepath= 
		fi
	fi
	for prepath in "$prepaths[@]"
	do
		skipped= 
		cpre= 
		if [[ ( -n $accept_exact_dirs || -z $path_completion ) && ${pre} = (#b)(*)/([^/]#) ]]
		then
			tmp1=${match[1]} 
			tpre=${match[2]} 
			tmp2=$tmp1 
			tmp1=${tmp1//(#b)\\(?)/$match[1]} 
			tpre=${tpre//(#b)\\([^\\\]\[\^\~\(\)\#\*\?])/$match[1]} 
			tmp3=${donepath//(#b)\\(?)/$match[1]} 
			while true
			do
				if [[ -z $path_completion || -d $prepath$realpath$tmp3$tmp2 ]]
				then
					tmp3=$tmp3$tmp1/ 
					donepath=${tmp3//(#b)([\\\]\[\^\~\(\)\#\*\?])/\\$match[1]} 
					pre=$tpre 
					break
				elif [[ $tmp1 = (#b)(*)/([^/]#) ]]
				then
					tmp1=$match[1] 
					tpre=$match[2]/$tpre 
				else
					break
				fi
			done
		fi
		tpre="$pre" 
		tsuf="$suf" 
		testpath="${donepath//(#b)\\([\\\]\[\^\~\(\)\#\*\?])/$match[1]}" 
		tmp2="${(M)tpre##${~skips}}" 
		tpre="${tpre#$tmp2}" 
		tmp1=("$prepath$realpath$donepath$tmp2") 
		(( npathcheck = 0 ))
		while true
		do
			origtmp1=("${tmp1[@]}") 
			if [[ "$tpre" = */* ]]
			then
				PREFIX="${tpre%%/*}" 
				SUFFIX= 
			else
				PREFIX="${tpre}" 
				SUFFIX="${tsuf%%/*}" 
			fi
			tmp2=("$tmp1[@]") 
			if [[ "$tpre$tsuf" = (#b)*/(*) ]]
			then
				if [[ -n "$fake${match[1]}" ]]
				then
					compfiles -P$cfopt tmp1 accex "$skipped" "$_matcher $matcher[2]" "$sdirs" fake
				else
					compfiles -P$cfopt tmp1 accex "$skipped" "$_matcher $matcher[2]" '' fake
				fi
			elif [[ "$sopt" = *[/f]* ]]
			then
				compfiles -p$cfopt tmp1 accex "$skipped" "$_matcher $matcher[2]" "$sdirs" fake "$pats[@]"
			else
				compfiles -p$cfopt tmp1 accex "$skipped" "$_matcher $matcher[2]" '' fake "$pats[@]"
			fi
			tmp1=($~tmp1)  2> /dev/null
			if [[ -n "$PREFIX$SUFFIX" ]]
			then
				if (( ! $#tmp1 && npathcheck == 0 ))
				then
					(( npathcheck = 1 ))
					for tmp3 in "$tmp2[@]"
					do
						if [[ -n $tmp3 && $tmp3 != */ ]]
						then
							tmp3+=/ 
						fi
						if [[ -e "$tmp3${(Q)PREFIX}${(Q)SUFFIX}" ]]
						then
							(( npathcheck = 2 ))
						fi
					done
					if (( npathcheck == 2 ))
					then
						tmp1=("$origtmp1[@]") 
						continue
					fi
				fi
				if (( ! $#tmp1 ))
				then
					tmp2=(${^${tmp2:#/}}/$PREFIX$SUFFIX) 
				elif [[ "$tmp1[1]" = */* ]]
				then
					if [[ -n "$_comp_correct" ]]
					then
						tmp2=("$tmp1[@]") 
						builtin compadd -D tmp1 "$matcher[@]" - "${(@)tmp1:t}"
						if [[ $#tmp1 -eq 0 ]]
						then
							tmp1=("$tmp2[@]") 
							compadd -D tmp1 "$matcher[@]" - "${(@)tmp2:t}"
						fi
					else
						tmp2=("$tmp1[@]") 
						compadd -D tmp1 "$matcher[@]" - "${(@)tmp1:t}"
					fi
				else
					tmp2=('') 
					compadd -D tmp1 "$matcher[@]" -a tmp1
				fi
				if (( ! $#tmp1 ))
				then
					if [[ "$tmp2[1]" = */* ]]
					then
						tmp2=("${(@)tmp2#${prepath}${realpath}}") 
						if [[ "$tmp2[1]" = */* ]]
						then
							tmp2=("${(@)tmp2:h}") 
							compquote tmp2
							if [[ "$tmp2" = */ ]]
							then
								exppaths=("$exppaths[@]" ${^tmp2}${tpre}${tsuf}) 
							else
								exppaths=("$exppaths[@]" ${^tmp2}/${tpre}${tsuf}) 
							fi
						elif [[ ${tpre}${tsuf} = */* ]]
						then
							exppaths=("$exppaths[@]" ${tpre}${tsuf}) 
						fi
					fi
					continue 2
				fi
			elif (( ! $#tmp1 ))
			then
				if [[ -z "$tpre$tsuf" && -n "$pre$suf" ]]
				then
					pfxsfx=(-S '' "$pfxsfx[@]") 
				elif [[ -n "$haspats" && -z "$tpre$tsuf$suf" && "$pre" = */ ]]
				then
					PREFIX="${opre}" 
					SUFFIX="${osuf}" 
					compadd -nQS '' - "$linepath$donepath$orig"
					tmp4=- 
				fi
				continue 2
			fi
			if [[ -n "$ignpar" && -z "$_comp_no_ignore" && "$tpre$tsuf" != */* && $#tmp1 -ne 0 && ( "$ignpar" != *dir* || "$pats" = '*(-/)' ) && ( "$ignpar" != *..* || "$tmp1[1]" = *../* ) ]]
			then
				compfiles -i tmp1 ignore "$ignpar" "$prepath$realpath$donepath"
				_comp_ignore+=(${(@)ignore#$prepath$realpath$donepath}) 
				(( $#_comp_ignore && ! $mopts[(I)-F] )) && mopts=("$mopts[@]" -F _comp_ignore) 
			fi
			if [[ "$tpre" = */* ]]
			then
				tpre="${tpre#*/}" 
			elif [[ "$tsuf" = */* ]]
			then
				tpre="${tsuf#*/}" 
				tsuf= 
			else
				break
			fi
			tmp2="${(M)tpre##${~skips}}" 
			if [[ -n "$tmp2" ]]
			then
				skipped="/$tmp2" 
				tpre="${tpre#$tmp2}" 
			else
				skipped=/ 
			fi
			(( npathcheck = 0 ))
		done
		tmp3="$pre$suf" 
		tpre="$pre" 
		tsuf="$suf" 
		if [[ -n "${prepath}${realpath}${testpath}" ]]
		then
			if [[ -o nocaseglob ]]
			then
				tmp1=("${(@)tmp1#(#i)${prepath}${realpath}${testpath}}") 
			else
				tmp1=("${(@)tmp1#${prepath}${realpath}${testpath}}") 
			fi
		fi
		while true
		do
			compfiles -r tmp1 "${(Q)tmp3}"
			tmp4=$? 
			if [[ "$tpre" = */* ]]
			then
				tmp2="${cpre}${tpre%%/*}" 
				PREFIX="${linepath}${donepath}${tmp2}" 
				SUFFIX="/${tpre#*/}${tsuf#*/}" 
			else
				tmp2="${cpre}${tpre}" 
				PREFIX="${linepath}${donepath}${tmp2}" 
				SUFFIX="${tsuf}" 
			fi
			if (( tmp4 ))
			then
				tmp2="$testpath" 
				if [[ -n "$linepath" ]]
				then
					compquote -p tmp2 tmp1
				elif [[ -n "$tmp2" ]]
				then
					compquote -p tmp1
					compquote tmp2
				else
					compquote tmp1 tmp2
				fi
				if [[ -z "$_comp_correct" && "$compstate[pattern_match]" = \* && -n "$listsfx" && "$tmp2" = (|*[^\\])[][*?#~^\|\<\>]* ]]
				then
					PREFIX="$opre" 
					SUFFIX="$osuf" 
				fi
				if [[ -z "$compstate[insert]" ]] || {
						! zstyle -t ":completion:${curcontext}:paths" expand suffix && [[ -z "$listsfx" && ( -n "$_comp_correct" || -z "$compstate[pattern_match]" || "$SUFFIX" != */* || "${SUFFIX#*/}" = (|*[^\\])[][*?#~^\|\<\>]* ) ]]
					}
				then
					(( tmp4 )) && zstyle -t ":completion:${curcontext}:paths" ambiguous && compstate[to_end]= 
					if [[ "$tmp3" = */* ]]
					then
						if [[ -z "$listsfx" || "$tmp3" != */?* ]]
						then
							tmp1=("${(@)tmp1%%/*}") 
							_list_files tmp1 "$prepath$realpath$testpath"
							compadd $Uopt -Qf "$mopts[@]" -p "${Uopt:+$IPREFIX}$linepath$tmp2" -s "/${tmp3#*/}${Uopt:+$ISUFFIX}" -W "$prepath$realpath$testpath" "$pfxsfx[@]" $Mopts $listopts -a tmp1
						else
							tmp1=("${(@)^tmp1%%/*}/${tmp3#*/}") 
							_list_files tmp1 "$prepath$realpath$testpath"
							compadd $Uopt -Qf "$mopts[@]" -p "${Uopt:+$IPREFIX}$linepath$tmp2" -s "${Uopt:+$ISUFFIX}" -W "$prepath$realpath$testpath" "$pfxsfx[@]" $Mopts $listopts -a tmp1
						fi
					else
						_list_files tmp1 "$prepath$realpath$testpath"
						compadd $Uopt -Qf "$mopts[@]" -p "${Uopt:+$IPREFIX}$linepath$tmp2" -s "${Uopt:+$ISUFFIX}" -W "$prepath$realpath$testpath" "$pfxsfx[@]" $Mopts $listopts -a tmp1
					fi
				else
					if [[ "$tmp3" = */* ]]
					then
						tmp4=($Uopt -Qf "$mopts[@]" -p "${Uopt:+$IPREFIX}$linepath$tmp2" -W "$prepath$realpath$testpath" "$pfxsfx[@]" $Mopts) 
						if [[ -z "$listsfx" ]]
						then
							for i in "$tmp1[@]"
							do
								tmpdisp=("$i") 
								_list_files tmpdisp "$prepath$realpath$testpath"
								compadd "$tmp4[@]" -s "${Uopt:+$ISUFFIX}" $listopts - "$tmpdisp"
							done
						else
							[[ -n "$compstate[pattern_match]" ]] && SUFFIX="${SUFFIX:s./.*/}*" 
							for i in "$tmp1[@]"
							do
								_list_files i "$prepath$realpath$testpath"
								compadd "$tmp4[@]" $listopts - "$i"
							done
						fi
					else
						_list_files tmp1 "$prepath$realpath$testpath"
						compadd $Uopt -Qf "$mopts[@]" -p "${Uopt:+$IPREFIX}$linepath$tmp2" -s "${Uopt:+$ISUFFIX}" -W "$prepath$realpath$testpath" "$pfxsfx[@]" $Mopts $listopts -a tmp1
					fi
				fi
				tmp4=- 
				break
			fi
			if [[ "$tmp3" != */* ]]
			then
				tmp4= 
				break
			fi
			testpath="${testpath}${tmp1[1]%%/*}/" 
			tmp3="${tmp3#*/}" 
			if [[ "$tpre" = */* ]]
			then
				if [[ -z "$_comp_correct" && -n "$compstate[pattern_match]" && "$tmp2" = (|*[^\\])[][*?#~^\|\<\>]* ]]
				then
					cpre="${cpre}${tmp1[1]%%/*}/" 
				else
					cpre="${cpre}${tpre%%/*}/" 
				fi
				tpre="${tpre#*/}" 
			elif [[ "$tsuf" = */* ]]
			then
				[[ "$tsuf" != /* ]] && mid="$testpath" 
				if [[ -z "$_comp_correct" && -n "$compstate[pattern_match]" && "$tmp2" = (|*[^\\])[][*?#~^\|\<\>]* ]]
				then
					cpre="${cpre}${tmp1[1]%%/*}/" 
				else
					cpre="${cpre}${tpre}/" 
				fi
				tpre="${tsuf#*/}" 
				tsuf= 
			else
				tpre= 
				tsuf= 
			fi
			tmp1=("${(@)tmp1#*/}") 
		done
		if [[ -z "$tmp4" ]]
		then
			if [[ "$mid" = */ ]]
			then
				PREFIX="${opre}" 
				SUFFIX="${osuf}" 
				tmp4="${testpath#${mid}}" 
				if [[ $mid = */*/* ]]
				then
					tmp3="${mid%/*/}" 
					tmp2="${${mid%/}##*/}" 
					if [[ -n "$linepath" ]]
					then
						compquote -p tmp3
					else
						compquote tmp3
					fi
					compquote tmp4 tmp2 tmp1
					for i in "$tmp1[@]"
					do
						_list_files tmp2 "$prepath$realpath${mid%/*/}"
						compadd $Uopt -Qf "$mopts[@]" -p "${Uopt:+$IPREFIX}$linepath$tmp3/" -s "/$tmp4$i${Uopt:+$ISUFFIX}" -W "$prepath$realpath${mid%/*/}/" "$pfxsfx[@]" $Mopts $listopts - "$tmp2"
					done
				else
					tmp2="${${mid%/}##*/}" 
					compquote tmp4 tmp2 tmp1
					for i in "$tmp1[@]"
					do
						_list_files tmp2 "$prepath$realpath${mid%/*/}"
						compadd $Uopt -Qf "$mopts[@]" -p "${Uopt:+$IPREFIX}$linepath" -s "/$tmp4$i${Uopt:+$ISUFFIX}" -W "$prepath$realpath" "$pfxsfx[@]" $Mopts $listopts - "$tmp2"
					done
				fi
			else
				if [[ "$osuf" = */* ]]
				then
					PREFIX="${opre}${osuf}" 
					SUFFIX= 
				else
					PREFIX="${opre}" 
					SUFFIX="${osuf}" 
				fi
				tmp4="$testpath" 
				if [[ -n "$linepath" ]]
				then
					compquote -p tmp4 tmp1
				elif [[ -n "$tmp4" ]]
				then
					compquote -p tmp1
					compquote tmp4
				else
					compquote tmp4 tmp1
				fi
				if [[ -z "$_comp_correct" && -n "$compstate[pattern_match]" && "${PREFIX#\~}$SUFFIX" = (|*[^\\])[][*?#~^\|\<\>]* ]]
				then
					tmp1=("$linepath$tmp4${(@)^tmp1}") 
					_list_files tmp1 "$prepath$realpath"
					compadd -Qf -W "$prepath$realpath" "$pfxsfx[@]" "$mopts[@]" -M "r:|/=* r:|=*" $listopts -a tmp1
				else
					_list_files tmp1 "$prepath$realpath$testpath"
					compadd $Uopt -Qf -p "${Uopt:+$IPREFIX}$linepath$tmp4" -s "${Uopt:+$ISUFFIX}" -W "$prepath$realpath$testpath" "$pfxsfx[@]" "$mopts[@]" $Mopts $listopts -a tmp1
				fi
			fi
		fi
	done
	if [[ _matcher_num -eq ${#_matchers} ]] && zstyle -t ":completion:${curcontext}:paths" expand prefix && [[ nm -eq compstate[nmatches] && $#exppaths -ne 0 && "$linepath$exppaths" != "$eorig" ]]
	then
		PREFIX="${opre}" 
		SUFFIX="${osuf}" 
		compadd -Q "$mopts[@]" -S '' -M "r:|/=* r:|=*" -p "$linepath" -a exppaths
	fi
	[[ nm -ne compstate[nmatches] ]]
}
_pax () {
	# undefined
	builtin autoload -XUz
}
_pbm () {
	# undefined
	builtin autoload -XUz
}
_pbuilder () {
	# undefined
	builtin autoload -XUz
}
_pdf () {
	# undefined
	builtin autoload -XUz
}
_pdftk () {
	# undefined
	builtin autoload -XUz
}
_perforce () {
	# undefined
	builtin autoload -XUz
}
_perl () {
	# undefined
	builtin autoload -XUz
}
_perl_basepods () {
	# undefined
	builtin autoload -XUz
}
_perl_modules () {
	# undefined
	builtin autoload -XUz
}
_perldoc () {
	# undefined
	builtin autoload -XUz
}
_pfctl () {
	# undefined
	builtin autoload -XUz
}
_pfexec () {
	# undefined
	builtin autoload -XUz
}
_pgrep () {
	# undefined
	builtin autoload -XUz
}
_php () {
	# undefined
	builtin autoload -XUz
}
_physical_volumes () {
	# undefined
	builtin autoload -XUz
}
_pick_variant () {
	local output cmd pat
	local -a var
	local -A opts
	(( $+_cmd_variant )) || typeset -gA _cmd_variant
	zparseopts -D -A opts b: c: r:
	: ${opts[-c]:=$words[1]}
	while [[ $1 = *=* ]]
	do
		var+=("${1%%\=*}" "${1#*=}") 
		shift
	done
	if (( $+_cmd_variant[$opts[-c]] ))
	then
		(( $+opts[-r] )) && eval "${opts[-r]}=${_cmd_variant[$opts[-c]]}"
		[[ $_cmd_variant[$opts[-c]] = "$1" ]] && return 1
		return 0
	fi
	if [[ $+opts[-b] -eq 1 && -n $builtins[$opts[-c]] ]]
	then
		_cmd_variant[$opts[-c]]=$opts[-b] 
		(( $+opts[-r] )) && eval "${opts[-r]}=${_cmd_variant[$opts[-c]]}"
		return 0
	fi
	output="$(_call_program variant $opts[-c] "${@[2,-1]}" </dev/null 2>&1)" 
	for cmd pat in "$var[@]"
	do
		if [[ $output = *$~pat* ]]
		then
			(( $+opts[-r] )) && eval "${opts[-r]}=$cmd"
			_cmd_variant[$opts[-c]]="$cmd" 
			return 0
		fi
	done
	(( $+opts[-r] )) && eval "${opts[-r]}=$1"
	_cmd_variant[$opts[-c]]="$1" 
	return 1
}
_picocom () {
	# undefined
	builtin autoload -XUz
}
_pidof () {
	# undefined
	builtin autoload -XUz
}
_pids () {
	# undefined
	builtin autoload -XUz
}
_pine () {
	# undefined
	builtin autoload -XUz
}
_ping () {
	# undefined
	builtin autoload -XUz
}
_piuparts () {
	# undefined
	builtin autoload -XUz
}
_pkg-config () {
	# undefined
	builtin autoload -XUz
}
_pkg5 () {
	# undefined
	builtin autoload -XUz
}
_pkg_instance () {
	# undefined
	builtin autoload -XUz
}
_pkgadd () {
	# undefined
	builtin autoload -XUz
}
_pkginfo () {
	# undefined
	builtin autoload -XUz
}
_pkgrm () {
	# undefined
	builtin autoload -XUz
}
_pkgtool () {
	# undefined
	builtin autoload -XUz
}
_pon () {
	# undefined
	builtin autoload -XUz
}
_portaudit () {
	# undefined
	builtin autoload -XUz
}
_portlint () {
	# undefined
	builtin autoload -XUz
}
_portmaster () {
	# undefined
	builtin autoload -XUz
}
_ports () {
	# undefined
	builtin autoload -XUz
}
_portsnap () {
	# undefined
	builtin autoload -XUz
}
_postfix () {
	# undefined
	builtin autoload -XUz
}
_postscript () {
	# undefined
	builtin autoload -XUz
}
_powerd () {
	# undefined
	builtin autoload -XUz
}
_prcs () {
	# undefined
	builtin autoload -XUz
}
_precommand () {
	# undefined
	builtin autoload -XUz
}
_prefix () {
	# undefined
	builtin autoload -XUz
}
_print () {
	# undefined
	builtin autoload -XUz
}
_printenv () {
	# undefined
	builtin autoload -XUz
}
_printers () {
	# undefined
	builtin autoload -XUz
}
_procstat () {
	# undefined
	builtin autoload -XUz
}
_prompt () {
	# undefined
	builtin autoload -XUz
}
_prove () {
	# undefined
	builtin autoload -XUz
}
_prstat () {
	# undefined
	builtin autoload -XUz
}
_ps () {
	# undefined
	builtin autoload -XUz
}
_ps1234 () {
	# undefined
	builtin autoload -XUz
}
_pscp () {
	# undefined
	builtin autoload -XUz
}
_pspdf () {
	# undefined
	builtin autoload -XUz
}
_psutils () {
	# undefined
	builtin autoload -XUz
}
_ptree () {
	# undefined
	builtin autoload -XUz
}
_pulseaudio () {
	# undefined
	builtin autoload -XUz
}
_pump () {
	# undefined
	builtin autoload -XUz
}
_putclip () {
	# undefined
	builtin autoload -XUz
}
_pydoc () {
	# undefined
	builtin autoload -XUz
}
_python () {
	# undefined
	builtin autoload -XUz
}
_python_modules () {
	# undefined
	builtin autoload -XUz
}
_qdbus () {
	# undefined
	builtin autoload -XUz
}
_qemu () {
	# undefined
	builtin autoload -XUz
}
_qiv () {
	# undefined
	builtin autoload -XUz
}
_qtplay () {
	# undefined
	builtin autoload -XUz
}
_quilt () {
	# undefined
	builtin autoload -XUz
}
_raggle () {
	# undefined
	builtin autoload -XUz
}
_rake () {
	# undefined
	builtin autoload -XUz
}
_ranlib () {
	# undefined
	builtin autoload -XUz
}
_rar () {
	# undefined
	builtin autoload -XUz
}
_rcctl () {
	# undefined
	builtin autoload -XUz
}
_rcs () {
	# undefined
	builtin autoload -XUz
}
_rdesktop () {
	# undefined
	builtin autoload -XUz
}
_read () {
	# undefined
	builtin autoload -XUz
}
_read_comp () {
	# undefined
	builtin autoload -XUz
}
_readelf () {
	# undefined
	builtin autoload -XUz
}
_readshortcut () {
	# undefined
	builtin autoload -XUz
}
_rebootin () {
	# undefined
	builtin autoload -XUz
}
_redirect () {
	# undefined
	builtin autoload -XUz
}
_regex_arguments () {
	# undefined
	builtin autoload -XUz
}
_regex_words () {
	# undefined
	builtin autoload -XUz
}
_remote_files () {
	# undefined
	builtin autoload -XUz
}
_renice () {
	# undefined
	builtin autoload -XUz
}
_reprepro () {
	# undefined
	builtin autoload -XUz
}
_requested () {
	local __gopt
	__gopt=() 
	zparseopts -D -a __gopt 1 2 V J x
	if comptags -R "$1"
	then
		if [[ $# -gt 3 ]]
		then
			_all_labels - "$__gopt[@]" "$@" || return 1
		elif [[ $# -gt 1 ]]
		then
			_description "$__gopt[@]" "$@"
		fi
		return 0
	else
		return 1
	fi
}
_retrieve_cache () {
	# undefined
	builtin autoload -XUz
}
_retrieve_mac_apps () {
	# undefined
	builtin autoload -XUz
}
_retry_clipboard_detection_or_fail () {
	local clipcmd="${1}" 
	shift
	if detect-clipboard
	then
		"${clipcmd}" "$@"
	else
		print "${clipcmd}: Platform $OSTYPE not supported or xclip/xsel not installed" >&2
		return 1
	fi
}
_ri () {
	# undefined
	builtin autoload -XUz
}
_rlogin () {
	# undefined
	builtin autoload -XUz
}
_rm () {
	# undefined
	builtin autoload -XUz
}
_route () {
	# undefined
	builtin autoload -XUz
}
_rpm () {
	# undefined
	builtin autoload -XUz
}
_rpmbuild () {
	# undefined
	builtin autoload -XUz
}
_rrdtool () {
	# undefined
	builtin autoload -XUz
}
_rsync () {
	# undefined
	builtin autoload -XUz
}
_rubber () {
	# undefined
	builtin autoload -XUz
}
_ruby () {
	# undefined
	builtin autoload -XUz
}
_run-help () {
	# undefined
	builtin autoload -XUz
}
_runit () {
	# undefined
	builtin autoload -XUz
}
_sablotron () {
	# undefined
	builtin autoload -XUz
}
_samba () {
	# undefined
	builtin autoload -XUz
}
_savecore () {
	# undefined
	builtin autoload -XUz
}
_sccs () {
	# undefined
	builtin autoload -XUz
}
_sched () {
	# undefined
	builtin autoload -XUz
}
_schedtool () {
	# undefined
	builtin autoload -XUz
}
_schroot () {
	# undefined
	builtin autoload -XUz
}
_scl () {
	# undefined
	builtin autoload -XUz
}
_screen () {
	# undefined
	builtin autoload -XUz
}
_script () {
	# undefined
	builtin autoload -XUz
}
_sd_hosts_or_user_at_host () {
	# undefined
	builtin autoload -XUz
}
_sd_outputmodes () {
	# undefined
	builtin autoload -XUz
}
_sd_unit_files () {
	# undefined
	builtin autoload -XUz
}
_sed () {
	# undefined
	builtin autoload -XUz
}
_sep_parts () {
	# undefined
	builtin autoload -XUz
}
_sequence () {
	# undefined
	builtin autoload -XUz
}
_service () {
	# undefined
	builtin autoload -XUz
}
_services () {
	# undefined
	builtin autoload -XUz
}
_set () {
	# undefined
	builtin autoload -XUz
}
_set_command () {
	local command
	command="$words[1]" 
	[[ -z "$command" ]] && return
	if (( $+builtins[$command] + $+functions[$command] ))
	then
		_comp_command1="$command" 
		_comp_command="$_comp_command1" 
	elif [[ "$command[1]" = '=' ]]
	then
		eval _comp_command2\=$command
		_comp_command1="$command[2,-1]" 
		_comp_command="$_comp_command2" 
	elif [[ "$command" = ..#/* ]]
	then
		_comp_command1="${PWD}/$command" 
		_comp_command2="${command:t}" 
		_comp_command="$_comp_command2" 
	elif [[ "$command" = */* ]]
	then
		_comp_command1="$command" 
		_comp_command2="${command:t}" 
		_comp_command="$_comp_command2" 
	else
		_comp_command1="$command" 
		_comp_command2="$commands[$command]" 
		_comp_command="$_comp_command1" 
	fi
}
_setfacl () {
	# undefined
	builtin autoload -XUz
}
_setopt () {
	# undefined
	builtin autoload -XUz
}
_setup () {
	local val nm="$compstate[nmatches]" 
	[[ $# -eq 1 ]] && 2="$1" 
	if zstyle -a ":completion:${curcontext}:$1" list-colors val
	then
		zmodload -i zsh/complist
		if [[ "$1" = default ]]
		then
			_comp_colors=("$val[@]") 
		else
			_comp_colors+=("(${2})${(@)^val:#(|\(*\)*)}" "${(M@)val:#\(*\)*}") 
		fi
	elif [[ "$1" = default ]]
	then
		unset ZLS_COLORS ZLS_COLOURS
	fi
	if zstyle -s ":completion:${curcontext}:$1" show-ambiguity val
	then
		zmodload -i zsh/complist
		[[ $val = (yes|true|on) ]] && _ambiguous_color=4  || _ambiguous_color=$val 
	fi
	if zstyle -t ":completion:${curcontext}:$1" list-packed
	then
		compstate[list]="${compstate[list]} packed" 
	elif [[ $? -eq 1 ]]
	then
		compstate[list]="${compstate[list]:gs/packed//}" 
	else
		compstate[list]="$_saved_list" 
	fi
	if zstyle -t ":completion:${curcontext}:$1" list-rows-first
	then
		compstate[list]="${compstate[list]} rows" 
	elif [[ $? -eq 1 ]]
	then
		compstate[list]="${compstate[list]:gs/rows//}" 
	else
		compstate[list]="$_saved_list" 
	fi
	if zstyle -t ":completion:${curcontext}:$1" last-prompt
	then
		compstate[last_prompt]=yes 
	elif [[ $? -eq 1 ]]
	then
		compstate[last_prompt]='' 
	else
		compstate[last_prompt]="$_saved_lastprompt" 
	fi
	if zstyle -t ":completion:${curcontext}:$1" accept-exact
	then
		compstate[exact]=accept 
	elif [[ $? -eq 1 ]]
	then
		compstate[exact]='' 
	else
		compstate[exact]="$_saved_exact" 
	fi
	[[ _last_nmatches -ge 0 && _last_nmatches -ne nm ]] && _menu_style=("$_last_menu_style[@]" "$_menu_style[@]") 
	if zstyle -a ":completion:${curcontext}:$1" menu val
	then
		_last_nmatches=$nm 
		_last_menu_style=("$val[@]") 
	else
		_last_nmatches=-1 
	fi
	[[ "$_comp_force_list" != always ]] && zstyle -s ":completion:${curcontext}:$1" force-list val && [[ "$val" = always || ( "$val" = [0-9]## && ( -z "$_comp_force_list" || _comp_force_list -gt val ) ) ]] && _comp_force_list="$val" 
}
_setxkbmap () {
	# undefined
	builtin autoload -XUz
}
_sh () {
	# undefined
	builtin autoload -XUz
}
_showmount () {
	# undefined
	builtin autoload -XUz
}
_signals () {
	# undefined
	builtin autoload -XUz
}
_sisu () {
	# undefined
	builtin autoload -XUz
}
_slrn () {
	# undefined
	builtin autoload -XUz
}
_smit () {
	# undefined
	builtin autoload -XUz
}
_snap () {
	# undefined
	builtin autoload -XUz
}
_snoop () {
	# undefined
	builtin autoload -XUz
}
_socket () {
	# undefined
	builtin autoload -XUz
}
_sockstat () {
	# undefined
	builtin autoload -XUz
}
_softwareupdate () {
	# undefined
	builtin autoload -XUz
}
_sort () {
	# undefined
	builtin autoload -XUz
}
_source () {
	# undefined
	builtin autoload -XUz
}
_spamassassin () {
	# undefined
	builtin autoload -XUz
}
_sqlite () {
	# undefined
	builtin autoload -XUz
}
_sqsh () {
	# undefined
	builtin autoload -XUz
}
_ss () {
	# undefined
	builtin autoload -XUz
}
_ssh () {
	# undefined
	builtin autoload -XUz
}
_sshfs () {
	# undefined
	builtin autoload -XUz
}
_stat () {
	# undefined
	builtin autoload -XUz
}
_stgit () {
	# undefined
	builtin autoload -XUz
}
_store_cache () {
	# undefined
	builtin autoload -XUz
}
_strace () {
	# undefined
	builtin autoload -XUz
}
_strftime () {
	# undefined
	builtin autoload -XUz
}
_strip () {
	# undefined
	builtin autoload -XUz
}
_stty () {
	# undefined
	builtin autoload -XUz
}
_su () {
	# undefined
	builtin autoload -XUz
}
_sub_commands () {
	# undefined
	builtin autoload -XUz
}
_subscript () {
	# undefined
	builtin autoload -XUz
}
_subversion () {
	# undefined
	builtin autoload -XUz
}
_sudo () {
	# undefined
	builtin autoload -XUz
}
_suffix_alias_files () {
	local expl pat
	(( ${#saliases} )) || return 1
	if (( ${#saliases} == 1 ))
	then
		pat="*.${(kq)saliases}" 
	else
		local -a tmpa
		tmpa=(${(kq)saliases}) 
		pat="*.(${(kj.|.)tmpa})" 
	fi
	_path_files "$@" -g $pat
}
_surfraw () {
	# undefined
	builtin autoload -XUz
}
_svcadm () {
	# undefined
	builtin autoload -XUz
}
_svccfg () {
	# undefined
	builtin autoload -XUz
}
_svcprop () {
	# undefined
	builtin autoload -XUz
}
_svcs () {
	# undefined
	builtin autoload -XUz
}
_svcs_fmri () {
	# undefined
	builtin autoload -XUz
}
_svn-buildpackage () {
	# undefined
	builtin autoload -XUz
}
_swaks () {
	# undefined
	builtin autoload -XUz
}
_swift () {
	# undefined
	builtin autoload -XUz
}
_sys_calls () {
	# undefined
	builtin autoload -XUz
}
_sysctl () {
	# undefined
	builtin autoload -XUz
}
_sysrc () {
	# undefined
	builtin autoload -XUz
}
_sysstat () {
	# undefined
	builtin autoload -XUz
}
_systat () {
	# undefined
	builtin autoload -XUz
}
_system_profiler () {
	# undefined
	builtin autoload -XUz
}
_systemctl () {
	# undefined
	builtin autoload -XUz
}
_systemd () {
	# undefined
	builtin autoload -XUz
}
_systemd-analyze () {
	# undefined
	builtin autoload -XUz
}
_systemd-delta () {
	# undefined
	builtin autoload -XUz
}
_systemd-inhibit () {
	# undefined
	builtin autoload -XUz
}
_systemd-resolve () {
	# undefined
	builtin autoload -XUz
}
_systemd-run () {
	# undefined
	builtin autoload -XUz
}
_systemd-tmpfiles () {
	# undefined
	builtin autoload -XUz
}
_tags () {
	local prev
	if [[ "$1" = -- ]]
	then
		prev=- 
		shift
	fi
	if (( $# ))
	then
		local curcontext="$curcontext" order tag nodef tmp 
		if [[ "$1" = -C?* ]]
		then
			curcontext="${curcontext%:*}:${1[3,-1]}" 
			shift
		elif [[ "$1" = -C ]]
		then
			curcontext="${curcontext%:*}:${2}" 
			shift 2
		fi
		[[ "$1" = -(|-) ]] && shift
		zstyle -a ":completion:${curcontext}:" group-order order && compgroups "$order[@]"
		comptags "-i$prev" "$curcontext" "$@"
		if [[ -n "$_sort_tags" ]]
		then
			"$_sort_tags" "$@"
		else
			zstyle -a ":completion:${curcontext}:" tag-order order || (( ! ${@[(I)options]} )) || order=('(|*-)argument-* (|*-)option[-+]* values' options) 
			for tag in $order
			do
				case $tag in
					(-) nodef=yes  ;;
					(\!*) comptry "${(@)argv:#(${(j:|:)~${=~tag[2,-1]}})}" ;;
					(?*) comptry -m "$tag" ;;
				esac
			done
			[[ -z "$nodef" ]] && comptry "$@"
		fi
		comptags "-T$prev"
		return
	fi
	comptags "-N$prev"
}
_tail () {
	# undefined
	builtin autoload -XUz
}
_tar () {
	# undefined
	builtin autoload -XUz
}
_tar_archive () {
	# undefined
	builtin autoload -XUz
}
_tardy () {
	# undefined
	builtin autoload -XUz
}
_tcpdump () {
	# undefined
	builtin autoload -XUz
}
_tcpsys () {
	# undefined
	builtin autoload -XUz
}
_tcptraceroute () {
	# undefined
	builtin autoload -XUz
}
_telnet () {
	# undefined
	builtin autoload -XUz
}
_terminals () {
	# undefined
	builtin autoload -XUz
}
_tex () {
	# undefined
	builtin autoload -XUz
}
_texi () {
	# undefined
	builtin autoload -XUz
}
_texinfo () {
	# undefined
	builtin autoload -XUz
}
_tidy () {
	# undefined
	builtin autoload -XUz
}
_tiff () {
	# undefined
	builtin autoload -XUz
}
_tilde () {
	# undefined
	builtin autoload -XUz
}
_tilde_files () {
	# undefined
	builtin autoload -XUz
}
_time_zone () {
	# undefined
	builtin autoload -XUz
}
_timedatectl () {
	# undefined
	builtin autoload -XUz
}
_tin () {
	# undefined
	builtin autoload -XUz
}
_tla () {
	# undefined
	builtin autoload -XUz
}
_tmux () {
	# undefined
	builtin autoload -XUz
}
_todo.sh () {
	# undefined
	builtin autoload -XUz
}
_toilet () {
	# undefined
	builtin autoload -XUz
}
_toolchain-source () {
	# undefined
	builtin autoload -XUz
}
_top () {
	# undefined
	builtin autoload -XUz
}
_topgit () {
	# undefined
	builtin autoload -XUz
}
_totd () {
	# undefined
	builtin autoload -XUz
}
_touch () {
	# undefined
	builtin autoload -XUz
}
_tpb () {
	# undefined
	builtin autoload -XUz
}
_tpconfig () {
	# undefined
	builtin autoload -XUz
}
_tput () {
	# undefined
	builtin autoload -XUz
}
_tr () {
	# undefined
	builtin autoload -XUz
}
_tracepath () {
	# undefined
	builtin autoload -XUz
}
_trap () {
	# undefined
	builtin autoload -XUz
}
_tree () {
	# undefined
	builtin autoload -XUz
}
_truss () {
	# undefined
	builtin autoload -XUz
}
_ttyctl () {
	# undefined
	builtin autoload -XUz
}
_ttys () {
	# undefined
	builtin autoload -XUz
}
_tune2fs () {
	# undefined
	builtin autoload -XUz
}
_twidge () {
	# undefined
	builtin autoload -XUz
}
_twisted () {
	# undefined
	builtin autoload -XUz
}
_typeset () {
	# undefined
	builtin autoload -XUz
}
_ubuntu-report () {
	# undefined
	builtin autoload -XUz
}
_udevadm () {
	# undefined
	builtin autoload -XUz
}
_ulimit () {
	# undefined
	builtin autoload -XUz
}
_uml () {
	# undefined
	builtin autoload -XUz
}
_umountable () {
	# undefined
	builtin autoload -XUz
}
_unace () {
	# undefined
	builtin autoload -XUz
}
_uname () {
	# undefined
	builtin autoload -XUz
}
_unexpand () {
	# undefined
	builtin autoload -XUz
}
_unhash () {
	# undefined
	builtin autoload -XUz
}
_uniq () {
	# undefined
	builtin autoload -XUz
}
_unison () {
	# undefined
	builtin autoload -XUz
}
_units () {
	# undefined
	builtin autoload -XUz
}
_update-alternatives () {
	# undefined
	builtin autoload -XUz
}
_update-rc.d () {
	# undefined
	builtin autoload -XUz
}
_urls () {
	# undefined
	builtin autoload -XUz
}
_urpmi () {
	# undefined
	builtin autoload -XUz
}
_urxvt () {
	# undefined
	builtin autoload -XUz
}
_uscan () {
	# undefined
	builtin autoload -XUz
}
_user_admin () {
	# undefined
	builtin autoload -XUz
}
_user_at_host () {
	# undefined
	builtin autoload -XUz
}
_user_expand () {
	# undefined
	builtin autoload -XUz
}
_user_math_func () {
	# undefined
	builtin autoload -XUz
}
_users () {
	# undefined
	builtin autoload -XUz
}
_users_on () {
	# undefined
	builtin autoload -XUz
}
_uzbl () {
	# undefined
	builtin autoload -XUz
}
_valgrind () {
	# undefined
	builtin autoload -XUz
}
_value () {
	# undefined
	builtin autoload -XUz
}
_values () {
	# undefined
	builtin autoload -XUz
}
_vared () {
	# undefined
	builtin autoload -XUz
}
_vars () {
	# undefined
	builtin autoload -XUz
}
_vcsh () {
	# undefined
	builtin autoload -XUz
}
_vim () {
	# undefined
	builtin autoload -XUz
}
_vim-addons () {
	# undefined
	builtin autoload -XUz
}
_vmstat () {
	# undefined
	builtin autoload -XUz
}
_vnc () {
	# undefined
	builtin autoload -XUz
}
_volume_groups () {
	# undefined
	builtin autoload -XUz
}
_vorbis () {
	# undefined
	builtin autoload -XUz
}
_vorbiscomment () {
	# undefined
	builtin autoload -XUz
}
_vserver () {
	# undefined
	builtin autoload -XUz
}
_vux () {
	# undefined
	builtin autoload -XUz
}
_w () {
	# undefined
	builtin autoload -XUz
}
_w3m () {
	# undefined
	builtin autoload -XUz
}
_wait () {
	# undefined
	builtin autoload -XUz
}
_wajig () {
	# undefined
	builtin autoload -XUz
}
_wakeup_capable_devices () {
	# undefined
	builtin autoload -XUz
}
_wanna-build () {
	# undefined
	builtin autoload -XUz
}
_wanted () {
	local -a __targs __gopt
	zparseopts -D -a __gopt 1 2 V J x C:=__targs
	_tags "$__targs[@]" "$1"
	while _tags
	do
		_all_labels "$__gopt[@]" "$@" && return 0
	done
	return 1
}
_watch () {
	# undefined
	builtin autoload -XUz
}
_watch-snoop () {
	# undefined
	builtin autoload -XUz
}
_wc () {
	# undefined
	builtin autoload -XUz
}
_webbrowser () {
	# undefined
	builtin autoload -XUz
}
_wget () {
	# undefined
	builtin autoload -XUz
}
_whereis () {
	# undefined
	builtin autoload -XUz
}
_which () {
	# undefined
	builtin autoload -XUz
}
_who () {
	# undefined
	builtin autoload -XUz
}
_whois () {
	# undefined
	builtin autoload -XUz
}
_widgets () {
	# undefined
	builtin autoload -XUz
}
_wiggle () {
	# undefined
	builtin autoload -XUz
}
_wpa_cli () {
	# undefined
	builtin autoload -XUz
}
_x_arguments () {
	# undefined
	builtin autoload -XUz
}
_x_borderwidth () {
	# undefined
	builtin autoload -XUz
}
_x_color () {
	# undefined
	builtin autoload -XUz
}
_x_colormapid () {
	# undefined
	builtin autoload -XUz
}
_x_cursor () {
	# undefined
	builtin autoload -XUz
}
_x_display () {
	# undefined
	builtin autoload -XUz
}
_x_extension () {
	# undefined
	builtin autoload -XUz
}
_x_font () {
	# undefined
	builtin autoload -XUz
}
_x_geometry () {
	# undefined
	builtin autoload -XUz
}
_x_keysym () {
	# undefined
	builtin autoload -XUz
}
_x_locale () {
	# undefined
	builtin autoload -XUz
}
_x_modifier () {
	# undefined
	builtin autoload -XUz
}
_x_name () {
	# undefined
	builtin autoload -XUz
}
_x_resource () {
	# undefined
	builtin autoload -XUz
}
_x_selection_timeout () {
	# undefined
	builtin autoload -XUz
}
_x_title () {
	# undefined
	builtin autoload -XUz
}
_x_utils () {
	# undefined
	builtin autoload -XUz
}
_x_visual () {
	# undefined
	builtin autoload -XUz
}
_x_window () {
	# undefined
	builtin autoload -XUz
}
_xargs () {
	# undefined
	builtin autoload -XUz
}
_xauth () {
	# undefined
	builtin autoload -XUz
}
_xautolock () {
	# undefined
	builtin autoload -XUz
}
_xclip () {
	# undefined
	builtin autoload -XUz
}
_xdvi () {
	# undefined
	builtin autoload -XUz
}
_xfig () {
	# undefined
	builtin autoload -XUz
}
_xft_fonts () {
	# undefined
	builtin autoload -XUz
}
_xloadimage () {
	# undefined
	builtin autoload -XUz
}
_xmlsoft () {
	# undefined
	builtin autoload -XUz
}
_xmms2 () {
	# undefined
	builtin autoload -XUz
}
_xmodmap () {
	# undefined
	builtin autoload -XUz
}
_xournal () {
	# undefined
	builtin autoload -XUz
}
_xpdf () {
	# undefined
	builtin autoload -XUz
}
_xrandr () {
	# undefined
	builtin autoload -XUz
}
_xscreensaver () {
	# undefined
	builtin autoload -XUz
}
_xset () {
	# undefined
	builtin autoload -XUz
}
_xt_arguments () {
	# undefined
	builtin autoload -XUz
}
_xt_session_id () {
	# undefined
	builtin autoload -XUz
}
_xterm () {
	# undefined
	builtin autoload -XUz
}
_xv () {
	# undefined
	builtin autoload -XUz
}
_xwit () {
	# undefined
	builtin autoload -XUz
}
_xxd () {
	# undefined
	builtin autoload -XUz
}
_xz () {
	# undefined
	builtin autoload -XUz
}
_yafc () {
	# undefined
	builtin autoload -XUz
}
_yast () {
	# undefined
	builtin autoload -XUz
}
_yodl () {
	# undefined
	builtin autoload -XUz
}
_yp () {
	# undefined
	builtin autoload -XUz
}
_yum () {
	# undefined
	builtin autoload -XUz
}
_zargs () {
	# undefined
	builtin autoload -XUz
}
_zattr () {
	# undefined
	builtin autoload -XUz
}
_zcalc () {
	# undefined
	builtin autoload -XUz
}
_zcalc_line () {
	# undefined
	builtin autoload -XUz
}
_zcat () {
	# undefined
	builtin autoload -XUz
}
_zcompile () {
	# undefined
	builtin autoload -XUz
}
_zdump () {
	# undefined
	builtin autoload -XUz
}
_zed () {
	# undefined
	builtin autoload -XUz
}
_zfs () {
	# undefined
	builtin autoload -XUz
}
_zfs_dataset () {
	# undefined
	builtin autoload -XUz
}
_zfs_keysource_props () {
	# undefined
	builtin autoload -XUz
}
_zfs_pool () {
	# undefined
	builtin autoload -XUz
}
_zftp () {
	# undefined
	builtin autoload -XUz
}
_zip () {
	# undefined
	builtin autoload -XUz
}
_zle () {
	# undefined
	builtin autoload -XUz
}
_zlogin () {
	# undefined
	builtin autoload -XUz
}
_zmodload () {
	# undefined
	builtin autoload -XUz
}
_zmv () {
	# undefined
	builtin autoload -XUz
}
_zoneadm () {
	# undefined
	builtin autoload -XUz
}
_zones () {
	# undefined
	builtin autoload -XUz
}
_zpool () {
	# undefined
	builtin autoload -XUz
}
_zpty () {
	# undefined
	builtin autoload -XUz
}
_zsh () {
	# undefined
	builtin autoload -XUz
}
_zsh-mime-handler () {
	# undefined
	builtin autoload -XUz
}
_zsh_highlight () {
	local ret=$? 
	typeset -r ret
	(( ${+region_highlight} )) || {
		echo 'zsh-syntax-highlighting: error: $region_highlight is not defined' >&2
		echo 'zsh-syntax-highlighting: (Check whether zsh-syntax-highlighting was installed according to the instructions.)' >&2
		return $ret
	}
	(( ${+zsh_highlight__memo_feature} )) || {
		region_highlight+=(" 0 0 fg=red, memo=zsh-syntax-highlighting") 
		case ${region_highlight[-1]} in
			("0 0 fg=red") integer -gr zsh_highlight__memo_feature=0  ;;
			("0 0 fg=red memo=zsh-syntax-highlighting") integer -gr zsh_highlight__memo_feature=1  ;;
			(" 0 0 fg=red, memo=zsh-syntax-highlighting")  ;&
			(*) if is-at-least 5.8.1.1 $ZSH_VERSION.0.0
				then
					integer -gr zsh_highlight__memo_feature=1 
				else
					integer -gr zsh_highlight__memo_feature=0 
				fi ;;
		esac
		region_highlight[-1]=() 
	}
	if (( zsh_highlight__memo_feature ))
	then
		region_highlight=("${(@)region_highlight:#*memo=zsh-syntax-highlighting*}") 
	else
		region_highlight=() 
	fi
	if [[ $WIDGET == zle-isearch-update ]] && {
			$zsh_highlight__pat_static_bug || ! (( $+ISEARCHMATCH_ACTIVE ))
		}
	then
		return $ret
	fi
	local -A zsyh_user_options
	if zmodload -e zsh/parameter
	then
		zsyh_user_options=("${(kv)options[@]}") 
	else
		local canonical_options onoff option raw_options
		raw_options=(${(f)"$(emulate -R zsh; set -o)"}) 
		canonical_options=(${${${(M)raw_options:#*off}%% *}#no} ${${(M)raw_options:#*on}%% *}) 
		for option in "${canonical_options[@]}"
		do
			[[ -o $option ]]
			case $? in
				(0) zsyh_user_options+=($option on)  ;;
				(1) zsyh_user_options+=($option off)  ;;
				(*) echo "zsh-syntax-highlighting: warning: '[[ -o $option ]]' returned $?" ;;
			esac
		done
	fi
	typeset -r zsyh_user_options
	emulate -L zsh
	setopt localoptions warncreateglobal nobashrematch
	local REPLY
	[[ -n ${ZSH_HIGHLIGHT_MAXLENGTH:-} ]] && [[ $#BUFFER -gt $ZSH_HIGHLIGHT_MAXLENGTH ]] && return $ret
	(( KEYS_QUEUED_COUNT > 0 )) && return $ret
	(( PENDING > 0 )) && return $ret
	{
		local cache_place
		local -a region_highlight_copy
		local highlighter
		for highlighter in $ZSH_HIGHLIGHT_HIGHLIGHTERS
		do
			cache_place="_zsh_highlight__highlighter_${highlighter}_cache" 
			typeset -ga ${cache_place}
			if ! type "_zsh_highlight_highlighter_${highlighter}_predicate" >&/dev/null
			then
				echo "zsh-syntax-highlighting: warning: disabling the ${(qq)highlighter} highlighter as it has not been loaded" >&2
				ZSH_HIGHLIGHT_HIGHLIGHTERS=(${ZSH_HIGHLIGHT_HIGHLIGHTERS:#${highlighter}}) 
			elif "_zsh_highlight_highlighter_${highlighter}_predicate"
			then
				region_highlight_copy=("${region_highlight[@]}") 
				region_highlight=() 
				{
					"_zsh_highlight_highlighter_${highlighter}_paint"
				} always {
					: ${(AP)cache_place::="${region_highlight[@]}"}
				}
				region_highlight=("${region_highlight_copy[@]}") 
			fi
			region_highlight+=("${(@P)cache_place}") 
		done
		() {
			(( REGION_ACTIVE )) || return
			integer min max
			if (( MARK > CURSOR ))
			then
				min=$CURSOR max=$MARK 
			else
				min=$MARK max=$CURSOR 
			fi
			if (( REGION_ACTIVE == 1 ))
			then
				[[ $KEYMAP = vicmd ]] && (( max++ ))
			elif (( REGION_ACTIVE == 2 ))
			then
				local needle=$'\n' 
				(( min = ${BUFFER[(Ib:min:)$needle]} ))
				(( max = ${BUFFER[(ib:max:)$needle]} - 1 ))
			fi
			_zsh_highlight_apply_zle_highlight region standout "$min" "$max"
		}
		(( $+YANK_ACTIVE )) && (( YANK_ACTIVE )) && _zsh_highlight_apply_zle_highlight paste standout "$YANK_START" "$YANK_END"
		(( $+ISEARCHMATCH_ACTIVE )) && (( ISEARCHMATCH_ACTIVE )) && _zsh_highlight_apply_zle_highlight isearch underline "$ISEARCHMATCH_START" "$ISEARCHMATCH_END"
		(( $+SUFFIX_ACTIVE )) && (( SUFFIX_ACTIVE )) && _zsh_highlight_apply_zle_highlight suffix bold "$SUFFIX_START" "$SUFFIX_END"
		return $ret
	} always {
		typeset -g _ZSH_HIGHLIGHT_PRIOR_BUFFER="$BUFFER" 
		typeset -gi _ZSH_HIGHLIGHT_PRIOR_CURSOR=$CURSOR 
	}
}
_zsh_highlight__function_callable_p () {
	if _zsh_highlight__is_function_p "$1" && ! _zsh_highlight__function_is_autoload_stub_p "$1"
	then
		return 0
	else
		(
			autoload -U +X -- "$1" 2> /dev/null
		)
		return $?
	fi
}
_zsh_highlight__function_is_autoload_stub_p () {
	if zmodload -e zsh/parameter
	then
		[[ "$functions[$1]" == *"builtin autoload -X"* ]]
	else
		[[ "${${(@f)"$(which -- "$1")"}[2]}" == $'\t'$histchars[3]' undefined' ]]
	fi
}
_zsh_highlight__is_function_p () {
	if zmodload -e zsh/parameter
	then
		(( ${+functions[$1]} ))
	else
		[[ $(type -wa -- "$1") == *'function'* ]]
	fi
}
_zsh_highlight_add_highlight () {
	local -i start end
	local highlight
	start=$1 
	end=$2 
	shift 2
	for highlight
	do
		if (( $+ZSH_HIGHLIGHT_STYLES[$highlight] ))
		then
			region_highlight+=("$start $end $ZSH_HIGHLIGHT_STYLES[$highlight], memo=zsh-syntax-highlighting") 
			break
		fi
	done
}
_zsh_highlight_apply_zle_highlight () {
	local entry="$1" default="$2" 
	integer first="$3" second="$4" 
	local region="${zle_highlight[(r)${entry}:*]-}" 
	if [[ -z "$region" ]]
	then
		region=$default 
	else
		region="${region#${entry}:}" 
		if [[ -z "$region" ]] || [[ "$region" == none ]]
		then
			return
		fi
	fi
	integer start end
	if (( first < second ))
	then
		start=$first end=$second 
	else
		start=$second end=$first 
	fi
	region_highlight+=("$start $end $region, memo=zsh-syntax-highlighting") 
}
_zsh_highlight_bind_widgets () {
	setopt localoptions noksharrays
	typeset -F SECONDS
	local prefix=orig-s$SECONDS-r$RANDOM 
	zmodload zsh/zleparameter 2> /dev/null || {
		print -r -- 'zsh-syntax-highlighting: failed loading zsh/zleparameter.' >&2
		return 1
	}
	local -U widgets_to_bind
	widgets_to_bind=(${${(k)widgets}:#(.*|run-help|which-command|beep|set-local-history|yank|yank-pop)}) 
	widgets_to_bind+=(zle-line-finish) 
	widgets_to_bind+=(zle-isearch-update) 
	local cur_widget
	for cur_widget in $widgets_to_bind
	do
		case ${widgets[$cur_widget]:-""} in
			(user:_zsh_highlight_widget_*)  ;;
			(user:*) zle -N $prefix-$cur_widget ${widgets[$cur_widget]#*:}
				eval "_zsh_highlight_widget_${(q)prefix}-${(q)cur_widget}() { _zsh_highlight_call_widget ${(q)prefix}-${(q)cur_widget} -- \"\$@\" }"
				zle -N $cur_widget _zsh_highlight_widget_$prefix-$cur_widget ;;
			(completion:*) zle -C $prefix-$cur_widget ${${(s.:.)widgets[$cur_widget]}[2,3]}
				eval "_zsh_highlight_widget_${(q)prefix}-${(q)cur_widget}() { _zsh_highlight_call_widget ${(q)prefix}-${(q)cur_widget} -- \"\$@\" }"
				zle -N $cur_widget _zsh_highlight_widget_$prefix-$cur_widget ;;
			(builtin) eval "_zsh_highlight_widget_${(q)prefix}-${(q)cur_widget}() { _zsh_highlight_call_widget .${(q)cur_widget} -- \"\$@\" }"
				zle -N $cur_widget _zsh_highlight_widget_$prefix-$cur_widget ;;
			(*) if [[ $cur_widget == zle-* ]] && (( ! ${+widgets[$cur_widget]} ))
				then
					_zsh_highlight_widget_${cur_widget} () {
						:
						_zsh_highlight
					}
					zle -N $cur_widget _zsh_highlight_widget_$cur_widget
				else
					print -r -- "zsh-syntax-highlighting: unhandled ZLE widget ${(qq)cur_widget}" >&2
					print -r -- "zsh-syntax-highlighting: (This is sometimes caused by doing \`bindkey <keys> ${(q-)cur_widget}\` without creating the ${(qq)cur_widget} widget with \`zle -N\` or \`zle -C\`.)" >&2
				fi ;;
		esac
	done
}
_zsh_highlight_brackets_match () {
	case $BUFFER[$1] in
		(\() [[ $BUFFER[$2] == \) ]] ;;
		(\[) [[ $BUFFER[$2] == \] ]] ;;
		(\{) [[ $BUFFER[$2] == \} ]] ;;
		(*) false ;;
	esac
}
_zsh_highlight_buffer_modified () {
	[[ "${_ZSH_HIGHLIGHT_PRIOR_BUFFER:-}" != "$BUFFER" ]]
}
_zsh_highlight_call_widget () {
	builtin zle "$@" && _zsh_highlight
}
_zsh_highlight_cursor_moved () {
	[[ -n $CURSOR ]] && [[ -n ${_ZSH_HIGHLIGHT_PRIOR_CURSOR-} ]] && (($_ZSH_HIGHLIGHT_PRIOR_CURSOR != $CURSOR))
}
_zsh_highlight_highlighter_brackets_paint () {
	local char style
	local -i bracket_color_size=${#ZSH_HIGHLIGHT_STYLES[(I)bracket-level-*]} buflen=${#BUFFER} level=0 matchingpos pos 
	local -A levelpos lastoflevel matching
	pos=0 
	for char in ${(s..)BUFFER}
	do
		(( ++pos ))
		case $char in
			(["([{"]) levelpos[$pos]=$((++level)) 
				lastoflevel[$level]=$pos  ;;
			([")]}"]) if (( level > 0 ))
				then
					matchingpos=$lastoflevel[$level] 
					levelpos[$pos]=$((level--)) 
					if _zsh_highlight_brackets_match $matchingpos $pos
					then
						matching[$matchingpos]=$pos 
						matching[$pos]=$matchingpos 
					fi
				else
					levelpos[$pos]=-1 
				fi ;;
		esac
	done
	for pos in ${(k)levelpos}
	do
		if (( $+matching[$pos] ))
		then
			if (( bracket_color_size ))
			then
				_zsh_highlight_add_highlight $((pos - 1)) $pos bracket-level-$(( (levelpos[$pos] - 1) % bracket_color_size + 1 ))
			fi
		else
			_zsh_highlight_add_highlight $((pos - 1)) $pos bracket-error
		fi
	done
	if [[ $WIDGET != zle-line-finish ]]
	then
		pos=$((CURSOR + 1)) 
		if (( $+levelpos[$pos] )) && (( $+matching[$pos] ))
		then
			local -i otherpos=$matching[$pos] 
			_zsh_highlight_add_highlight $((otherpos - 1)) $otherpos cursor-matchingbracket
		fi
	fi
}
_zsh_highlight_highlighter_brackets_predicate () {
	[[ $WIDGET == zle-line-finish ]] || _zsh_highlight_cursor_moved || _zsh_highlight_buffer_modified
}
_zsh_highlight_highlighter_cursor_paint () {
	[[ $WIDGET == zle-line-finish ]] && return
	_zsh_highlight_add_highlight $CURSOR $(( $CURSOR + 1 )) cursor
}
_zsh_highlight_highlighter_cursor_predicate () {
	[[ $WIDGET == zle-line-finish ]] || _zsh_highlight_cursor_moved
}
_zsh_highlight_highlighter_line_paint () {
	_zsh_highlight_add_highlight 0 $#BUFFER line
}
_zsh_highlight_highlighter_line_predicate () {
	_zsh_highlight_buffer_modified
}
_zsh_highlight_highlighter_main_paint () {
	setopt localoptions extendedglob
	if [[ $CONTEXT == (select|vared) ]]
	then
		return
	fi
	typeset -a ZSH_HIGHLIGHT_TOKENS_COMMANDSEPARATOR
	typeset -a ZSH_HIGHLIGHT_TOKENS_CONTROL_FLOW
	local -a options_to_set reply
	local REPLY
	local flags_with_argument
	local flags_sans_argument
	local flags_solo
	local -A precommand_options
	precommand_options=('-' '' 'builtin' '' 'command' :pvV 'exec' a:cl 'noglob' '' 'doas' aCu:Lns 'nice' n: 'pkexec' '' 'sudo' Cgprtu:AEHPSbilns:eKkVv 'stdbuf' ioe: 'eatmydata' '' 'catchsegv' '' 'nohup' '' 'setsid' :wc 'env' u:i 'ionice' cn:t:pPu 'strace' IbeaosXPpEuOS:ACdfhikqrtTvVxyDc 'proxychains' q:f 'ssh-agent' aEPt:csDd:k 'tabbed' gnprtTuU:cdfhs:v 'chronic' :ev 'ifne' :n 'grc' :se) 
	if [[ $zsyh_user_options[ignorebraces] == on || ${zsyh_user_options[ignoreclosebraces]:-off} == on ]]
	then
		local right_brace_is_recognised_everywhere=false 
	else
		local right_brace_is_recognised_everywhere=true 
	fi
	if [[ $zsyh_user_options[pathdirs] == on ]]
	then
		options_to_set+=(PATH_DIRS) 
	fi
	ZSH_HIGHLIGHT_TOKENS_COMMANDSEPARATOR=('|' '||' ';' '&' '&&' $'\n' '|&' '&!' '&|') 
	ZSH_HIGHLIGHT_TOKENS_CONTROL_FLOW=($'\x7b' $'\x28' '()' 'while' 'until' 'if' 'then' 'elif' 'else' 'do' 'time' 'coproc' '!') 
	if (( $+X_ZSH_HIGHLIGHT_DIRS_BLACKLIST ))
	then
		print 'zsh-syntax-highlighting: X_ZSH_HIGHLIGHT_DIRS_BLACKLIST is deprecated. Please use ZSH_HIGHLIGHT_DIRS_BLACKLIST.' >&2
		ZSH_HIGHLIGHT_DIRS_BLACKLIST=($X_ZSH_HIGHLIGHT_DIRS_BLACKLIST) 
		unset X_ZSH_HIGHLIGHT_DIRS_BLACKLIST
	fi
	_zsh_highlight_main_highlighter_highlight_list -$#PREBUFFER '' 1 "$PREBUFFER$BUFFER"
	local start end_ style
	for start end_ style in $reply
	do
		(( start >= end_ )) && {
			print -r -- "zsh-syntax-highlighting: BUG: _zsh_highlight_highlighter_main_paint: start($start) >= end($end_)" >&2
			return
		}
		(( end_ <= 0 )) && continue
		(( start < 0 )) && start=0 
		_zsh_highlight_main_calculate_fallback $style
		_zsh_highlight_add_highlight $start $end_ $reply
	done
}
_zsh_highlight_highlighter_main_predicate () {
	[[ $WIDGET == zle-line-finish ]] || _zsh_highlight_buffer_modified
}
_zsh_highlight_highlighter_pattern_paint () {
	setopt localoptions extendedglob
	local pattern
	for pattern in ${(k)ZSH_HIGHLIGHT_PATTERNS}
	do
		_zsh_highlight_pattern_highlighter_loop "$BUFFER" "$pattern"
	done
}
_zsh_highlight_highlighter_pattern_predicate () {
	_zsh_highlight_buffer_modified
}
_zsh_highlight_highlighter_regexp_paint () {
	setopt localoptions extendedglob
	local pattern
	for pattern in ${(k)ZSH_HIGHLIGHT_REGEXP}
	do
		_zsh_highlight_regexp_highlighter_loop "$BUFFER" "$pattern"
	done
}
_zsh_highlight_highlighter_regexp_predicate () {
	_zsh_highlight_buffer_modified
}
_zsh_highlight_highlighter_root_paint () {
	if (( EUID == 0 ))
	then
		_zsh_highlight_add_highlight 0 $#BUFFER root
	fi
}
_zsh_highlight_highlighter_root_predicate () {
	_zsh_highlight_buffer_modified
}
_zsh_highlight_load_highlighters () {
	setopt localoptions noksharrays bareglobqual
	[[ -d "$1" ]] || {
		print -r -- "zsh-syntax-highlighting: highlighters directory ${(qq)1} not found." >&2
		return 1
	}
	local highlighter highlighter_dir
	for highlighter_dir in $1/*/(/)
	do
		highlighter="${highlighter_dir:t}" 
		[[ -f "$highlighter_dir${highlighter}-highlighter.zsh" ]] && . "$highlighter_dir${highlighter}-highlighter.zsh"
		if type "_zsh_highlight_highlighter_${highlighter}_paint" &> /dev/null && type "_zsh_highlight_highlighter_${highlighter}_predicate" &> /dev/null
		then
			
		elif type "_zsh_highlight_${highlighter}_highlighter" &> /dev/null && type "_zsh_highlight_${highlighter}_highlighter_predicate" &> /dev/null
		then
			if false
			then
				print -r -- "zsh-syntax-highlighting: warning: ${(qq)highlighter} highlighter uses deprecated entry point names; please ask its maintainer to update it: https://github.com/zsh-users/zsh-syntax-highlighting/issues/329" >&2
			fi
			eval "_zsh_highlight_highlighter_${(q)highlighter}_paint() { _zsh_highlight_${(q)highlighter}_highlighter \"\$@\" }"
			eval "_zsh_highlight_highlighter_${(q)highlighter}_predicate() { _zsh_highlight_${(q)highlighter}_highlighter_predicate \"\$@\" }"
		else
			print -r -- "zsh-syntax-highlighting: ${(qq)highlighter} highlighter should define both required functions '_zsh_highlight_highlighter_${highlighter}_paint' and '_zsh_highlight_highlighter_${highlighter}_predicate' in ${(qq):-"$highlighter_dir${highlighter}-highlighter.zsh"}." >&2
		fi
	done
}
_zsh_highlight_main__is_global_alias () {
	if zmodload -e zsh/parameter
	then
		(( ${+galiases[$arg]} ))
	elif [[ $arg == '='* ]]
	then
		return 1
	else
		alias -L -g -- "$1" > /dev/null
	fi
}
_zsh_highlight_main__is_redirection () {
	[[ $1 == (<0-9>|)(\<|\>)* ]] && [[ $1 != (\<|\>)$'\x28'* ]] && [[ $1 != *'<'*'-'*'>'* ]]
}
_zsh_highlight_main__is_runnable () {
	if _zsh_highlight_main__type "$1"
	then
		[[ $REPLY != none ]]
	else
		return 2
	fi
}
_zsh_highlight_main__precmd_hook () {
	setopt localoptions
	if eval '[[ -o warnnestedvar ]]' 2> /dev/null
	then
		unsetopt warnnestedvar
	fi
	_zsh_highlight_main__command_type_cache=() 
}
_zsh_highlight_main__resolve_alias () {
	if zmodload -e zsh/parameter
	then
		REPLY=${aliases[$arg]} 
	else
		REPLY="${"$(alias -- $arg)"#*=}" 
	fi
}
_zsh_highlight_main__stack_pop () {
	if [[ $braces_stack[1] == $1 ]]
	then
		braces_stack=${braces_stack:1} 
		if (( $+2 ))
		then
			style=$2 
		fi
		return 0
	else
		style=unknown-token 
		return 1
	fi
}
_zsh_highlight_main__type () {
	integer -r aliases_allowed=${2-1} 
	integer may_cache=1 
	if (( $+_zsh_highlight_main__command_type_cache ))
	then
		REPLY=$_zsh_highlight_main__command_type_cache[(e)$1] 
		if [[ -n "$REPLY" ]]
		then
			return
		fi
	fi
	if (( $#options_to_set ))
	then
		setopt localoptions $options_to_set
	fi
	unset REPLY
	if zmodload -e zsh/parameter
	then
		if (( $+aliases[(e)$1] ))
		then
			may_cache=0 
		fi
		if (( ${+galiases[(e)$1]} )) && (( aliases_allowed ))
		then
			REPLY='global alias' 
		elif (( $+aliases[(e)$1] )) && (( aliases_allowed ))
		then
			REPLY=alias 
		elif [[ $1 == *.* && -n ${1%.*} ]] && (( $+saliases[(e)${1##*.}] ))
		then
			REPLY='suffix alias' 
		elif (( $reswords[(Ie)$1] ))
		then
			REPLY=reserved 
		elif (( $+functions[(e)$1] ))
		then
			REPLY=function 
		elif (( $+builtins[(e)$1] ))
		then
			REPLY=builtin 
		elif (( $+commands[(e)$1] ))
		then
			REPLY=command 
		elif {
				[[ $1 != */* ]] || is-at-least 5.3
			} && ! (
				builtin type -w -- "$1"
			) > /dev/null 2>&1
		then
			REPLY=none 
		fi
	fi
	if ! (( $+REPLY ))
	then
		REPLY="${$(:; (( aliases_allowed )) || unalias -- "$1" 2>/dev/null; LC_ALL=C builtin type -w -- "$1" 2>/dev/null)##*: }" 
		if [[ $REPLY == 'alias' ]]
		then
			may_cache=0 
		fi
	fi
	if (( may_cache )) && (( $+_zsh_highlight_main__command_type_cache ))
	then
		_zsh_highlight_main__command_type_cache[(e)$1]=$REPLY 
	fi
	[[ -n $REPLY ]]
	return $?
}
_zsh_highlight_main_add_many_region_highlights () {
	for 1 2 3
	do
		_zsh_highlight_main_add_region_highlight $1 $2 $3
	done
}
_zsh_highlight_main_add_region_highlight () {
	integer start=$1 end=$2 
	shift 2
	if (( $#in_alias ))
	then
		[[ $1 == unknown-token ]] && alias_style=unknown-token 
		return
	fi
	if (( in_param ))
	then
		if [[ $1 == unknown-token ]]
		then
			param_style=unknown-token 
		fi
		if [[ -n $param_style ]]
		then
			return
		fi
		param_style=$1 
		return
	fi
	(( start += buf_offset ))
	(( end += buf_offset ))
	list_highlights+=($start $end $1) 
}
_zsh_highlight_main_calculate_fallback () {
	local -A fallback_of
	fallback_of=(alias arg0 suffix-alias arg0 global-alias dollar-double-quoted-argument builtin arg0 function arg0 command arg0 precommand arg0 hashed-command arg0 autodirectory arg0 arg0_\* arg0 path_prefix path path_pathseparator path path_prefix_pathseparator path_prefix single-quoted-argument{-unclosed,} double-quoted-argument{-unclosed,} dollar-quoted-argument{-unclosed,} back-quoted-argument{-unclosed,} command-substitution{-quoted,,-unquoted,} command-substitution-delimiter{-quoted,,-unquoted,} command-substitution{-delimiter,} process-substitution{-delimiter,} back-quoted-argument{-delimiter,}) 
	local needle=$1 value 
	reply=($1) 
	while [[ -n ${value::=$fallback_of[(k)$needle]} ]]
	do
		unset "fallback_of[$needle]"
		reply+=($value) 
		needle=$value 
	done
}
_zsh_highlight_main_highlighter__try_expand_parameter () {
	local arg="$1" 
	unset reply
	{
		{
			local -a match mbegin mend
			local MATCH
			integer MBEGIN MEND
			local parameter_name
			local -a words
			if [[ $arg[1] != '$' ]]
			then
				return 1
			fi
			if [[ ${arg[2]} == '{' ]] && [[ ${arg[-1]} == '}' ]]
			then
				parameter_name=${${arg:2}%?} 
			else
				parameter_name=${arg:1} 
			fi
			if [[ $res == none ]] && [[ ${parameter_name} =~ ^${~parameter_name_pattern}$ ]] && [[ ${(tP)MATCH} != *special* ]]
			then
				case ${(tP)MATCH} in
					(*array*|*assoc*) words=(${(P)MATCH})  ;;
					("") words=()  ;;
					(*) if [[ $zsyh_user_options[shwordsplit] == on ]]
						then
							words=(${(P)=MATCH}) 
						else
							words=(${(P)MATCH}) 
						fi ;;
				esac
				reply=("${words[@]}") 
			else
				return 1
			fi
		}
	}
}
_zsh_highlight_main_highlighter_check_assign () {
	setopt localoptions extended_glob
	[[ $arg == [[:alpha:]_][[:alnum:]_]#(|\[*\])(|[+])=* ]] || [[ $arg == [0-9]##(|[+])=* ]]
}
_zsh_highlight_main_highlighter_check_path () {
	_zsh_highlight_main_highlighter_expand_path "$1"
	local expanded_path="$REPLY" tmp_path 
	integer in_command_position=$2 
	if [[ $zsyh_user_options[autocd] == on ]]
	then
		integer autocd=1 
	else
		integer autocd=0 
	fi
	if (( in_command_position ))
	then
		REPLY=arg0 
	else
		REPLY=path 
	fi
	if [[ ${1[1]} == '=' && $1 == ??* && ${1[2]} != $'\x28' && $zsyh_user_options[equals] == 'on' && $expanded_path[1] != '/' ]]
	then
		REPLY=unknown-token 
		return 0
	fi
	[[ -z $expanded_path ]] && return 1
	if [[ $expanded_path[1] == / ]]
	then
		tmp_path=$expanded_path 
	else
		tmp_path=$PWD/$expanded_path 
	fi
	tmp_path=$tmp_path:a 
	while [[ $tmp_path != / ]]
	do
		[[ -n ${(M)ZSH_HIGHLIGHT_DIRS_BLACKLIST:#$tmp_path} ]] && return 1
		tmp_path=$tmp_path:h 
	done
	if (( in_command_position ))
	then
		if [[ -x $expanded_path ]]
		then
			if (( autocd ))
			then
				if [[ -d $expanded_path ]]
				then
					REPLY=autodirectory 
				fi
				return 0
			elif [[ ! -d $expanded_path ]]
			then
				return 0
			fi
		fi
	else
		if [[ -L $expanded_path || -e $expanded_path ]]
		then
			return 0
		fi
	fi
	if [[ $expanded_path != /* ]] && (( autocd || ! in_command_position ))
	then
		local cdpath_dir
		for cdpath_dir in $cdpath
		do
			if [[ -d "$cdpath_dir/$expanded_path" && -x "$cdpath_dir/$expanded_path" ]]
			then
				if (( in_command_position && autocd ))
				then
					REPLY=autodirectory 
				fi
				return 0
			fi
		done
	fi
	[[ ! -d ${expanded_path:h} ]] && return 1
	if (( has_end && (len == end_pos) )) && (( ! $#in_alias )) && [[ $WIDGET != zle-line-finish ]]
	then
		local -a tmp
		if (( in_command_position ))
		then
			tmp=(${expanded_path}*(N-*,N-/)) 
		else
			tmp=(${expanded_path}*(N)) 
		fi
		(( ${+tmp[1]} )) && REPLY=path_prefix  && return 0
	fi
	return 1
}
_zsh_highlight_main_highlighter_expand_path () {
	(( $# == 1 )) || print -r -- "zsh-syntax-highlighting: BUG: _zsh_highlight_main_highlighter_expand_path: called without argument" >&2
	setopt localoptions nonomatch
	unset REPLY
	: ${REPLY:=${(Q)${~1}}}
}
_zsh_highlight_main_highlighter_highlight_argument () {
	local base_style=default i=$1 option_eligible=${2:-1} path_eligible=1 ret start style 
	local -a highlights
	local -a match mbegin mend
	local MATCH
	integer MBEGIN MEND
	case "$arg[i]" in
		('%') if [[ $arg[i+1] == '?' ]]
			then
				(( i += 2 ))
			fi ;;
		('-') if (( option_eligible ))
			then
				if [[ $arg[i+1] == - ]]
				then
					base_style=double-hyphen-option 
				else
					base_style=single-hyphen-option 
				fi
				path_eligible=0 
			fi ;;
		('=') if [[ $arg[i+1] == $'\x28' ]]
			then
				(( i += 2 ))
				_zsh_highlight_main_highlighter_highlight_list $(( start_pos + i - 1 )) S $has_end $arg[i,-1]
				ret=$? 
				(( i += REPLY ))
				highlights+=($(( start_pos + $1 - 1 )) $(( start_pos + i )) process-substitution $(( start_pos + $1 - 1 )) $(( start_pos + $1 + 1 )) process-substitution-delimiter $reply) 
				if (( ret == 0 ))
				then
					highlights+=($(( start_pos + i - 1 )) $(( start_pos + i )) process-substitution-delimiter) 
				fi
			fi ;;
	esac
	(( --i ))
	while (( ++i <= $#arg ))
	do
		i=${arg[(ib.i.)[\\\'\"\`\$\<\>\*\?]]} 
		case "$arg[$i]" in
			("") break ;;
			("\\") (( i += 1 ))
				continue ;;
			("'") _zsh_highlight_main_highlighter_highlight_single_quote $i
				(( i = REPLY ))
				highlights+=($reply)  ;;
			('"') _zsh_highlight_main_highlighter_highlight_double_quote $i
				(( i = REPLY ))
				highlights+=($reply)  ;;
			('`') _zsh_highlight_main_highlighter_highlight_backtick $i
				(( i = REPLY ))
				highlights+=($reply)  ;;
			('$') if [[ $arg[i+1] != "'" ]]
				then
					path_eligible=0 
				fi
				if [[ $arg[i+1] == "'" ]]
				then
					_zsh_highlight_main_highlighter_highlight_dollar_quote $i
					(( i = REPLY ))
					highlights+=($reply) 
					continue
				elif [[ $arg[i+1] == $'\x28' ]]
				then
					if [[ $arg[i+2] == $'\x28' ]] && _zsh_highlight_main_highlighter_highlight_arithmetic $i
					then
						(( i = REPLY ))
						highlights+=($reply) 
						continue
					fi
					start=$i 
					(( i += 2 ))
					_zsh_highlight_main_highlighter_highlight_list $(( start_pos + i - 1 )) S $has_end $arg[i,-1]
					ret=$? 
					(( i += REPLY ))
					highlights+=($(( start_pos + start - 1)) $(( start_pos + i )) command-substitution-unquoted $(( start_pos + start - 1)) $(( start_pos + start + 1)) command-substitution-delimiter-unquoted $reply) 
					if (( ret == 0 ))
					then
						highlights+=($(( start_pos + i - 1)) $(( start_pos + i )) command-substitution-delimiter-unquoted) 
					fi
					continue
				fi
				while [[ $arg[i+1] == [=~#+'^'] ]]
				do
					(( i += 1 ))
				done
				if [[ $arg[i+1] == [*@#?$!-] ]]
				then
					(( i += 1 ))
				fi ;;
			([\<\>]) if [[ $arg[i+1] == $'\x28' ]]
				then
					start=$i 
					(( i += 2 ))
					_zsh_highlight_main_highlighter_highlight_list $(( start_pos + i - 1 )) S $has_end $arg[i,-1]
					ret=$? 
					(( i += REPLY ))
					highlights+=($(( start_pos + start - 1)) $(( start_pos + i )) process-substitution $(( start_pos + start - 1)) $(( start_pos + start + 1 )) process-substitution-delimiter $reply) 
					if (( ret == 0 ))
					then
						highlights+=($(( start_pos + i - 1)) $(( start_pos + i )) process-substitution-delimiter) 
					fi
					continue
				fi ;|
			(*) if $highlight_glob && [[ $zsyh_user_options[multios] == on || $in_redirection -eq 0 ]] && [[ ${arg[$i]} =~ ^[*?] || ${arg:$i-1} =~ ^\<[0-9]*-[0-9]*\> ]]
				then
					highlights+=($(( start_pos + i - 1 )) $(( start_pos + i + $#MATCH - 1)) globbing) 
					(( i += $#MATCH - 1 ))
					path_eligible=0 
				else
					continue
				fi ;;
		esac
	done
	if (( path_eligible ))
	then
		if (( in_redirection )) && [[ $last_arg == *['<>']['&'] && $arg[$1,-1] == (<0->|p|-) ]]
		then
			if [[ $arg[$1,-1] == (p|-) ]]
			then
				base_style=redirection 
			else
				base_style=numeric-fd 
			fi
		elif _zsh_highlight_main_highlighter_check_path $arg[$1,-1] 0
		then
			base_style=$REPLY 
			_zsh_highlight_main_highlighter_highlight_path_separators $base_style
			highlights+=($reply) 
		fi
	fi
	highlights=($(( start_pos + $1 - 1 )) $end_pos $base_style $highlights) 
	_zsh_highlight_main_add_many_region_highlights $highlights
}
_zsh_highlight_main_highlighter_highlight_arithmetic () {
	local -a saved_reply
	local style
	integer i j k paren_depth ret
	reply=() 
	for ((i = $1 + 3 ; i <= end_pos - start_pos ; i += 1 )) do
		(( j = i + start_pos - 1 ))
		(( k = j + 1 ))
		case "$arg[$i]" in
			([\'\"\\@{}]) style=unknown-token  ;;
			('(') (( paren_depth++ ))
				continue ;;
			(')') if (( paren_depth ))
				then
					(( paren_depth-- ))
					continue
				fi
				[[ $arg[i+1] == ')' ]] && {
					(( i++ ))
					break
				}
				(( has_end && (len == k) )) && break
				return 1 ;;
			('`') saved_reply=($reply) 
				_zsh_highlight_main_highlighter_highlight_backtick $i
				(( i = REPLY ))
				reply=($saved_reply $reply) 
				continue ;;
			('$') if [[ $arg[i+1] == $'\x28' ]]
				then
					saved_reply=($reply) 
					if [[ $arg[i+2] == $'\x28' ]] && _zsh_highlight_main_highlighter_highlight_arithmetic $i
					then
						(( i = REPLY ))
						reply=($saved_reply $reply) 
						continue
					fi
					(( i += 2 ))
					_zsh_highlight_main_highlighter_highlight_list $(( start_pos + i - 1 )) S $has_end $arg[i,end_pos]
					ret=$? 
					(( i += REPLY ))
					reply=($saved_reply $j $(( start_pos + i )) command-substitution-quoted $j $(( j + 2 )) command-substitution-delimiter-quoted $reply) 
					if (( ret == 0 ))
					then
						reply+=($(( start_pos + i - 1 )) $(( start_pos + i )) command-substitution-delimiter) 
					fi
					continue
				else
					continue
				fi ;;
			($histchars[1]) if [[ $arg[i+1] != ('='|$'\x28'|$'\x7b'|[[:blank:]]) ]]
				then
					style=history-expansion 
				else
					continue
				fi ;;
			(*) continue ;;
		esac
		reply+=($j $k $style) 
	done
	if [[ $arg[i] != ')' ]]
	then
		(( i-- ))
	fi
	style=arithmetic-expansion 
	reply=($(( start_pos + $1 - 1)) $(( start_pos + i )) arithmetic-expansion $reply) 
	REPLY=$i 
}
_zsh_highlight_main_highlighter_highlight_backtick () {
	local buf highlight style=back-quoted-argument-unclosed style_end 
	local -i arg1=$1 end_ i=$1 last offset=0 start subshell_has_end=0 
	local -a highlight_zone highlights offsets
	reply=() 
	last=$(( arg1 + 1 )) 
	while i=$arg[(ib:i+1:)[\\\\\`]] 
	do
		if (( i > $#arg ))
		then
			buf=$buf$arg[last,i] 
			offsets[i-arg1-offset]='' 
			(( i-- ))
			subshell_has_end=$(( has_end && (start_pos + i == len) )) 
			break
		fi
		if [[ $arg[i] == '\' ]]
		then
			(( i++ ))
			if [[ $arg[i] == ('$'|'`'|'\') ]]
			then
				buf=$buf$arg[last,i-2] 
				(( offset++ ))
				offsets[i-arg1-offset]=$offset 
			else
				buf=$buf$arg[last,i-1] 
			fi
		else
			style=back-quoted-argument 
			style_end=back-quoted-argument-delimiter 
			buf=$buf$arg[last,i-1] 
			offsets[i-arg1-offset]='' 
			break
		fi
		last=$i 
	done
	_zsh_highlight_main_highlighter_highlight_list 0 '' $subshell_has_end $buf
	for start end_ highlight in $reply
	do
		start=$(( start_pos + arg1 + start + offsets[(Rb:start:)?*] )) 
		end_=$(( start_pos + arg1 + end_ + offsets[(Rb:end_:)?*] )) 
		highlights+=($start $end_ $highlight) 
		if [[ $highlight == back-quoted-argument-unclosed && $style == back-quoted-argument ]]
		then
			style_end=unknown-token 
		fi
	done
	reply=($(( start_pos + arg1 - 1 )) $(( start_pos + i )) $style $(( start_pos + arg1 - 1 )) $(( start_pos + arg1 )) back-quoted-argument-delimiter $highlights) 
	if (( $#style_end ))
	then
		reply+=($(( start_pos + i - 1)) $(( start_pos + i )) $style_end) 
	fi
	REPLY=$i 
}
_zsh_highlight_main_highlighter_highlight_dollar_quote () {
	local -a match mbegin mend
	local MATCH
	integer MBEGIN MEND
	local i j k style
	local AA
	integer c
	reply=() 
	for ((i = $1 + 2 ; i <= $#arg ; i += 1 )) do
		(( j = i + start_pos - 1 ))
		(( k = j + 1 ))
		case "$arg[$i]" in
			("'") break ;;
			("\\") style=back-dollar-quoted-argument 
				for ((c = i + 1 ; c <= $#arg ; c += 1 )) do
					[[ "$arg[$c]" != ([0-9xXuUa-fA-F]) ]] && break
				done
				AA=$arg[$i+1,$c-1] 
				if [[ "$AA" =~ "^(x|X)[0-9a-fA-F]{1,2}" || "$AA" =~ "^[0-7]{1,3}" || "$AA" =~ "^u[0-9a-fA-F]{1,4}" || "$AA" =~ "^U[0-9a-fA-F]{1,8}" ]]
				then
					(( k += $#MATCH ))
					(( i += $#MATCH ))
				else
					if (( $#arg > $i+1 )) && [[ $arg[$i+1] == [xXuU] ]]
					then
						style=unknown-token 
					fi
					(( k += 1 ))
					(( i += 1 ))
				fi ;;
			(*) continue ;;
		esac
		reply+=($j $k $style) 
	done
	if [[ $arg[i] == "'" ]]
	then
		style=dollar-quoted-argument 
	else
		(( i-- ))
		style=dollar-quoted-argument-unclosed 
	fi
	reply=($(( start_pos + $1 - 1 )) $(( start_pos + i )) $style $reply) 
	REPLY=$i 
}
_zsh_highlight_main_highlighter_highlight_double_quote () {
	local -a breaks match mbegin mend saved_reply
	local MATCH
	integer last_break=$(( start_pos + $1 - 1 )) MBEGIN MEND 
	local i j k ret style
	reply=() 
	for ((i = $1 + 1 ; i <= $#arg ; i += 1 )) do
		(( j = i + start_pos - 1 ))
		(( k = j + 1 ))
		case "$arg[$i]" in
			('"') break ;;
			('`') saved_reply=($reply) 
				_zsh_highlight_main_highlighter_highlight_backtick $i
				(( i = REPLY ))
				reply=($saved_reply $reply) 
				continue ;;
			('$') style=dollar-double-quoted-argument 
				if [[ ${arg:$i} =~ ^([A-Za-z_][A-Za-z0-9_]*|[0-9]+) ]]
				then
					(( k += $#MATCH ))
					(( i += $#MATCH ))
				elif [[ ${arg:$i} =~ ^[{]([A-Za-z_][A-Za-z0-9_]*|[0-9]+)[}] ]]
				then
					(( k += $#MATCH ))
					(( i += $#MATCH ))
				elif [[ $arg[i+1] == '$' ]]
				then
					(( k += 1 ))
					(( i += 1 ))
				elif [[ $arg[i+1] == [-#*@?] ]]
				then
					(( k += 1 ))
					(( i += 1 ))
				elif [[ $arg[i+1] == $'\x28' ]]
				then
					saved_reply=($reply) 
					if [[ $arg[i+2] == $'\x28' ]] && _zsh_highlight_main_highlighter_highlight_arithmetic $i
					then
						(( i = REPLY ))
						reply=($saved_reply $reply) 
						continue
					fi
					breaks+=($last_break $(( start_pos + i - 1 ))) 
					(( i += 2 ))
					_zsh_highlight_main_highlighter_highlight_list $(( start_pos + i - 1 )) S $has_end $arg[i,-1]
					ret=$? 
					(( i += REPLY ))
					last_break=$(( start_pos + i )) 
					reply=($saved_reply $j $(( start_pos + i )) command-substitution-quoted $j $(( j + 2 )) command-substitution-delimiter-quoted $reply) 
					if (( ret == 0 ))
					then
						reply+=($(( start_pos + i - 1 )) $(( start_pos + i )) command-substitution-delimiter-quoted) 
					fi
					continue
				else
					continue
				fi ;;
			("\\") style=back-double-quoted-argument 
				if [[ \\\`\"\$${histchars[1]} == *$arg[$i+1]* ]]
				then
					(( k += 1 ))
					(( i += 1 ))
				else
					continue
				fi ;;
			($histchars[1]) if [[ $arg[i+1] != ('='|$'\x28'|$'\x7b'|[[:blank:]]) ]]
				then
					style=history-expansion 
				else
					continue
				fi ;;
			(*) continue ;;
		esac
		reply+=($j $k $style) 
	done
	if [[ $arg[i] == '"' ]]
	then
		style=double-quoted-argument 
	else
		(( i-- ))
		style=double-quoted-argument-unclosed 
	fi
	(( last_break != start_pos + i )) && breaks+=($last_break $(( start_pos + i ))) 
	saved_reply=($reply) 
	reply=() 
	for 1 2 in $breaks
	do
		(( $1 != $2 )) && reply+=($1 $2 $style) 
	done
	reply+=($saved_reply) 
	REPLY=$i 
}
_zsh_highlight_main_highlighter_highlight_list () {
	integer start_pos end_pos=0 buf_offset=$1 has_end=$3 
	local alias_style param_style last_arg arg buf=$4 highlight_glob=true saw_assignment=false style 
	local in_array_assignment=false 
	integer in_param=0 len=$#buf 
	local -a in_alias match mbegin mend list_highlights
	local -A seen_alias
	readonly parameter_name_pattern='([A-Za-z_][A-Za-z0-9_]*|[0-9]+)' 
	list_highlights=() 
	local braces_stack=$2 
	local this_word next_word=':start::start_of_pipeline:' 
	integer in_redirection
	local proc_buf="$buf" 
	local -a args
	if [[ $zsyh_user_options[interactivecomments] == on ]]
	then
		args=(${(zZ+c+)buf}) 
	else
		args=(${(z)buf}) 
	fi
	if [[ $braces_stack == 'S' ]] && (( $+args[3] && ! $+args[4] )) && [[ $args[3] == $'\x29' ]] && [[ $args[1] == *'<'* ]] && _zsh_highlight_main__is_redirection $args[1]
	then
		highlight_glob=false 
	fi
	while (( $#args ))
	do
		last_arg=$arg 
		arg=$args[1] 
		shift args
		if (( $#in_alias ))
		then
			(( in_alias[1]-- ))
			in_alias=($in_alias[$in_alias[(i)<1->],-1]) 
			if (( $#in_alias == 0 ))
			then
				seen_alias=() 
				_zsh_highlight_main_add_region_highlight $start_pos $end_pos $alias_style
			else
				() {
					local alias_name
					for alias_name in ${(k)seen_alias[(R)<$#in_alias->]}
					do
						seen_alias=("${(@kv)seen_alias[(I)^$alias_name]}") 
					done
				}
			fi
		fi
		if (( in_param ))
		then
			(( in_param-- ))
			if (( in_param == 0 ))
			then
				_zsh_highlight_main_add_region_highlight $start_pos $end_pos $param_style
				param_style="" 
			fi
		fi
		if (( in_redirection == 0 ))
		then
			this_word=$next_word 
			next_word=':regular:' 
		elif (( !in_param ))
		then
			(( --in_redirection ))
		fi
		style=unknown-token 
		if [[ $this_word == *':start:'* ]]
		then
			in_array_assignment=false 
			if [[ $arg == 'noglob' ]]
			then
				highlight_glob=false 
			fi
		fi
		if (( $#in_alias == 0 && in_param == 0 ))
		then
			[[ "$proc_buf" = (#b)(#s)(''([ $'\t']|[\\]$'\n')#)(?|)* ]]
			integer offset="${#match[1]}" 
			(( start_pos = end_pos + offset ))
			(( end_pos = start_pos + $#arg ))
			[[ $arg == ';' && ${match[3]} == $'\n' ]] && arg=$'\n' 
			proc_buf="${proc_buf[offset + $#arg + 1,len]}" 
		fi
		if [[ $zsyh_user_options[interactivecomments] == on && $arg[1] == $histchars[3] ]]
		then
			if [[ $this_word == *(':regular:'|':start:')* ]]
			then
				style=comment 
			else
				style=unknown-token 
			fi
			_zsh_highlight_main_add_region_highlight $start_pos $end_pos $style
			in_redirection=1 
			continue
		fi
		if [[ $this_word == *':start:'* ]] && ! (( in_redirection ))
		then
			_zsh_highlight_main__type "$arg" "$(( ! ${+seen_alias[$arg]} ))"
			local res="$REPLY" 
			if [[ $res == "alias" ]]
			then
				if [[ $arg == ?*=* ]]
				then
					_zsh_highlight_main_add_region_highlight $start_pos $end_pos unknown-token
					continue
				fi
				seen_alias[$arg]=$#in_alias 
				_zsh_highlight_main__resolve_alias $arg
				local -a alias_args
				if [[ $zsyh_user_options[interactivecomments] == on ]]
				then
					alias_args=(${(zZ+c+)REPLY}) 
				else
					alias_args=(${(z)REPLY}) 
				fi
				args=($alias_args $args) 
				if (( $#in_alias == 0 ))
				then
					alias_style=alias 
				else
					(( in_alias[1]-- ))
				fi
				in_alias=($(($#alias_args + 1)) $in_alias) 
				(( in_redirection++ ))
				continue
			else
				_zsh_highlight_main_highlighter_expand_path $arg
				_zsh_highlight_main__type "$REPLY" 0
				res="$REPLY" 
			fi
		fi
		if _zsh_highlight_main__is_redirection $arg
		then
			if (( in_redirection == 1 ))
			then
				_zsh_highlight_main_add_region_highlight $start_pos $end_pos unknown-token
			else
				in_redirection=2 
				_zsh_highlight_main_add_region_highlight $start_pos $end_pos redirection
			fi
			continue
		elif [[ $arg == '{'${~parameter_name_pattern}'}' ]] && _zsh_highlight_main__is_redirection $args[1]
		then
			in_redirection=3 
			_zsh_highlight_main_add_region_highlight $start_pos $end_pos named-fd
			continue
		fi
		if (( ! in_param )) && _zsh_highlight_main_highlighter__try_expand_parameter "$arg"
		then
			() {
				local -a words
				words=("${reply[@]}") 
				if (( $#words == 0 )) && (( ! in_redirection ))
				then
					(( ++in_redirection ))
					_zsh_highlight_main_add_region_highlight $start_pos $end_pos comment
					continue
				else
					(( in_param = 1 + $#words ))
					args=($words $args) 
					arg=$args[1] 
					_zsh_highlight_main__type "$arg" 0
					res=$REPLY 
				fi
			}
		fi
		if (( ! in_redirection ))
		then
			if [[ $this_word == *':sudo_opt:'* ]]
			then
				if [[ -n $flags_with_argument ]] && {
						if [[ -n $flags_sans_argument ]]
						then
							[[ $arg == '-'[$flags_sans_argument]#[$flags_with_argument] ]]
						else
							[[ $arg == '-'[$flags_with_argument] ]]
						fi
					}
				then
					this_word=${this_word//:start:/} 
					next_word=':sudo_arg:' 
				elif [[ -n $flags_with_argument ]] && {
						if [[ -n $flags_sans_argument ]]
						then
							[[ $arg == '-'[$flags_sans_argument]#[$flags_with_argument]* ]]
						else
							[[ $arg == '-'[$flags_with_argument]* ]]
						fi
					}
				then
					this_word=${this_word//:start:/} 
					next_word+=':start:' 
					next_word+=':sudo_opt:' 
				elif [[ -n $flags_sans_argument ]] && [[ $arg == '-'[$flags_sans_argument]# ]]
				then
					this_word=':sudo_opt:' 
					next_word+=':start:' 
					next_word+=':sudo_opt:' 
				elif [[ -n $flags_solo ]] && {
						if [[ -n $flags_sans_argument ]]
						then
							[[ $arg == '-'[$flags_sans_argument]#[$flags_solo]* ]]
						else
							[[ $arg == '-'[$flags_solo]* ]]
						fi
					}
				then
					this_word=':sudo_opt:' 
					next_word=':regular:' 
				elif [[ $arg == '-'* ]]
				then
					this_word=':sudo_opt:' 
					next_word+=':start:' 
					next_word+=':sudo_opt:' 
				else
					this_word=${this_word//:sudo_opt:/} 
				fi
			elif [[ $this_word == *':sudo_arg:'* ]]
			then
				next_word+=':sudo_opt:' 
				next_word+=':start:' 
			fi
		fi
		if [[ -n ${(M)ZSH_HIGHLIGHT_TOKENS_COMMANDSEPARATOR:#"$arg"} ]] && [[ $braces_stack != *T* || $arg != ('||'|'&&') ]]
		then
			if _zsh_highlight_main__stack_pop T || _zsh_highlight_main__stack_pop Q
			then
				style=unknown-token 
			elif $in_array_assignment
			then
				case $arg in
					($'\n') style=commandseparator  ;;
					(';') style=unknown-token  ;;
					(*) style=unknown-token  ;;
				esac
			elif [[ $this_word == *':regular:'* ]]
			then
				style=commandseparator 
			elif [[ $this_word == *':start:'* ]] && [[ $arg == $'\n' ]]
			then
				style=commandseparator 
			elif [[ $this_word == *':start:'* ]] && [[ $arg == ';' ]] && (( $#in_alias ))
			then
				style=commandseparator 
			else
				style=unknown-token 
			fi
			if [[ $arg == $'\n' ]] && $in_array_assignment
			then
				next_word=':regular:' 
			elif [[ $arg == ';' ]] && $in_array_assignment
			then
				next_word=':regular:' 
			else
				next_word=':start:' 
				highlight_glob=true 
				saw_assignment=false 
				() {
					local alias_name
					for alias_name in ${(k)seen_alias[(R)<$#in_alias->]}
					do
						seen_alias=("${(@kv)seen_alias[(I)^$alias_name]}") 
					done
				}
				if [[ $arg != '|' && $arg != '|&' ]]
				then
					next_word+=':start_of_pipeline:' 
				fi
			fi
		elif ! (( in_redirection)) && [[ $this_word == *':always:'* && $arg == 'always' ]]
		then
			style=reserved-word 
			highlight_glob=true 
			saw_assignment=false 
			next_word=':start::start_of_pipeline:' 
		elif ! (( in_redirection)) && [[ $this_word == *':start:'* ]]
		then
			if (( ${+precommand_options[$arg]} )) && _zsh_highlight_main__is_runnable $arg
			then
				style=precommand 
				() {
					set -- "${(@s.:.)precommand_options[$arg]}"
					flags_with_argument=$1 
					flags_sans_argument=$2 
					flags_solo=$3 
				}
				next_word=${next_word//:regular:/} 
				next_word+=':sudo_opt:' 
				next_word+=':start:' 
				if [[ $arg == 'exec' || $arg == 'env' ]]
				then
					next_word+=':regular:' 
				fi
			else
				case $res in
					(reserved) style=reserved-word 
						case $arg in
							(time|nocorrect) next_word=${next_word//:regular:/} 
								next_word+=':start:'  ;;
							($'\x7b') braces_stack='Y'"$braces_stack"  ;;
							($'\x7d') _zsh_highlight_main__stack_pop 'Y' reserved-word
								if [[ $style == reserved-word ]]
								then
									next_word+=':always:' 
								fi ;;
							($'\x5b\x5b') braces_stack='T'"$braces_stack"  ;;
							('do') braces_stack='D'"$braces_stack"  ;;
							('done') _zsh_highlight_main__stack_pop 'D' reserved-word ;;
							('if') braces_stack=':?'"$braces_stack"  ;;
							('then') _zsh_highlight_main__stack_pop ':' reserved-word ;;
							('elif') if [[ ${braces_stack[1]} == '?' ]]
								then
									braces_stack=':'"$braces_stack" 
								else
									style=unknown-token 
								fi ;;
							('else') if [[ ${braces_stack[1]} == '?' ]]
								then
									:
								else
									style=unknown-token 
								fi ;;
							('fi') _zsh_highlight_main__stack_pop '?' ;;
							('foreach') braces_stack='$'"$braces_stack"  ;;
							('end') _zsh_highlight_main__stack_pop '$' reserved-word ;;
							('repeat') in_redirection=2 
								this_word=':start::regular:'  ;;
							('!') if [[ $this_word != *':start_of_pipeline:'* ]]
								then
									style=unknown-token 
								else
									
								fi ;;
						esac
						if $saw_assignment && [[ $style != unknown-token ]]
						then
							style=unknown-token 
						fi ;;
					('suffix alias') style=suffix-alias  ;;
					('global alias') style=global-alias  ;;
					(alias) : ;;
					(builtin) style=builtin 
						[[ $arg == $'\x5b' ]] && braces_stack='Q'"$braces_stack"  ;;
					(function) style=function  ;;
					(command) style=command  ;;
					(hashed) style=hashed-command  ;;
					(none) if (( ! in_param )) && _zsh_highlight_main_highlighter_check_assign
						then
							_zsh_highlight_main_add_region_highlight $start_pos $end_pos assign
							local i=$(( arg[(i)=] + 1 )) 
							saw_assignment=true 
							if [[ $arg[i] == '(' ]]
							then
								in_array_assignment=true 
								_zsh_highlight_main_add_region_highlight start_pos+i-1 start_pos+i reserved-word
							else
								next_word+=':start:' 
								if (( i <= $#arg ))
								then
									() {
										local highlight_glob=false 
										[[ $zsyh_user_options[globassign] == on ]] && highlight_glob=true 
										_zsh_highlight_main_highlighter_highlight_argument $i
									}
								fi
							fi
							continue
						elif (( ! in_param )) && [[ $arg[0,1] = $histchars[0,1] ]] && (( $#arg[0,2] == 2 ))
						then
							style=history-expansion 
						elif (( ! in_param )) && [[ $arg[0,1] == $histchars[2,2] ]]
						then
							style=history-expansion 
						elif (( ! in_param )) && ! $saw_assignment && [[ $arg[1,2] == '((' ]]
						then
							_zsh_highlight_main_add_region_highlight $start_pos $((start_pos + 2)) reserved-word
							if [[ $arg[-2,-1] == '))' ]]
							then
								_zsh_highlight_main_add_region_highlight $((end_pos - 2)) $end_pos reserved-word
							fi
							continue
						elif (( ! in_param )) && [[ $arg == '()' ]]
						then
							style=reserved-word 
						elif (( ! in_param )) && ! $saw_assignment && [[ $arg == $'\x28' ]]
						then
							style=reserved-word 
							braces_stack='R'"$braces_stack" 
						elif (( ! in_param )) && [[ $arg == $'\x29' ]]
						then
							if _zsh_highlight_main__stack_pop 'S'
							then
								REPLY=$start_pos 
								reply=($list_highlights) 
								return 0
							fi
							_zsh_highlight_main__stack_pop 'R' reserved-word
						else
							if _zsh_highlight_main_highlighter_check_path $arg 1
							then
								style=$REPLY 
							else
								style=unknown-token 
							fi
						fi ;;
					(*) _zsh_highlight_main_add_region_highlight $start_pos $end_pos arg0_$res
						continue ;;
				esac
			fi
			if [[ -n ${(M)ZSH_HIGHLIGHT_TOKENS_CONTROL_FLOW:#"$arg"} ]]
			then
				next_word=':start::start_of_pipeline:' 
			fi
		elif _zsh_highlight_main__is_global_alias "$arg"
		then
			style=global-alias 
		else
			case $arg in
				($'\x29') if $in_array_assignment
					then
						_zsh_highlight_main_add_region_highlight $start_pos $end_pos assign
						_zsh_highlight_main_add_region_highlight $start_pos $end_pos reserved-word
						in_array_assignment=false 
						next_word+=':start:' 
						continue
					elif (( in_redirection ))
					then
						style=unknown-token 
					else
						if _zsh_highlight_main__stack_pop 'S'
						then
							REPLY=$start_pos 
							reply=($list_highlights) 
							return 0
						fi
						_zsh_highlight_main__stack_pop 'R' reserved-word
					fi ;;
				($'\x28\x29') if (( in_redirection )) || $in_array_assignment
					then
						style=unknown-token 
					else
						if [[ $zsyh_user_options[multifuncdef] == on ]] || false
						then
							next_word+=':start::start_of_pipeline:' 
						fi
						style=reserved-word 
					fi ;;
				(*) if false
					then
						
					elif [[ $arg = $'\x7d' ]] && $right_brace_is_recognised_everywhere
					then
						if (( in_redirection )) || $in_array_assignment
						then
							style=unknown-token 
						else
							_zsh_highlight_main__stack_pop 'Y' reserved-word
							if [[ $style == reserved-word ]]
							then
								next_word+=':always:' 
							fi
						fi
					elif [[ $arg[0,1] = $histchars[0,1] ]] && (( $#arg[0,2] == 2 ))
					then
						style=history-expansion 
					elif [[ $arg == $'\x5d\x5d' ]] && _zsh_highlight_main__stack_pop 'T' reserved-word
					then
						:
					elif [[ $arg == $'\x5d' ]] && _zsh_highlight_main__stack_pop 'Q' builtin
					then
						:
					else
						_zsh_highlight_main_highlighter_highlight_argument 1 $(( 1 != in_redirection ))
						continue
					fi ;;
			esac
		fi
		_zsh_highlight_main_add_region_highlight $start_pos $end_pos $style
	done
	(( $#in_alias )) && in_alias=() _zsh_highlight_main_add_region_highlight $start_pos $end_pos $alias_style
	(( in_param == 1 )) && in_param=0 _zsh_highlight_main_add_region_highlight $start_pos $end_pos $param_style
	[[ "$proc_buf" = (#b)(#s)(([[:space:]]|\\$'\n')#) ]]
	REPLY=$(( end_pos + ${#match[1]} - 1 )) 
	reply=($list_highlights) 
	return $(( $#braces_stack > 0 ))
}
_zsh_highlight_main_highlighter_highlight_path_separators () {
	local pos style_pathsep
	style_pathsep=$1_pathseparator 
	reply=() 
	[[ -z "$ZSH_HIGHLIGHT_STYLES[$style_pathsep]" || "$ZSH_HIGHLIGHT_STYLES[$1]" == "$ZSH_HIGHLIGHT_STYLES[$style_pathsep]" ]] && return 0
	for ((pos = start_pos; $pos <= end_pos; pos++ )) do
		if [[ $BUFFER[pos] == / ]]
		then
			reply+=($((pos - 1)) $pos $style_pathsep) 
		fi
	done
}
_zsh_highlight_main_highlighter_highlight_single_quote () {
	local arg1=$1 i q=\' style 
	i=$arg[(ib:arg1+1:)$q] 
	reply=() 
	if [[ $zsyh_user_options[rcquotes] == on ]]
	then
		while [[ $arg[i+1] == "'" ]]
		do
			reply+=($(( start_pos + i - 1 )) $(( start_pos + i + 1 )) rc-quote) 
			(( i++ ))
			i=$arg[(ib:i+1:)$q] 
		done
	fi
	if [[ $arg[i] == "'" ]]
	then
		style=single-quoted-argument 
	else
		(( i-- ))
		style=single-quoted-argument-unclosed 
	fi
	reply=($(( start_pos + arg1 - 1 )) $(( start_pos + i )) $style $reply) 
	REPLY=$i 
}
_zsh_highlight_pattern_highlighter_loop () {
	local buf="$1" pat="$2" 
	local -a match mbegin mend
	local MATCH
	integer MBEGIN MEND
	if [[ "$buf" == (#b)(*)(${~pat})* ]]
	then
		region_highlight+=("$((mbegin[2] - 1)) $mend[2] $ZSH_HIGHLIGHT_PATTERNS[$pat], memo=zsh-syntax-highlighting") 
		"$0" "$match[1]" "$pat"
		return $?
	fi
}
_zsh_highlight_preexec_hook () {
	typeset -g _ZSH_HIGHLIGHT_PRIOR_BUFFER= 
	typeset -gi _ZSH_HIGHLIGHT_PRIOR_CURSOR= 
}
_zsh_highlight_regexp_highlighter_loop () {
	local buf="$1" pat="$2" 
	integer OFFSET=0 
	local MATCH
	integer MBEGIN MEND
	local -a match mbegin mend
	while true
	do
		[[ "$buf" =~ "$pat" ]] || return
		region_highlight+=("$((MBEGIN - 1 + OFFSET)) $((MEND + OFFSET)) $ZSH_HIGHLIGHT_REGEXP[$pat], memo=zsh-syntax-highlighting") 
		buf="$buf[$(($MEND+1)),-1]" 
		OFFSET=$((MEND+OFFSET)) 
	done
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-_bash_complete-word () {
	_zsh_highlight_call_widget orig-s0.0000050000-r18109-_bash_complete-word -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-_bash_list-choices () {
	_zsh_highlight_call_widget orig-s0.0000050000-r18109-_bash_list-choices -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-_complete_debug () {
	_zsh_highlight_call_widget orig-s0.0000050000-r18109-_complete_debug -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-_complete_help () {
	_zsh_highlight_call_widget orig-s0.0000050000-r18109-_complete_help -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-_complete_tag () {
	_zsh_highlight_call_widget orig-s0.0000050000-r18109-_complete_tag -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-_correct_filename () {
	_zsh_highlight_call_widget orig-s0.0000050000-r18109-_correct_filename -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-_correct_word () {
	_zsh_highlight_call_widget orig-s0.0000050000-r18109-_correct_word -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-_expand_alias () {
	_zsh_highlight_call_widget orig-s0.0000050000-r18109-_expand_alias -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-_expand_word () {
	_zsh_highlight_call_widget orig-s0.0000050000-r18109-_expand_word -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-_history-complete-newer () {
	_zsh_highlight_call_widget orig-s0.0000050000-r18109-_history-complete-newer -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-_history-complete-older () {
	_zsh_highlight_call_widget orig-s0.0000050000-r18109-_history-complete-older -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-_list_expansions () {
	_zsh_highlight_call_widget orig-s0.0000050000-r18109-_list_expansions -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-_most_recent_file () {
	_zsh_highlight_call_widget orig-s0.0000050000-r18109-_most_recent_file -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-_next_tags () {
	_zsh_highlight_call_widget orig-s0.0000050000-r18109-_next_tags -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-_read_comp () {
	_zsh_highlight_call_widget orig-s0.0000050000-r18109-_read_comp -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-accept-and-hold () {
	_zsh_highlight_call_widget .accept-and-hold -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-accept-and-infer-next-history () {
	_zsh_highlight_call_widget .accept-and-infer-next-history -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-accept-and-menu-complete () {
	_zsh_highlight_call_widget .accept-and-menu-complete -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-accept-line () {
	_zsh_highlight_call_widget .accept-line -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-accept-line-and-down-history () {
	_zsh_highlight_call_widget .accept-line-and-down-history -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-accept-search () {
	_zsh_highlight_call_widget .accept-search -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-argument-base () {
	_zsh_highlight_call_widget .argument-base -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-auto-suffix-remove () {
	_zsh_highlight_call_widget .auto-suffix-remove -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-auto-suffix-retain () {
	_zsh_highlight_call_widget .auto-suffix-retain -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-backward-char () {
	_zsh_highlight_call_widget .backward-char -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-backward-delete-char () {
	_zsh_highlight_call_widget .backward-delete-char -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-backward-delete-word () {
	_zsh_highlight_call_widget .backward-delete-word -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-backward-kill-line () {
	_zsh_highlight_call_widget .backward-kill-line -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-backward-kill-word () {
	_zsh_highlight_call_widget .backward-kill-word -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-backward-word () {
	_zsh_highlight_call_widget .backward-word -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-beginning-of-buffer-or-history () {
	_zsh_highlight_call_widget .beginning-of-buffer-or-history -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-beginning-of-history () {
	_zsh_highlight_call_widget .beginning-of-history -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-beginning-of-line () {
	_zsh_highlight_call_widget .beginning-of-line -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-beginning-of-line-hist () {
	_zsh_highlight_call_widget .beginning-of-line-hist -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-bracketed-paste () {
	_zsh_highlight_call_widget orig-s0.0000050000-r18109-bracketed-paste -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-capitalize-word () {
	_zsh_highlight_call_widget .capitalize-word -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-clear-screen () {
	_zsh_highlight_call_widget .clear-screen -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-complete-word () {
	_zsh_highlight_call_widget orig-s0.0000050000-r18109-complete-word -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-copy-prev-shell-word () {
	_zsh_highlight_call_widget .copy-prev-shell-word -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-copy-prev-word () {
	_zsh_highlight_call_widget .copy-prev-word -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-copy-region-as-kill () {
	_zsh_highlight_call_widget .copy-region-as-kill -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-deactivate-region () {
	_zsh_highlight_call_widget .deactivate-region -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-delete-char () {
	_zsh_highlight_call_widget .delete-char -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-delete-char-or-list () {
	_zsh_highlight_call_widget orig-s0.0000050000-r18109-delete-char-or-list -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-delete-word () {
	_zsh_highlight_call_widget .delete-word -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-describe-key-briefly () {
	_zsh_highlight_call_widget .describe-key-briefly -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-digit-argument () {
	_zsh_highlight_call_widget .digit-argument -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-down-case-word () {
	_zsh_highlight_call_widget .down-case-word -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-down-history () {
	_zsh_highlight_call_widget .down-history -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-down-line () {
	_zsh_highlight_call_widget .down-line -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-down-line-or-beginning-search () {
	_zsh_highlight_call_widget orig-s0.0000050000-r18109-down-line-or-beginning-search -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-down-line-or-history () {
	_zsh_highlight_call_widget .down-line-or-history -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-down-line-or-search () {
	_zsh_highlight_call_widget .down-line-or-search -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-edit-command-line () {
	_zsh_highlight_call_widget orig-s0.0000050000-r18109-edit-command-line -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-emacs-backward-word () {
	_zsh_highlight_call_widget .emacs-backward-word -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-emacs-forward-word () {
	_zsh_highlight_call_widget .emacs-forward-word -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-end-of-buffer-or-history () {
	_zsh_highlight_call_widget .end-of-buffer-or-history -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-end-of-history () {
	_zsh_highlight_call_widget .end-of-history -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-end-of-line () {
	_zsh_highlight_call_widget .end-of-line -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-end-of-line-hist () {
	_zsh_highlight_call_widget .end-of-line-hist -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-end-of-list () {
	_zsh_highlight_call_widget .end-of-list -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-exchange-point-and-mark () {
	_zsh_highlight_call_widget .exchange-point-and-mark -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-execute-last-named-cmd () {
	_zsh_highlight_call_widget .execute-last-named-cmd -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-execute-named-cmd () {
	_zsh_highlight_call_widget .execute-named-cmd -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-expand-cmd-path () {
	_zsh_highlight_call_widget .expand-cmd-path -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-expand-history () {
	_zsh_highlight_call_widget .expand-history -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-expand-or-complete () {
	_zsh_highlight_call_widget orig-s0.0000050000-r18109-expand-or-complete -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-expand-or-complete-prefix () {
	_zsh_highlight_call_widget orig-s0.0000050000-r18109-expand-or-complete-prefix -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-expand-word () {
	_zsh_highlight_call_widget .expand-word -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-forward-char () {
	_zsh_highlight_call_widget .forward-char -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-forward-word () {
	_zsh_highlight_call_widget .forward-word -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-get-line () {
	_zsh_highlight_call_widget .get-line -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-gosmacs-transpose-chars () {
	_zsh_highlight_call_widget .gosmacs-transpose-chars -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-history-beginning-search-backward () {
	_zsh_highlight_call_widget .history-beginning-search-backward -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-history-beginning-search-forward () {
	_zsh_highlight_call_widget .history-beginning-search-forward -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-history-incremental-pattern-search-backward () {
	_zsh_highlight_call_widget .history-incremental-pattern-search-backward -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-history-incremental-pattern-search-forward () {
	_zsh_highlight_call_widget .history-incremental-pattern-search-forward -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-history-incremental-search-backward () {
	_zsh_highlight_call_widget .history-incremental-search-backward -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-history-incremental-search-forward () {
	_zsh_highlight_call_widget .history-incremental-search-forward -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-history-search-backward () {
	_zsh_highlight_call_widget .history-search-backward -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-history-search-forward () {
	_zsh_highlight_call_widget .history-search-forward -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-infer-next-history () {
	_zsh_highlight_call_widget .infer-next-history -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-insert-last-word () {
	_zsh_highlight_call_widget .insert-last-word -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-kill-buffer () {
	_zsh_highlight_call_widget .kill-buffer -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-kill-line () {
	_zsh_highlight_call_widget .kill-line -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-kill-region () {
	_zsh_highlight_call_widget .kill-region -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-kill-whole-line () {
	_zsh_highlight_call_widget .kill-whole-line -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-kill-word () {
	_zsh_highlight_call_widget .kill-word -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-list-choices () {
	_zsh_highlight_call_widget orig-s0.0000050000-r18109-list-choices -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-list-expand () {
	_zsh_highlight_call_widget .list-expand -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-magic-space () {
	_zsh_highlight_call_widget .magic-space -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-menu-complete () {
	_zsh_highlight_call_widget orig-s0.0000050000-r18109-menu-complete -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-menu-expand-or-complete () {
	_zsh_highlight_call_widget orig-s0.0000050000-r18109-menu-expand-or-complete -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-menu-select () {
	_zsh_highlight_call_widget .menu-select -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-neg-argument () {
	_zsh_highlight_call_widget .neg-argument -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-overwrite-mode () {
	_zsh_highlight_call_widget .overwrite-mode -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-pound-insert () {
	_zsh_highlight_call_widget .pound-insert -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-push-input () {
	_zsh_highlight_call_widget .push-input -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-push-line () {
	_zsh_highlight_call_widget .push-line -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-push-line-or-edit () {
	_zsh_highlight_call_widget .push-line-or-edit -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-put-replace-selection () {
	_zsh_highlight_call_widget .put-replace-selection -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-quote-line () {
	_zsh_highlight_call_widget .quote-line -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-quote-region () {
	_zsh_highlight_call_widget .quote-region -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-quoted-insert () {
	_zsh_highlight_call_widget .quoted-insert -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-read-command () {
	_zsh_highlight_call_widget .read-command -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-recursive-edit () {
	_zsh_highlight_call_widget .recursive-edit -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-redisplay () {
	_zsh_highlight_call_widget .redisplay -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-redo () {
	_zsh_highlight_call_widget .redo -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-reset-prompt () {
	_zsh_highlight_call_widget .reset-prompt -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-reverse-menu-complete () {
	_zsh_highlight_call_widget orig-s0.0000050000-r18109-reverse-menu-complete -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-select-a-blank-word () {
	_zsh_highlight_call_widget .select-a-blank-word -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-select-a-shell-word () {
	_zsh_highlight_call_widget .select-a-shell-word -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-select-a-word () {
	_zsh_highlight_call_widget .select-a-word -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-select-in-blank-word () {
	_zsh_highlight_call_widget .select-in-blank-word -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-select-in-shell-word () {
	_zsh_highlight_call_widget .select-in-shell-word -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-select-in-word () {
	_zsh_highlight_call_widget .select-in-word -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-self-insert () {
	_zsh_highlight_call_widget orig-s0.0000050000-r18109-self-insert -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-self-insert-unmeta () {
	_zsh_highlight_call_widget .self-insert-unmeta -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-send-break () {
	_zsh_highlight_call_widget .send-break -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-set-mark-command () {
	_zsh_highlight_call_widget .set-mark-command -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-spell-word () {
	_zsh_highlight_call_widget .spell-word -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-split-undo () {
	_zsh_highlight_call_widget .split-undo -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-transpose-chars () {
	_zsh_highlight_call_widget .transpose-chars -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-transpose-words () {
	_zsh_highlight_call_widget .transpose-words -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-undefined-key () {
	_zsh_highlight_call_widget .undefined-key -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-undo () {
	_zsh_highlight_call_widget .undo -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-universal-argument () {
	_zsh_highlight_call_widget .universal-argument -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-up-case-word () {
	_zsh_highlight_call_widget .up-case-word -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-up-history () {
	_zsh_highlight_call_widget .up-history -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-up-line () {
	_zsh_highlight_call_widget .up-line -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-up-line-or-beginning-search () {
	_zsh_highlight_call_widget orig-s0.0000050000-r18109-up-line-or-beginning-search -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-up-line-or-history () {
	_zsh_highlight_call_widget .up-line-or-history -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-up-line-or-search () {
	_zsh_highlight_call_widget .up-line-or-search -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-add-eol () {
	_zsh_highlight_call_widget .vi-add-eol -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-add-next () {
	_zsh_highlight_call_widget .vi-add-next -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-backward-blank-word () {
	_zsh_highlight_call_widget .vi-backward-blank-word -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-backward-blank-word-end () {
	_zsh_highlight_call_widget .vi-backward-blank-word-end -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-backward-char () {
	_zsh_highlight_call_widget .vi-backward-char -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-backward-delete-char () {
	_zsh_highlight_call_widget .vi-backward-delete-char -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-backward-kill-word () {
	_zsh_highlight_call_widget .vi-backward-kill-word -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-backward-word () {
	_zsh_highlight_call_widget .vi-backward-word -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-backward-word-end () {
	_zsh_highlight_call_widget .vi-backward-word-end -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-beginning-of-line () {
	_zsh_highlight_call_widget .vi-beginning-of-line -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-caps-lock-panic () {
	_zsh_highlight_call_widget .vi-caps-lock-panic -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-change () {
	_zsh_highlight_call_widget .vi-change -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-change-eol () {
	_zsh_highlight_call_widget .vi-change-eol -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-change-whole-line () {
	_zsh_highlight_call_widget .vi-change-whole-line -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-cmd-mode () {
	_zsh_highlight_call_widget .vi-cmd-mode -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-delete () {
	_zsh_highlight_call_widget .vi-delete -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-delete-char () {
	_zsh_highlight_call_widget .vi-delete-char -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-digit-or-beginning-of-line () {
	_zsh_highlight_call_widget .vi-digit-or-beginning-of-line -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-down-case () {
	_zsh_highlight_call_widget .vi-down-case -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-down-line-or-history () {
	_zsh_highlight_call_widget .vi-down-line-or-history -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-end-of-line () {
	_zsh_highlight_call_widget .vi-end-of-line -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-fetch-history () {
	_zsh_highlight_call_widget .vi-fetch-history -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-find-next-char () {
	_zsh_highlight_call_widget .vi-find-next-char -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-find-next-char-skip () {
	_zsh_highlight_call_widget .vi-find-next-char-skip -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-find-prev-char () {
	_zsh_highlight_call_widget .vi-find-prev-char -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-find-prev-char-skip () {
	_zsh_highlight_call_widget .vi-find-prev-char-skip -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-first-non-blank () {
	_zsh_highlight_call_widget .vi-first-non-blank -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-forward-blank-word () {
	_zsh_highlight_call_widget .vi-forward-blank-word -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-forward-blank-word-end () {
	_zsh_highlight_call_widget .vi-forward-blank-word-end -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-forward-char () {
	_zsh_highlight_call_widget .vi-forward-char -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-forward-word () {
	_zsh_highlight_call_widget .vi-forward-word -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-forward-word-end () {
	_zsh_highlight_call_widget .vi-forward-word-end -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-goto-column () {
	_zsh_highlight_call_widget .vi-goto-column -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-goto-mark () {
	_zsh_highlight_call_widget .vi-goto-mark -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-goto-mark-line () {
	_zsh_highlight_call_widget .vi-goto-mark-line -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-history-search-backward () {
	_zsh_highlight_call_widget .vi-history-search-backward -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-history-search-forward () {
	_zsh_highlight_call_widget .vi-history-search-forward -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-indent () {
	_zsh_highlight_call_widget .vi-indent -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-insert () {
	_zsh_highlight_call_widget .vi-insert -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-insert-bol () {
	_zsh_highlight_call_widget .vi-insert-bol -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-join () {
	_zsh_highlight_call_widget .vi-join -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-kill-eol () {
	_zsh_highlight_call_widget .vi-kill-eol -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-kill-line () {
	_zsh_highlight_call_widget .vi-kill-line -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-match-bracket () {
	_zsh_highlight_call_widget .vi-match-bracket -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-open-line-above () {
	_zsh_highlight_call_widget .vi-open-line-above -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-open-line-below () {
	_zsh_highlight_call_widget .vi-open-line-below -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-oper-swap-case () {
	_zsh_highlight_call_widget .vi-oper-swap-case -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-pound-insert () {
	_zsh_highlight_call_widget .vi-pound-insert -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-put-after () {
	_zsh_highlight_call_widget .vi-put-after -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-put-before () {
	_zsh_highlight_call_widget .vi-put-before -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-quoted-insert () {
	_zsh_highlight_call_widget .vi-quoted-insert -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-repeat-change () {
	_zsh_highlight_call_widget .vi-repeat-change -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-repeat-find () {
	_zsh_highlight_call_widget .vi-repeat-find -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-repeat-search () {
	_zsh_highlight_call_widget .vi-repeat-search -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-replace () {
	_zsh_highlight_call_widget .vi-replace -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-replace-chars () {
	_zsh_highlight_call_widget .vi-replace-chars -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-rev-repeat-find () {
	_zsh_highlight_call_widget .vi-rev-repeat-find -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-rev-repeat-search () {
	_zsh_highlight_call_widget .vi-rev-repeat-search -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-set-buffer () {
	_zsh_highlight_call_widget .vi-set-buffer -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-set-mark () {
	_zsh_highlight_call_widget .vi-set-mark -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-substitute () {
	_zsh_highlight_call_widget .vi-substitute -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-swap-case () {
	_zsh_highlight_call_widget .vi-swap-case -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-undo-change () {
	_zsh_highlight_call_widget .vi-undo-change -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-unindent () {
	_zsh_highlight_call_widget .vi-unindent -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-up-case () {
	_zsh_highlight_call_widget .vi-up-case -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-up-line-or-history () {
	_zsh_highlight_call_widget .vi-up-line-or-history -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-yank () {
	_zsh_highlight_call_widget .vi-yank -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-yank-eol () {
	_zsh_highlight_call_widget .vi-yank-eol -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-vi-yank-whole-line () {
	_zsh_highlight_call_widget .vi-yank-whole-line -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-visual-line-mode () {
	_zsh_highlight_call_widget .visual-line-mode -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-visual-mode () {
	_zsh_highlight_call_widget .visual-mode -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-what-cursor-position () {
	_zsh_highlight_call_widget .what-cursor-position -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-where-is () {
	_zsh_highlight_call_widget .where-is -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-zle-line-finish () {
	_zsh_highlight_call_widget orig-s0.0000050000-r18109-zle-line-finish -- "$@"
}
_zsh_highlight_widget_orig-s0.0000050000-r18109-zle-line-init () {
	_zsh_highlight_call_widget orig-s0.0000050000-r18109-zle-line-init -- "$@"
}
_zsh_highlight_widget_zle-isearch-update () {
	:
	_zsh_highlight
}
_zsocket () {
	# undefined
	builtin autoload -XUz
}
_zstyle () {
	# undefined
	builtin autoload -XUz
}
_ztodo () {
	# undefined
	builtin autoload -XUz
}
_zypper () {
	# undefined
	builtin autoload -XUz
}
add-zsh-hook () {
	emulate -L zsh
	local -a hooktypes
	hooktypes=(chpwd precmd preexec periodic zshaddhistory zshexit zsh_directory_name) 
	local usage="Usage: add-zsh-hook hook function\nValid hooks are:\n  $hooktypes" 
	local opt
	local -a autoopts
	integer del list help
	while getopts "dDhLUzk" opt
	do
		case $opt in
			(d) del=1  ;;
			(D) del=2  ;;
			(h) help=1  ;;
			(L) list=1  ;;
			([Uzk]) autoopts+=(-$opt)  ;;
			(*) return 1 ;;
		esac
	done
	shift $(( OPTIND - 1 ))
	if (( list ))
	then
		typeset -mp "(${1:-${(@j:|:)hooktypes}})_functions"
		return $?
	elif (( help || $# != 2 || ${hooktypes[(I)$1]} == 0 ))
	then
		print -u$(( 2 - help )) $usage
		return $(( 1 - help ))
	fi
	local hook="${1}_functions" 
	local fn="$2" 
	if (( del ))
	then
		if (( ${(P)+hook} ))
		then
			if (( del == 2 ))
			then
				set -A $hook ${(P)hook:#${~fn}}
			else
				set -A $hook ${(P)hook:#$fn}
			fi
			if (( ! ${(P)#hook} ))
			then
				unset $hook
			fi
		fi
	else
		if (( ${(P)+hook} ))
		then
			if (( ${${(P)hook}[(I)$fn]} == 0 ))
			then
				typeset -ga $hook
				set -A $hook ${(P)hook} $fn
			fi
		else
			typeset -ga $hook
			set -A $hook $fn
		fi
		autoload $autoopts -- $fn
	fi
}
alias_value () {
	(( $+aliases[$1] )) && echo $aliases[$1]
}
backward-extend-paste () {
	emulate -L zsh
	integer bep_mark=$MARK bep_region=$REGION_ACTIVE 
	if (( REGION_ACTIVE && MARK < CURSOR ))
	then
		zle .exchange-point-and-mark
	fi
	if (( CURSOR ))
	then
		local -a bep_words=(${(z)LBUFFER}) 
		if [[ -n $bep_words[-1] && $LBUFFER = *$bep_words[-1] ]]
		then
			PASTED=$bep_words[-1]$PASTED 
			LBUFFER=${LBUFFER%${bep_words[-1]}} 
		fi
	fi
	if (( MARK > bep_mark ))
	then
		zle .exchange-point-and-mark
	fi
	REGION_ACTIVE=$bep_region 
}
bashcompinit () {
	# undefined
	builtin autoload -XUz
}
bracketed-paste-magic () {
	if [[ "$LASTWIDGET" = *vi-set-buffer ]]
	then
		zle .bracketed-paste
		return
	else
		local PASTED REPLY
		zle .bracketed-paste PASTED
	fi
	local bpm_emulate="$(emulate)" bpm_opts="$-" 
	emulate -L zsh
	local -a bpm_hooks bpm_inactive
	local bpm_func bpm_active bpm_keymap=$KEYMAP 
	if zstyle -a :bracketed-paste-magic paste-init bpm_hooks
	then
		for bpm_func in $bpm_hooks
		do
			if (( $+functions[$bpm_func] ))
			then
				() {
					emulate -L $bpm_emulate
					set -$bpm_opts
					$bpm_func || break
				}
			fi
		done
	fi
	zstyle -a :bracketed-paste-magic inactive-keys bpm_inactive
	if zstyle -s :bracketed-paste-magic active-widgets bpm_active '|'
	then
		integer bpm_mark=$MARK bpm_region=$REGION_ACTIVE 
		integer bpm_numeric=${NUMERIC:-1} 
		integer bpm_limit=$UNDO_LIMIT_NO bpm_undo=$UNDO_CHANGE_NO 
		zle .split-undo
		UNDO_LIMIT_NO=$UNDO_CHANGE_NO 
		BUFFER= 
		CURSOR=1 
		fc -p -a /dev/null 0 0
		if [[ $bmp_keymap = vicmd ]]
		then
			zle -K viins
		fi
		NUMERIC=1 
		zle -U - $PASTED
		while [[ -n $PASTED ]] && zle .read-command
		do
			PASTED=${PASTED#$KEYS} 
			if [[ $KEYS = ${(~j:|:)${(b)bpm_inactive}} ]]
			then
				zle .self-insert
			else
				case $REPLY in
					(${~bpm_active}) () {
							emulate -L $bpm_emulate
							set -$bpm_opts
							zle $REPLY -w
						} ;;
					(*) zle .self-insert ;;
				esac
			fi
		done
		PASTED=$BUFFER 
		zle -K $bpm_keymap
		fc -P
		MARK=$bpm_mark 
		REGION_ACTIVE=$bpm_region 
		NUMERIC=$bpm_numeric 
		zle .undo $bpm_undo
		UNDO_LIMIT_NO=$bpm_limit 
	fi
	if zstyle -a :bracketed-paste-magic paste-finish bpm_hooks
	then
		for bpm_func in $bpm_hooks
		do
			if (( $+functions[$bpm_func] ))
			then
				() {
					emulate -L $bpm_emulate
					set -$bpm_opts
					$bpm_func || break
				}
			fi
		done
	fi
	zle -U - $PASTED$'\e[201~'
	zle .bracketed-paste -- "$@"
	zle .split-undo
	if [[ -z $zle_highlight || -n ${(M)zle_highlight:#paste:*} ]]
	then
		zle -R
		zle .read-command && zle -U - $KEYS
	fi
}
bzr_prompt_info () {
	BZR_CB=`bzr nick 2> /dev/null | grep -v "ERROR" | cut -d ":" -f2 | awk -F / '{print "bzr::"$1}'` 
	if [ -n "$BZR_CB" ]
	then
		BZR_DIRTY="" 
		[[ -n `bzr status` ]] && BZR_DIRTY=" %{$fg[red]%} * %{$fg[green]%}" 
		echo "$ZSH_THEME_SCM_PROMPT_PREFIX$BZR_CB$BZR_DIRTY$ZSH_THEME_GIT_PROMPT_SUFFIX"
	fi
}
chruby_prompt_info () {
	return 1
}
clipcopy () {
	_retry_clipboard_detection_or_fail clipcopy "$@"
}
clippaste () {
	_retry_clipboard_detection_or_fail clippaste "$@"
}
colors () {
	emulate -L zsh
	typeset -Ag color colour
	color=(00 none 01 bold 02 faint 22 normal 03 standout 23 no-standout 04 underline 24 no-underline 05 blink 25 no-blink 07 reverse 27 no-reverse 08 conceal 28 no-conceal 30 black 40 bg-black 31 red 41 bg-red 32 green 42 bg-green 33 yellow 43 bg-yellow 34 blue 44 bg-blue 35 magenta 45 bg-magenta 36 cyan 46 bg-cyan 37 white 47 bg-white 39 default 49 bg-default) 
	local k
	for k in ${(k)color}
	do
		color[${color[$k]}]=$k 
	done
	for k in ${color[(I)3?]}
	do
		color[fg-${color[$k]}]=$k 
	done
	color[grey]=${color[black]} 
	color[fg-grey]=${color[grey]} 
	color[bg-grey]=${color[bg-black]} 
	colour=(${(kv)color}) 
	local lc=$'\e[' rc=m 
	typeset -Hg reset_color bold_color
	reset_color="$lc${color[none]}$rc" 
	bold_color="$lc${color[bold]}$rc" 
	typeset -AHg fg fg_bold fg_no_bold
	for k in ${(k)color[(I)fg-*]}
	do
		fg[${k#fg-}]="$lc${color[$k]}$rc" 
		fg_bold[${k#fg-}]="$lc${color[bold]};${color[$k]}$rc" 
		fg_no_bold[${k#fg-}]="$lc${color[normal]};${color[$k]}$rc" 
	done
	typeset -AHg bg bg_bold bg_no_bold
	for k in ${(k)color[(I)bg-*]}
	do
		bg[${k#bg-}]="$lc${color[$k]}$rc" 
		bg_bold[${k#bg-}]="$lc${color[bold]};${color[$k]}$rc" 
		bg_no_bold[${k#bg-}]="$lc${color[normal]};${color[$k]}$rc" 
	done
}
compaudit () {
	# undefined
	builtin autoload -XUz
}
compdef () {
	local opt autol type func delete eval new i ret=0 cmd svc 
	local -a match mbegin mend
	emulate -L zsh
	setopt extendedglob
	if (( ! $# ))
	then
		print -u2 "$0: I need arguments"
		return 1
	fi
	while getopts "anpPkKde" opt
	do
		case "$opt" in
			(a) autol=yes  ;;
			(n) new=yes  ;;
			([pPkK]) if [[ -n "$type" ]]
				then
					print -u2 "$0: type already set to $type"
					return 1
				fi
				if [[ "$opt" = p ]]
				then
					type=pattern 
				elif [[ "$opt" = P ]]
				then
					type=postpattern 
				elif [[ "$opt" = K ]]
				then
					type=widgetkey 
				else
					type=key 
				fi ;;
			(d) delete=yes  ;;
			(e) eval=yes  ;;
		esac
	done
	shift OPTIND-1
	if (( ! $# ))
	then
		print -u2 "$0: I need arguments"
		return 1
	fi
	if [[ -z "$delete" ]]
	then
		if [[ -z "$eval" ]] && [[ "$1" = *\=* ]]
		then
			while (( $# ))
			do
				if [[ "$1" = *\=* ]]
				then
					cmd="${1%%\=*}" 
					svc="${1#*\=}" 
					func="$_comps[${_services[(r)$svc]:-$svc}]" 
					[[ -n ${_services[$svc]} ]] && svc=${_services[$svc]} 
					[[ -z "$func" ]] && func="${${_patcomps[(K)$svc][1]}:-${_postpatcomps[(K)$svc][1]}}" 
					if [[ -n "$func" ]]
					then
						_comps[$cmd]="$func" 
						_services[$cmd]="$svc" 
					else
						print -u2 "$0: unknown command or service: $svc"
						ret=1 
					fi
				else
					print -u2 "$0: invalid argument: $1"
					ret=1 
				fi
				shift
			done
			return ret
		fi
		func="$1" 
		[[ -n "$autol" ]] && autoload -Uz "$func"
		shift
		case "$type" in
			(widgetkey) while [[ -n $1 ]]
				do
					if [[ $# -lt 3 ]]
					then
						print -u2 "$0: compdef -K requires <widget> <comp-widget> <key>"
						return 1
					fi
					[[ $1 = _* ]] || 1="_$1" 
					[[ $2 = .* ]] || 2=".$2" 
					[[ $2 = .menu-select ]] && zmodload -i zsh/complist
					zle -C "$1" "$2" "$func"
					if [[ -n $new ]]
					then
						bindkey "$3" | IFS=$' \t' read -A opt
						[[ $opt[-1] = undefined-key ]] && bindkey "$3" "$1"
					else
						bindkey "$3" "$1"
					fi
					shift 3
				done ;;
			(key) if [[ $# -lt 2 ]]
				then
					print -u2 "$0: missing keys"
					return 1
				fi
				if [[ $1 = .* ]]
				then
					[[ $1 = .menu-select ]] && zmodload -i zsh/complist
					zle -C "$func" "$1" "$func"
				else
					[[ $1 = menu-select ]] && zmodload -i zsh/complist
					zle -C "$func" ".$1" "$func"
				fi
				shift
				for i
				do
					if [[ -n $new ]]
					then
						bindkey "$i" | IFS=$' \t' read -A opt
						[[ $opt[-1] = undefined-key ]] || continue
					fi
					bindkey "$i" "$func"
				done ;;
			(*) while (( $# ))
				do
					if [[ "$1" = -N ]]
					then
						type=normal 
					elif [[ "$1" = -p ]]
					then
						type=pattern 
					elif [[ "$1" = -P ]]
					then
						type=postpattern 
					else
						case "$type" in
							(pattern) if [[ $1 = (#b)(*)=(*) ]]
								then
									_patcomps[$match[1]]="=$match[2]=$func" 
								else
									_patcomps[$1]="$func" 
								fi ;;
							(postpattern) if [[ $1 = (#b)(*)=(*) ]]
								then
									_postpatcomps[$match[1]]="=$match[2]=$func" 
								else
									_postpatcomps[$1]="$func" 
								fi ;;
							(*) if [[ "$1" = *\=* ]]
								then
									cmd="${1%%\=*}" 
									svc=yes 
								else
									cmd="$1" 
									svc= 
								fi
								if [[ -z "$new" || -z "${_comps[$1]}" ]]
								then
									_comps[$cmd]="$func" 
									[[ -n "$svc" ]] && _services[$cmd]="${1#*\=}" 
								fi ;;
						esac
					fi
					shift
				done ;;
		esac
	else
		case "$type" in
			(pattern) unset "_patcomps[$^@]" ;;
			(postpattern) unset "_postpatcomps[$^@]" ;;
			(key) print -u2 "$0: cannot restore key bindings"
				return 1 ;;
			(*) unset "_comps[$^@]" ;;
		esac
	fi
}
compdump () {
	# undefined
	builtin autoload -XUz
}
compgen () {
	local opts prefix suffix job OPTARG OPTIND ret=1 
	local -a name res results jids
	local -A shortopts
	emulate -L sh
	setopt kshglob noshglob braceexpand nokshautoload
	shortopts=(a alias b builtin c command d directory e export f file g group j job k keyword u user v variable) 
	while getopts "o:A:G:C:F:P:S:W:X:abcdefgjkuv" name
	do
		case $name in
			([abcdefgjkuv]) OPTARG="${shortopts[$name]}"  ;&
			(A) case $OPTARG in
					(alias) results+=("${(k)aliases[@]}")  ;;
					(arrayvar) results+=("${(k@)parameters[(R)array*]}")  ;;
					(binding) results+=("${(k)widgets[@]}")  ;;
					(builtin) results+=("${(k)builtins[@]}" "${(k)dis_builtins[@]}")  ;;
					(command) results+=("${(k)commands[@]}" "${(k)aliases[@]}" "${(k)builtins[@]}" "${(k)functions[@]}" "${(k)reswords[@]}")  ;;
					(directory) setopt bareglobqual
						results+=(${IPREFIX}${PREFIX}*${SUFFIX}${ISUFFIX}(N-/)) 
						setopt nobareglobqual ;;
					(disabled) results+=("${(k)dis_builtins[@]}")  ;;
					(enabled) results+=("${(k)builtins[@]}")  ;;
					(export) results+=("${(k)parameters[(R)*export*]}")  ;;
					(file) setopt bareglobqual
						results+=(${IPREFIX}${PREFIX}*${SUFFIX}${ISUFFIX}(N)) 
						setopt nobareglobqual ;;
					(function) results+=("${(k)functions[@]}")  ;;
					(group) emulate zsh
						_groups -U -O res
						emulate sh
						setopt kshglob noshglob braceexpand
						results+=("${res[@]}")  ;;
					(hostname) emulate zsh
						_hosts -U -O res
						emulate sh
						setopt kshglob noshglob braceexpand
						results+=("${res[@]}")  ;;
					(job) results+=("${savejobtexts[@]%% *}")  ;;
					(keyword) results+=("${(k)reswords[@]}")  ;;
					(running) jids=("${(@k)savejobstates[(R)running*]}") 
						for job in "${jids[@]}"
						do
							results+=(${savejobtexts[$job]%% *}) 
						done ;;
					(stopped) jids=("${(@k)savejobstates[(R)suspended*]}") 
						for job in "${jids[@]}"
						do
							results+=(${savejobtexts[$job]%% *}) 
						done ;;
					(setopt | shopt) results+=("${(k)options[@]}")  ;;
					(signal) results+=("SIG${^signals[@]}")  ;;
					(user) results+=("${(k)userdirs[@]}")  ;;
					(variable) results+=("${(k)parameters[@]}")  ;;
					(helptopic)  ;;
				esac ;;
			(F) COMPREPLY=() 
				local -a args
				args=("${words[0]}" "${@[-1]}" "${words[CURRENT-2]}") 
				() {
					typeset -h words
					$OPTARG "${args[@]}"
				}
				results+=("${COMPREPLY[@]}")  ;;
			(G) setopt nullglob
				results+=(${~OPTARG}) 
				unsetopt nullglob ;;
			(W) results+=(${(Q)~=OPTARG})  ;;
			(C) results+=($(eval $OPTARG))  ;;
			(P) prefix="$OPTARG"  ;;
			(S) suffix="$OPTARG"  ;;
			(X) if [[ ${OPTARG[0]} = '!' ]]
				then
					results=("${(M)results[@]:#${OPTARG#?}}") 
				else
					results=("${results[@]:#$OPTARG}") 
				fi ;;
		esac
	done
	print -l -r -- "$prefix${^results[@]}$suffix"
}
compinit () {
	# undefined
	builtin autoload -XUz
}
compinstall () {
	# undefined
	builtin autoload -XUz
}
complete () {
	emulate -L zsh
	local args void cmd print remove
	args=("$@") 
	zparseopts -D -a void o: A: G: W: C: F: P: S: X: a b c d e f g j k u v p=print r=remove
	if [[ -n $print ]]
	then
		printf 'complete %2$s %1$s\n' "${(@kv)_comps[(R)_bash*]#* }"
	elif [[ -n $remove ]]
	then
		for cmd
		do
			unset "_comps[$cmd]"
		done
	else
		compdef _bash_complete\ ${(j. .)${(q)args[1,-1-$#]}} "$@"
	fi
}
current_branch () {
	git_current_branch
}
d () {
	if [[ -n $1 ]]
	then
		dirs "$@"
	else
		dirs -v | head -n 10
	fi
}
default () {
	(( $+parameters[$1] )) && return 0
	typeset -g "$1"="$2" && return 3
}
detect-clipboard () {
	emulate -L zsh
	if [[ "${OSTYPE}" == darwin* ]] && (( ${+commands[pbcopy]} )) && (( ${+commands[pbpaste]} ))
	then
		clipcopy () {
			pbcopy < "${1:-/dev/stdin}"
		}
		clippaste () {
			pbpaste
		}
	elif [[ "${OSTYPE}" == (cygwin|msys)* ]]
	then
		clipcopy () {
			cat "${1:-/dev/stdin}" > /dev/clipboard
		}
		clippaste () {
			cat /dev/clipboard
		}
	elif [ -n "${WAYLAND_DISPLAY:-}" ] && (( ${+commands[wl-copy]} )) && (( ${+commands[wl-paste]} ))
	then
		clipcopy () {
			wl-copy < "${1:-/dev/stdin}"
		}
		clippaste () {
			wl-paste
		}
	elif [ -n "${DISPLAY:-}" ] && (( ${+commands[xclip]} ))
	then
		clipcopy () {
			xclip -in -selection clipboard < "${1:-/dev/stdin}"
		}
		clippaste () {
			xclip -out -selection clipboard
		}
	elif [ -n "${DISPLAY:-}" ] && (( ${+commands[xsel]} ))
	then
		clipcopy () {
			xsel --clipboard --input < "${1:-/dev/stdin}"
		}
		clippaste () {
			xsel --clipboard --output
		}
	elif (( ${+commands[lemonade]} ))
	then
		clipcopy () {
			lemonade copy < "${1:-/dev/stdin}"
		}
		clippaste () {
			lemonade paste
		}
	elif (( ${+commands[doitclient]} ))
	then
		clipcopy () {
			doitclient wclip < "${1:-/dev/stdin}"
		}
		clippaste () {
			doitclient wclip -r
		}
	elif (( ${+commands[win32yank]} ))
	then
		clipcopy () {
			win32yank -i < "${1:-/dev/stdin}"
		}
		clippaste () {
			win32yank -o
		}
	elif [[ $OSTYPE == linux-android* ]] && (( $+commands[termux-clipboard-set] ))
	then
		clipcopy () {
			termux-clipboard-set < "${1:-/dev/stdin}"
		}
		clippaste () {
			termux-clipboard-get
		}
	elif [ -n "${TMUX:-}" ] && (( ${+commands[tmux]} ))
	then
		clipcopy () {
			tmux load-buffer "${1:--}"
		}
		clippaste () {
			tmux save-buffer -
		}
	elif [[ $(uname -r) = *icrosoft* ]]
	then
		clipcopy () {
			clip.exe < "${1:-/dev/stdin}"
		}
		clippaste () {
			powershell.exe -noprofile -command Get-Clipboard
		}
	else
		_retry_clipboard_detection_or_fail () {
			local clipcmd="${1}" 
			shift
			if detect-clipboard
			then
				"${clipcmd}" "$@"
			else
				print "${clipcmd}: Platform $OSTYPE not supported or xclip/xsel not installed" >&2
				return 1
			fi
		}
		clipcopy () {
			_retry_clipboard_detection_or_fail clipcopy "$@"
		}
		clippaste () {
			_retry_clipboard_detection_or_fail clippaste "$@"
		}
		return 1
	fi
}
down-line-or-beginning-search () {
	# undefined
	builtin autoload -XU
}
edit-command-line () {
	# undefined
	builtin autoload -XU
}
env_default () {
	[[ ${parameters[$1]} = *-export* ]] && return 0
	export "$1=$2" && return 3
}
gccd () {
	command git clone --recurse-submodules "$@"
	[[ -d "$_" ]] && cd "$_" || cd "${${_:t}%.git}"
}
gdnolock () {
	git diff "$@" ":(exclude)package-lock.json" ":(exclude)*.lock"
}
gdv () {
	git diff -w "$@" | view -
}
ggf () {
	[[ "$#" != 1 ]] && local b="$(git_current_branch)" 
	git push --force origin "${b:=$1}"
}
ggfl () {
	[[ "$#" != 1 ]] && local b="$(git_current_branch)" 
	git push --force-with-lease origin "${b:=$1}"
}
ggl () {
	if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]
	then
		git pull origin "${*}"
	else
		[[ "$#" == 0 ]] && local b="$(git_current_branch)" 
		git pull origin "${b:=$1}"
	fi
}
ggp () {
	if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]
	then
		git push origin "${*}"
	else
		[[ "$#" == 0 ]] && local b="$(git_current_branch)" 
		git push origin "${b:=$1}"
	fi
}
ggpnp () {
	if [[ "$#" == 0 ]]
	then
		ggl && ggp
	else
		ggl "${*}" && ggp "${*}"
	fi
}
ggu () {
	[[ "$#" != 1 ]] && local b="$(git_current_branch)" 
	git pull --rebase origin "${b:=$1}"
}
git_commits_ahead () {
	if __git_prompt_git rev-parse --git-dir &> /dev/null
	then
		local commits="$(__git_prompt_git rev-list --count @{upstream}..HEAD 2>/dev/null)" 
		if [[ -n "$commits" && "$commits" != 0 ]]
		then
			echo "$ZSH_THEME_GIT_COMMITS_AHEAD_PREFIX$commits$ZSH_THEME_GIT_COMMITS_AHEAD_SUFFIX"
		fi
	fi
}
git_commits_behind () {
	if __git_prompt_git rev-parse --git-dir &> /dev/null
	then
		local commits="$(__git_prompt_git rev-list --count HEAD..@{upstream} 2>/dev/null)" 
		if [[ -n "$commits" && "$commits" != 0 ]]
		then
			echo "$ZSH_THEME_GIT_COMMITS_BEHIND_PREFIX$commits$ZSH_THEME_GIT_COMMITS_BEHIND_SUFFIX"
		fi
	fi
}
git_current_branch () {
	local ref
	ref=$(__git_prompt_git symbolic-ref --quiet HEAD 2> /dev/null) 
	local ret=$? 
	if [[ $ret != 0 ]]
	then
		[[ $ret == 128 ]] && return
		ref=$(__git_prompt_git rev-parse --short HEAD 2> /dev/null)  || return
	fi
	echo ${ref#refs/heads/}
}
git_current_user_email () {
	__git_prompt_git config user.email 2> /dev/null
}
git_current_user_name () {
	__git_prompt_git config user.name 2> /dev/null
}
git_develop_branch () {
	command git rev-parse --git-dir &> /dev/null || return
	local branch
	for branch in dev devel development
	do
		if command git show-ref -q --verify refs/heads/$branch
		then
			echo $branch
			return
		fi
	done
	echo develop
}
git_main_branch () {
	command git rev-parse --git-dir &> /dev/null || return
	local ref
	for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk}
	do
		if command git show-ref -q --verify $ref
		then
			echo ${ref:t}
			return
		fi
	done
	echo master
}
git_prompt_ahead () {
	if [[ -n "$(__git_prompt_git rev-list origin/$(git_current_branch)..HEAD 2> /dev/null)" ]]
	then
		echo "$ZSH_THEME_GIT_PROMPT_AHEAD"
	fi
}
git_prompt_behind () {
	if [[ -n "$(__git_prompt_git rev-list HEAD..origin/$(git_current_branch) 2> /dev/null)" ]]
	then
		echo "$ZSH_THEME_GIT_PROMPT_BEHIND"
	fi
}
git_prompt_info () {
	if ! __git_prompt_git rev-parse --git-dir &> /dev/null || [[ "$(__git_prompt_git config --get oh-my-zsh.hide-info 2>/dev/null)" == 1 ]]
	then
		return 0
	fi
	local ref
	ref=$(__git_prompt_git symbolic-ref --short HEAD 2> /dev/null)  || ref=$(__git_prompt_git rev-parse --short HEAD 2> /dev/null)  || return 0
	local upstream
	if (( ${+ZSH_THEME_GIT_SHOW_UPSTREAM} ))
	then
		upstream=$(__git_prompt_git rev-parse --abbrev-ref --symbolic-full-name "@{upstream}" 2>/dev/null)  && upstream=" -> ${upstream}" 
	fi
	echo "${ZSH_THEME_GIT_PROMPT_PREFIX}${ref:gs/%/%%}${upstream:gs/%/%%}$(parse_git_dirty)${ZSH_THEME_GIT_PROMPT_SUFFIX}"
}
git_prompt_long_sha () {
	local SHA
	SHA=$(__git_prompt_git rev-parse HEAD 2> /dev/null)  && echo "$ZSH_THEME_GIT_PROMPT_SHA_BEFORE$SHA$ZSH_THEME_GIT_PROMPT_SHA_AFTER"
}
git_prompt_remote () {
	if [[ -n "$(__git_prompt_git show-ref origin/$(git_current_branch) 2> /dev/null)" ]]
	then
		echo "$ZSH_THEME_GIT_PROMPT_REMOTE_EXISTS"
	else
		echo "$ZSH_THEME_GIT_PROMPT_REMOTE_MISSING"
	fi
}
git_prompt_short_sha () {
	local SHA
	SHA=$(__git_prompt_git rev-parse --short HEAD 2> /dev/null)  && echo "$ZSH_THEME_GIT_PROMPT_SHA_BEFORE$SHA$ZSH_THEME_GIT_PROMPT_SHA_AFTER"
}
git_prompt_status () {
	[[ "$(__git_prompt_git config --get oh-my-zsh.hide-status 2>/dev/null)" = 1 ]] && return
	local -A prefix_constant_map
	prefix_constant_map=('\?\? ' 'UNTRACKED' 'A  ' 'ADDED' 'M  ' 'ADDED' 'MM ' 'MODIFIED' ' M ' 'MODIFIED' 'AM ' 'MODIFIED' ' T ' 'MODIFIED' 'R  ' 'RENAMED' ' D ' 'DELETED' 'D  ' 'DELETED' 'UU ' 'UNMERGED' 'ahead' 'AHEAD' 'behind' 'BEHIND' 'diverged' 'DIVERGED' 'stashed' 'STASHED') 
	local -A constant_prompt_map
	constant_prompt_map=('UNTRACKED' "$ZSH_THEME_GIT_PROMPT_UNTRACKED" 'ADDED' "$ZSH_THEME_GIT_PROMPT_ADDED" 'MODIFIED' "$ZSH_THEME_GIT_PROMPT_MODIFIED" 'RENAMED' "$ZSH_THEME_GIT_PROMPT_RENAMED" 'DELETED' "$ZSH_THEME_GIT_PROMPT_DELETED" 'UNMERGED' "$ZSH_THEME_GIT_PROMPT_UNMERGED" 'AHEAD' "$ZSH_THEME_GIT_PROMPT_AHEAD" 'BEHIND' "$ZSH_THEME_GIT_PROMPT_BEHIND" 'DIVERGED' "$ZSH_THEME_GIT_PROMPT_DIVERGED" 'STASHED' "$ZSH_THEME_GIT_PROMPT_STASHED") 
	local status_constants
	status_constants=(UNTRACKED ADDED MODIFIED RENAMED DELETED STASHED UNMERGED AHEAD BEHIND DIVERGED) 
	local status_text
	status_text="$(__git_prompt_git status --porcelain -b 2> /dev/null)" 
	if [[ $? -eq 128 ]]
	then
		return 1
	fi
	local -A statuses_seen
	if __git_prompt_git rev-parse --verify refs/stash &> /dev/null
	then
		statuses_seen[STASHED]=1 
	fi
	local status_lines
	status_lines=("${(@f)${status_text}}") 
	if [[ "$status_lines[1]" =~ "^## [^ ]+ \[(.*)\]" ]]
	then
		local branch_statuses
		branch_statuses=("${(@s/,/)match}") 
		for branch_status in $branch_statuses
		do
			if [[ ! $branch_status =~ "(behind|diverged|ahead) ([0-9]+)?" ]]
			then
				continue
			fi
			local last_parsed_status=$prefix_constant_map[$match[1]] 
			statuses_seen[$last_parsed_status]=$match[2] 
		done
	fi
	for status_prefix in ${(k)prefix_constant_map}
	do
		local status_constant="${prefix_constant_map[$status_prefix]}" 
		local status_regex=$'(^|\n)'"$status_prefix" 
		if [[ "$status_text" =~ $status_regex ]]
		then
			statuses_seen[$status_constant]=1 
		fi
	done
	local status_prompt
	for status_constant in $status_constants
	do
		if (( ${+statuses_seen[$status_constant]} ))
		then
			local next_display=$constant_prompt_map[$status_constant] 
			status_prompt="$next_display$status_prompt" 
		fi
	done
	echo $status_prompt
}
git_remote_status () {
	local remote ahead behind git_remote_status git_remote_status_detailed
	remote=${$(__git_prompt_git rev-parse --verify ${hook_com[branch]}@{upstream} --symbolic-full-name 2>/dev/null)/refs\/remotes\/} 
	if [[ -n ${remote} ]]
	then
		ahead=$(__git_prompt_git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l) 
		behind=$(__git_prompt_git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l) 
		if [[ $ahead -eq 0 ]] && [[ $behind -eq 0 ]]
		then
			git_remote_status="$ZSH_THEME_GIT_PROMPT_EQUAL_REMOTE" 
		elif [[ $ahead -gt 0 ]] && [[ $behind -eq 0 ]]
		then
			git_remote_status="$ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE" 
			git_remote_status_detailed="$ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE_COLOR$ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE$((ahead))%{$reset_color%}" 
		elif [[ $behind -gt 0 ]] && [[ $ahead -eq 0 ]]
		then
			git_remote_status="$ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE" 
			git_remote_status_detailed="$ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE_COLOR$ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE$((behind))%{$reset_color%}" 
		elif [[ $ahead -gt 0 ]] && [[ $behind -gt 0 ]]
		then
			git_remote_status="$ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE" 
			git_remote_status_detailed="$ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE_COLOR$ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE$((ahead))%{$reset_color%}$ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE_COLOR$ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE$((behind))%{$reset_color%}" 
		fi
		if [[ -n $ZSH_THEME_GIT_PROMPT_REMOTE_STATUS_DETAILED ]]
		then
			git_remote_status="$ZSH_THEME_GIT_PROMPT_REMOTE_STATUS_PREFIX${remote:gs/%/%%}$git_remote_status_detailed$ZSH_THEME_GIT_PROMPT_REMOTE_STATUS_SUFFIX" 
		fi
		echo $git_remote_status
	fi
}
git_repo_name () {
	local repo_path
	if repo_path="$(__git_prompt_git rev-parse --show-toplevel 2>/dev/null)"  && [[ -n "$repo_path" ]]
	then
		echo ${repo_path:t}
	fi
}
grename () {
	if [[ -z "$1" || -z "$2" ]]
	then
		echo "Usage: $0 old_branch new_branch"
		return 1
	fi
	git branch -m "$1" "$2"
	if git push origin :"$1"
	then
		git push --set-upstream origin "$2"
	fi
}
handle_completion_insecurities () {
	local -aU insecure_dirs
	insecure_dirs=(${(f@):-"$(compaudit 2>/dev/null)"}) 
	[[ -z "${insecure_dirs}" ]] && return
	print "[oh-my-zsh] Insecure completion-dependent directories detected:"
	ls -ld "${(@)insecure_dirs}"
	cat <<EOD

[oh-my-zsh] For safety, we will not load completions from these directories until
[oh-my-zsh] you fix their permissions and ownership and restart zsh.
[oh-my-zsh] See the above list for directories with group or other writability.

[oh-my-zsh] To fix your permissions you can do so by disabling
[oh-my-zsh] the write permission of "group" and "others" and making sure that the
[oh-my-zsh] owner of these directories is either root or your current user.
[oh-my-zsh] The following command may help:
[oh-my-zsh]     compaudit | xargs chmod g-w,o-w

[oh-my-zsh] If the above didn't help or you want to skip the verification of
[oh-my-zsh] insecure directories you can set the variable ZSH_DISABLE_COMPFIX to
[oh-my-zsh] "true" before oh-my-zsh is sourced in your zshrc file.

EOD
}
has_typed_input () {
	emulate -L zsh
	zmodload zsh/zselect
	local termios
	termios=$(stty --save 2>/dev/null)  || return 1
	{
		stty -icanon
		zselect -t 0 -r 0
		return $?
	} always {
		stty $termios
	}
}
hg_prompt_info () {
	return 1
}
is-at-least () {
	emulate -L zsh
	local IFS=".-" min_cnt=0 ver_cnt=0 part min_ver version order 
	min_ver=(${=1}) 
	version=(${=2:-$ZSH_VERSION} 0) 
	while (( $min_cnt <= ${#min_ver} ))
	do
		while [[ "$part" != <-> ]]
		do
			(( ++ver_cnt > ${#version} )) && return 0
			if [[ ${version[ver_cnt]} = *[0-9][^0-9]* ]]
			then
				order=(${version[ver_cnt]} ${min_ver[ver_cnt]}) 
				if [[ ${version[ver_cnt]} = <->* ]]
				then
					[[ $order != ${${(On)order}} ]] && return 1
				else
					[[ $order != ${${(O)order}} ]] && return 1
				fi
				[[ $order[1] != $order[2] ]] && return 0
			fi
			part=${version[ver_cnt]##*[^0-9]} 
		done
		while true
		do
			(( ++min_cnt > ${#min_ver} )) && return 0
			[[ ${min_ver[min_cnt]} = <-> ]] && break
		done
		(( part > min_ver[min_cnt] )) && return 0
		(( part < min_ver[min_cnt] )) && return 1
		part='' 
	done
}
is_plugin () {
	local base_dir=$1 
	local name=$2 
	builtin test -f $base_dir/plugins/$name/$name.plugin.zsh || builtin test -f $base_dir/plugins/$name/_$name
}
is_theme () {
	local base_dir=$1 
	local name=$2 
	builtin test -f $base_dir/$name.zsh-theme
}
jenv_prompt_info () {
	return 1
}
mkcd () {
	mkdir -p $@ && cd ${@:$#}
}
nvm_prompt_info () {
	which nvm &> /dev/null || return
	local nvm_prompt=${$(nvm current)#v} 
	echo "${ZSH_THEME_NVM_PROMPT_PREFIX}${nvm_prompt:gs/%/%%}${ZSH_THEME_NVM_PROMPT_SUFFIX}"
}
omz () {
	[[ $# -gt 0 ]] || {
		_omz::help
		return 1
	}
	local command="$1" 
	shift
	(( $+functions[_omz::$command] )) || {
		_omz::help
		return 1
	}
	_omz::$command "$@"
}
omz_diagnostic_dump () {
	emulate -L zsh
	builtin echo "Generating diagnostic dump; please be patient..."
	local thisfcn=omz_diagnostic_dump 
	local -A opts
	local opt_verbose opt_noverbose opt_outfile
	local timestamp=$(date +%Y%m%d-%H%M%S) 
	local outfile=omz_diagdump_$timestamp.txt 
	builtin zparseopts -A opts -D -- "v+=opt_verbose" "V+=opt_noverbose"
	local verbose n_verbose=${#opt_verbose} n_noverbose=${#opt_noverbose} 
	(( verbose = 1 + n_verbose - n_noverbose ))
	if [[ ${#*} > 0 ]]
	then
		opt_outfile=$1 
	fi
	if [[ ${#*} > 1 ]]
	then
		builtin echo "$thisfcn: error: too many arguments" >&2
		return 1
	fi
	if [[ -n "$opt_outfile" ]]
	then
		outfile="$opt_outfile" 
	fi
	_omz_diag_dump_one_big_text &> "$outfile"
	if [[ $? != 0 ]]
	then
		builtin echo "$thisfcn: error while creating diagnostic dump; see $outfile for details"
	fi
	builtin echo
	builtin echo Diagnostic dump file created at: "$outfile"
	builtin echo
	builtin echo To share this with OMZ developers, post it as a gist on GitHub
	builtin echo at "https://gist.github.com" and share the link to the gist.
	builtin echo
	builtin echo "WARNING: This dump file contains all your zsh and omz configuration files,"
	builtin echo "so don't share it publicly if there's sensitive information in them."
	builtin echo
}
omz_history () {
	local clear list
	zparseopts -E c=clear l=list
	if [[ -n "$clear" ]]
	then
		echo -n >| "$HISTFILE"
		fc -p "$HISTFILE"
		echo History file deleted. >&2
	elif [[ -n "$list" ]]
	then
		builtin fc "$@"
	else
		[[ ${@[-1]-} = *[0-9]* ]] && builtin fc -l "$@" || builtin fc -l "$@" 1
	fi
}
omz_termsupport_precmd () {
	[[ "${DISABLE_AUTO_TITLE:-}" != true ]] || return
	title "$ZSH_THEME_TERM_TAB_TITLE_IDLE" "$ZSH_THEME_TERM_TITLE_IDLE"
}
omz_termsupport_preexec () {
	[[ "${DISABLE_AUTO_TITLE:-}" != true ]] || return
	emulate -L zsh
	setopt extended_glob
	local -a cmdargs
	cmdargs=("${(z)2}") 
	if [[ "${cmdargs[1]}" = fg ]]
	then
		local job_id jobspec="${cmdargs[2]#%}" 
		case "$jobspec" in
			(<->) job_id=${jobspec}  ;;
			("" | % | +) job_id=${(k)jobstates[(r)*:+:*]}  ;;
			(-) job_id=${(k)jobstates[(r)*:-:*]}  ;;
			([?]*) job_id=${(k)jobtexts[(r)*${(Q)jobspec}*]}  ;;
			(*) job_id=${(k)jobtexts[(r)${(Q)jobspec}*]}  ;;
		esac
		if [[ -n "${jobtexts[$job_id]}" ]]
		then
			1="${jobtexts[$job_id]}" 
			2="${jobtexts[$job_id]}" 
		fi
	fi
	local CMD="${1[(wr)^(*=*|sudo|ssh|mosh|rake|-*)]:gs/%/%%}" 
	local LINE="${2:gs/%/%%}" 
	title "$CMD" "%100>...>${LINE}%<<"
}
omz_urldecode () {
	emulate -L zsh
	local encoded_url=$1 
	local caller_encoding=$langinfo[CODESET] 
	local LC_ALL=C 
	export LC_ALL
	local tmp=${encoded_url:gs/+/ /} 
	tmp=${tmp:gs/\\/\\\\/} 
	tmp=${tmp:gs/%/\\x/} 
	local decoded="$(printf -- "$tmp")" 
	local -a safe_encodings
	safe_encodings=(UTF-8 utf8 US-ASCII) 
	if [[ -z ${safe_encodings[(r)$caller_encoding]} ]]
	then
		decoded=$(echo -E "$decoded" | iconv -f UTF-8 -t $caller_encoding) 
		if [[ $? != 0 ]]
		then
			echo "Error converting string from UTF-8 to $caller_encoding" >&2
			return 1
		fi
	fi
	echo -E "$decoded"
}
omz_urlencode () {
	emulate -L zsh
	local -a opts
	zparseopts -D -E -a opts r m P
	local in_str="$@" 
	local url_str="" 
	local spaces_as_plus
	if [[ -z $opts[(r)-P] ]]
	then
		spaces_as_plus=1 
	fi
	local str="$in_str" 
	local encoding=$langinfo[CODESET] 
	local safe_encodings
	safe_encodings=(UTF-8 utf8 US-ASCII) 
	if [[ -z ${safe_encodings[(r)$encoding]} ]]
	then
		str=$(echo -E "$str" | iconv -f $encoding -t UTF-8) 
		if [[ $? != 0 ]]
		then
			echo "Error converting string from $encoding to UTF-8" >&2
			return 1
		fi
	fi
	local i byte ord LC_ALL=C 
	export LC_ALL
	local reserved=';/?:@&=+$,' 
	local mark='_.!~*''()-' 
	local dont_escape="[A-Za-z0-9" 
	if [[ -z $opts[(r)-r] ]]
	then
		dont_escape+=$reserved 
	fi
	if [[ -z $opts[(r)-m] ]]
	then
		dont_escape+=$mark 
	fi
	dont_escape+="]" 
	local url_str="" 
	for ((i = 1; i <= ${#str}; ++i )) do
		byte="$str[i]" 
		if [[ "$byte" =~ "$dont_escape" ]]
		then
			url_str+="$byte" 
		else
			if [[ "$byte" == " " && -n $spaces_as_plus ]]
			then
				url_str+="+" 
			else
				ord=$(( [##16] #byte )) 
				url_str+="%$ord" 
			fi
		fi
	done
	echo -E "$url_str"
}
open_command () {
	local open_cmd
	case "$OSTYPE" in
		(darwin*) open_cmd='open'  ;;
		(cygwin*) open_cmd='cygstart'  ;;
		(linux*) [[ "$(uname -r)" != *icrosoft* ]] && open_cmd='nohup xdg-open'  || {
				open_cmd='cmd.exe /c start ""' 
				[[ -e "$1" ]] && {
					1="$(wslpath -w "${1:a}")"  || return 1
				}
			} ;;
		(msys*) open_cmd='start ""'  ;;
		(*) echo "Platform $OSTYPE not supported"
			return 1 ;;
	esac
	${=open_cmd} "$@" &> /dev/null
}
parse_git_dirty () {
	local STATUS
	local -a FLAGS
	FLAGS=('--porcelain') 
	if [[ "$(__git_prompt_git config --get oh-my-zsh.hide-dirty)" != "1" ]]
	then
		if [[ "${DISABLE_UNTRACKED_FILES_DIRTY:-}" == "true" ]]
		then
			FLAGS+='--untracked-files=no' 
		fi
		case "${GIT_STATUS_IGNORE_SUBMODULES:-}" in
			(git)  ;;
			(*) FLAGS+="--ignore-submodules=${GIT_STATUS_IGNORE_SUBMODULES:-dirty}"  ;;
		esac
		STATUS=$(__git_prompt_git status ${FLAGS} 2> /dev/null | tail -n 1) 
	fi
	if [[ -n $STATUS ]]
	then
		echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
	else
		echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
	fi
}
pyenv_prompt_info () {
	return 1
}
quote-paste () {
	emulate -L zsh
	local qstyle
	zstyle -s :bracketed-paste-magic:finish quote-style qstyle && NUMERIC=1 
	case $qstyle in
		(b) PASTED=${(b)PASTED}  ;;
		(q-) PASTED=${(q-)PASTED}  ;;
		(\\|q) PASTED=${(q)PASTED}  ;;
		(\'|qq) PASTED=${(qq)PASTED}  ;;
		(\"|qqq) PASTED=${(qqq)PASTED}  ;;
		(\$|qqqq) PASTED=${(qqqq)PASTED}  ;;
		(Q) PASTED=${(Q)PASTED}  ;;
	esac
}
rbenv_prompt_info () {
	return 1
}
regexp-replace () {
	integer pcre
	[[ -o re_match_pcre ]] && pcre=1 
	emulate -L zsh
	(( pcre )) && setopt re_match_pcre
	4=${(P)1} 
	5= 
	6= 
	local MATCH MBEGIN MEND
	local -a match mbegin mend
	while [[ -n $4 ]]
	do
		if [[ $4 =~ $2 ]]
		then
			5+=${4[1,MBEGIN-1]}${(e)3} 
			4=${4[MEND+1,-1]} 
			6=1 
		else
			break
		fi
	done
	5+=$4 
	eval ${1}=${(q)5}
	[[ -n $6 ]]
}
ruby_prompt_info () {
	echo $(rvm_prompt_info || rbenv_prompt_info || chruby_prompt_info)
}
run-help () {
	# undefined
	builtin autoload -XUz
}
rvm_prompt_info () {
	[ -f $HOME/.rvm/bin/rvm-prompt ] || return 1
	local rvm_prompt
	rvm_prompt=$($HOME/.rvm/bin/rvm-prompt ${=ZSH_THEME_RVM_PROMPT_OPTIONS} 2>/dev/null) 
	[[ -z "${rvm_prompt}" ]] && return 1
	echo "${ZSH_THEME_RUBY_PROMPT_PREFIX}${rvm_prompt:gs/%/%%}${ZSH_THEME_RUBY_PROMPT_SUFFIX}"
}
spectrum_bls () {
	setopt localoptions nopromptsubst
	local ZSH_SPECTRUM_TEXT=${ZSH_SPECTRUM_TEXT:-Arma virumque cano Troiae qui primus ab oris} 
	for code in {000..255}
	do
		print -P -- "$code: ${BG[$code]}${ZSH_SPECTRUM_TEXT}%{$reset_color%}"
	done
}
spectrum_ls () {
	setopt localoptions nopromptsubst
	local ZSH_SPECTRUM_TEXT=${ZSH_SPECTRUM_TEXT:-Arma virumque cano Troiae qui primus ab oris} 
	for code in {000..255}
	do
		print -P -- "$code: ${FG[$code]}${ZSH_SPECTRUM_TEXT}%{$reset_color%}"
	done
}
svn_prompt_info () {
	return 1
}
take () {
	if [[ $1 =~ ^(https?|ftp).*\.tar\.(gz|bz2|xz)$ ]]
	then
		takeurl "$1"
	elif [[ $1 =~ ^([A-Za-z0-9]\+@|https?|git|ssh|ftps?|rsync).*\.git/?$ ]]
	then
		takegit "$1"
	else
		takedir "$@"
	fi
}
takedir () {
	mkdir -p $@ && cd ${@:$#}
}
takegit () {
	git clone "$1"
	cd "$(basename ${1%%.git})"
}
takeurl () {
	local data thedir
	data="$(mktemp)" 
	curl -L "$1" > "$data"
	tar xf "$data"
	thedir="$(tar tf "$data" | head -n 1)" 
	rm "$data"
	cd "$thedir"
}
tf_prompt_info () {
	return 1
}
title () {
	setopt localoptions nopromptsubst
	[[ -n "${INSIDE_EMACS:-}" && "$INSIDE_EMACS" != vterm ]] && return
	: ${2=$1}
	case "$TERM" in
		(cygwin | xterm* | putty* | rxvt* | konsole* | ansi | mlterm* | alacritty | st* | foot) print -Pn "\e]2;${2:q}\a"
			print -Pn "\e]1;${1:q}\a" ;;
		(screen* | tmux*) print -Pn "\ek${1:q}\e\\" ;;
		(*) if [[ "$TERM_PROGRAM" == "iTerm.app" ]]
			then
				print -Pn "\e]2;${2:q}\a"
				print -Pn "\e]1;${1:q}\a"
			else
				if (( ${+terminfo[fsl]} && ${+terminfo[tsl]} ))
				then
					print -Pn "${terminfo[tsl]}$1${terminfo[fsl]}"
				fi
			fi ;;
	esac
}
try_alias_value () {
	alias_value "$1" || echo "$1"
}
uninstall_oh_my_zsh () {
	env ZSH="$ZSH" sh "$ZSH/tools/uninstall.sh"
}
up-line-or-beginning-search () {
	# undefined
	builtin autoload -XU
}
upgrade_oh_my_zsh () {
	echo "${fg[yellow]}Note: \`$0\` is deprecated. Use \`omz update\` instead.$reset_color" >&2
	omz update
}
url-quote-magic () {
	setopt localoptions noksharrays extendedglob
	local qkey="${(q)KEYS}" 
	local -a reply match mbegin mend
	if [[ "$KEYS" != "$qkey" ]]
	then
		local lbuf="$LBUFFER$qkey" 
		if [[ "${(Q)LBUFFER}$KEYS" == "${(Q)lbuf}" ]]
		then
			local -a words
			words=("${(@Q)${(z)lbuf}}") 
			local urlseps urlmetas urlglobbers localschema otherschema
			if [[ "$words[-1]" == (#b)([^:]##):* ]]
			then
				zstyle -s ":url-quote-magic:$match[1]" url-seps urlseps ''
				zstyle -s ":url-quote-magic:$match[1]" url-metas urlmetas ''
			fi
			zstyle -s :url-quote-magic url-globbers urlglobbers '|'
			zstyle -s :urlglobber url-other-schema otherschema '|'
			if [[ "$words[1]" == ${~urlglobbers} ]]
			then
				zstyle -s :urlglobber url-local-schema localschema '|'
			else
				localschema=' ' 
			fi
			case "$words[-1]" in
				(*[\'\"]*)  ;;
				((${~localschema}):/(|/localhost)/*) [[ "$urlseps" == *"$KEYS"* ]] && LBUFFER="$LBUFFER\\"  ;;
				((${~otherschema}):*) [[ "$urlseps$urlmetas" == *"$KEYS"* ]] && LBUFFER="$LBUFFER\\"  ;;
			esac
		fi
	fi
	zle .self-insert
}
urlglobber () {
	local -a args globbed localschema otherschema reply
	local arg command="$1" 
	shift
	zstyle -s :urlglobber url-local-schema localschema '|'
	zstyle -s :urlglobber url-other-schema otherschema '|'
	for arg
	do
		case "${arg}" in
			((${~localschema}):/(|/localhost)/*) globbed=(${~${arg##ftp://(localhost|)}}) 
				args[$#args+1]=("${(M)arg##(${~localchema})://(localhost|)}${(@)^globbed}")  ;;
			((${~otherschema}):*) args[${#args}+1]="$arg"  ;;
			(*) args[${#args}+1]=(${~arg})  ;;
		esac
	done
	"$command" "${(@)args}"
}
vi_mode_prompt_info () {
	return 1
}
virtualenv_prompt_info () {
	return 1
}
work_in_progress () {
	command git -c log.showSignature=false log -n 1 2> /dev/null | grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox} -q -- "--wip--" && echo "WIP!!"
}
zle-line-finish () {
	echoti rmkx
}
zle-line-init () {
	echoti smkx
}
zsh_stats () {
	fc -l 1 | awk '{ CMD[$2]++; count++; } END { for (a in CMD) print CMD[a] " " CMD[a]*100/count "% " a }' | grep -v "./" | sort -nr | head -n 20 | column -c3 -s " " -t | nl
}
