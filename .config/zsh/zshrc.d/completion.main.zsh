# Resources:
# - man zshoptions
# - https://zsh.sourceforge.io/FAQ/zshfaq04.html
# - https://zsh.sourceforge.io/Doc/Release/Completion-Widgets.html#Completion-Matching-Control
# - https://thevaluable.dev/zsh-completion-guide-examples/
# - https://www.csse.uwa.edu.au/programming/linux/zsh-doc/zsh_23.html

 # offers three extensions to completion listings: the ability to
 # highlight matches in such a list, the ability to scroll through long
 # lists and a different style of menu completion. 
zmodload -i zsh/complist

# do not autoselect the first completion entry (useless with auto_menu)
# unsetopt menu_complete

# display the completion menu after two use of the <tab> key
setopt auto_menu

# the cursor returns to the edited line after printing the list
setopt always_last_prompt

# completion is done from where the cursor is, in both directions
setopt complete_in_word

# if a completion is performed with the cursor within a word, and a full
# completion is inserted, the cursor is moved to the end of the word.
setopt always_to_end

# when a directory is completed, add a trailing slash instead of a space
setopt auto_param_slash

# do NOT beep on error
setopt no_beep
setopt no_list_beep

# use completers:
#  - _extensions   complete the glob *. with the possible file extensions
#  - _complete     this is the main completer
#  - _approximate  similar to _complete, except that it will try to correct what it already typed
zstyle ':completion:*' completer _extensions _complete _approximate

# do menu-driven completion, allow for furry search after <tab>
zstyle ':completion:*' menu select=0 search

# zstyle ':completion:*' insert-unambiguous true

# treat // as / instead of default /*/
zstyle ':completion:*' squeeze-slashes true

# in case of spelling error, still propose original text
zstyle ':completion:*' original true

# take advantage of $LS_COLORS for completion as well.
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# 0. default - insert '*'' (matching any number of characters in a
#      completion) at the cursor position. (because of complete_in_word)
# 1. let any lower case character in the current word be completed to
#      itself or its uppercase counterpart.
# 2. append ‘*’, even though COMPLETE_IN_WORD is set and the cursor is not
#      at the end of the current word. 
# 3. insert '*' after ._-/ and append '*' at the end.
# 4. prepend '*' and append '*'.
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'r:|=*' 'r:|[._-/]=*' 'l:|=* r:|=*'

# legend for corrections
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}- %d (errors: %e) -%f'

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

# use caching so that commands like apt and dpkg complete are useable
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH_CACHE_DIR

# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna \
        clamav daemon dbus distcache dnsmasq dovecot fax ftp games gdm \
        gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust kdm \
        ldap lp mail mailman mailnull man messagebus  mldonkey mysql nagios \
        named netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn \
        operator pcap polkitd postfix postgres privoxy pulse pvm quagga radvd \
        rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync tftp \
        usbmux uucp vcsa wwwrun xfs '_*'

# ... unless we really want to.
zstyle '*' single-ignored show

autoload -Uz compinit && compinit

#zstyle ':completion:*' completer _complete _ignored
#zstyle ':completion:*' expand suffix
#zstyle ':completion:*' file-sort name
#zstyle ':completion:*' group-name ''
#zstyle ':completion:*' ignore-parents parent pwd directory
#zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
#zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
#zstyle ':completion:*' list-suffixes true
#zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-/]=** r:|=**' 'l:|=* r:|=*'
#zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'                   'r:|[._-/]=* r:|=*'
#zstyle ':completion:*' menu select=1
#zstyle ':completion:*' preserve-prefix '//[^/]##/'
##zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
#zstyle ':completion:*' squeeze-slashes true
#zstyle :compinstall filename '/home/cpollet/.zshrc'
#
#autoload -Uz compinit
#compinit