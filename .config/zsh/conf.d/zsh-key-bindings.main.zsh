# ref: https://thevaluable.dev/zsh-line-editor-configuration-mouseless/
# ref: http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html
# ref: http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Zle-Builtins
# ref: http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets
# ref: https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/key-bindings.zsh

# To see the key combo you want you can use one of the following:
# - sudo showkey -a
# - cat > /dev/null
# - man terminfo is also your friend
# - autoload -Uz zkbd && zkbd

# [Ctrl-X V] - edit current line in $EDITOR
autoload -U edit-command-line;
zle -N edit-command-line;
bindkey '^xv' edit-command-line;


# [Shift-Tab] - move through the completion menu backwards
if [[ -n "${terminfo[kcbt]}" ]]; then
  bindkey -M emacs "${terminfo[kcbt]}" reverse-menu-complete
  bindkey -M viins "${terminfo[kcbt]}" reverse-menu-complete
  bindkey -M vicmd "${terminfo[kcbt]}" reverse-menu-complete
fi

# [Ctrl-RightArrow] - move forward one word
bindkey -M emacs '^[[1;5C' forward-word
bindkey -M viins '^[[1;5C' forward-word
bindkey -M vicmd '^[[1;5C' forward-word
# [Ctrl-LeftArrow] - move backward one word
bindkey -M emacs '^[[1;5D' backward-word
bindkey -M viins '^[[1;5D' backward-word
bindkey -M vicmd '^[[1;5D' backward-word

# [Alt-Backspace] - delete word backwards
bindkey "^[^?" backward-kill-word
bindkey -M emacs "^[^?" backward-kill-word
bindkey -M viins "^[^?" vi-backward-kill-word

# [Ctrl+W] - delete word backwards
bindkey "^W" backward-kill-word
bindkey -M emacs "^W" backward-kill-word
bindkey -M viins "^W" vi-backward-kill-word