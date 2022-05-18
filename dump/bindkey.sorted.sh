bindkey "^[0" digit-argument
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[1" digit-argument
bindkey "^[[200~" bracketed-paste
bindkey "^[2" digit-argument
bindkey "^[[2~" overwrite-mode
bindkey "^[[3;5~" kill-word
bindkey "^[[3~" delete-char
bindkey "^[3" digit-argument
bindkey "^[4" digit-argument
bindkey "^[5" digit-argument
bindkey "^[[5~" up-line-or-history
bindkey "^[6" digit-argument
bindkey "^[[6~" down-line-or-history
bindkey "^[7" digit-argument
bindkey "^[8" digit-argument
bindkey "^[9" digit-argument
bindkey -a "0" vi-digit-or-beginning-of-line
bindkey -a "^[[1;5C" forward-word
bindkey -a "^[[1;5D" backward-word
bindkey -a "^[[200~" bracketed-paste
bindkey -a "^[[2~" vi-insert
bindkey -a "^[[3;5~" kill-word
bindkey -a "^[[3~" delete-char
bindkey -a "^[[5~" up-line-or-history
bindkey -a "^[[6~" down-line-or-history
bindkey "^[a" accept-and-hold
bindkey "^[A" accept-and-hold
bindkey -a "^[[A" up-line-or-history
bindkey -a "A" vi-add-eol
bindkey -a "a" vi-add-next
bindkey -a "^?" backward-delete-char
bindkey -a "^[[B" down-line-or-history
bindkey -a "^[" beep
bindkey "^A" beginning-of-line
bindkey -a "B" vi-backward-blank-word
bindkey -a "b" vi-backward-word
bindkey -a "c" vi-change
bindkey -a "C" vi-change-eol
bindkey -a "^[[C" vi-forward-char
bindkey -a "^D" list-choices
bindkey -a "^[[D" vi-backward-char
bindkey -a "d" vi-delete
bindkey -a "D" vi-kill-eol
bindkey -a "E" vi-forward-blank-word-end
bindkey -a "e" vi-forward-word-end
bindkey -a ":" execute-named-cmd
bindkey -a "f" vi-find-next-char
bindkey -a "F" vi-find-prev-char
bindkey -a "ga" what-cursor-position
bindkey -a "gE" vi-backward-blank-word-end
bindkey -a "ge" vi-backward-word-end
bindkey -a "gg" beginning-of-buffer-or-history
bindkey -a "^G" list-expand
bindkey -a "gu" vi-down-case
bindkey -a "gU" vi-up-case
bindkey -a "G" vi-fetch-history
bindkey -a "g~" vi-oper-swap-case
bindkey -a "h" vi-backward-char
bindkey -a "^H" vi-backward-char
bindkey -a "i" vi-insert
bindkey -a "I" vi-insert-bol
bindkey -a "^J" accept-line
bindkey -a "j" down-line-or-history
bindkey -a "J" vi-join
bindkey -a "k" up-line-or-history
bindkey -a "^L" clear-screen
bindkey -a "=" list-choices
bindkey -a "l" vi-forward-char
bindkey -a "^M" accept-line
bindkey -a "m" vi-set-mark
bindkey -a "^N" down-history
bindkey -a "n" vi-repeat-search
bindkey -a "N" vi-rev-repeat-search
bindkey -a "^[OA" up-line-or-beginning-search
bindkey -a "^[OB" down-line-or-beginning-search
bindkey -a "^[OC" vi-forward-char
bindkey -a "^[OD" vi-backward-char
bindkey -a "^[OF" end-of-line
bindkey -a "^[OH" beginning-of-line
bindkey -a "O" vi-open-line-above
bindkey -a "o" vi-open-line-below
bindkey -a "#" pound-insert
bindkey -a "^P" up-history
bindkey -a "p" vi-put-after
bindkey -a "P" vi-put-before
bindkey -a "^R" redo
bindkey -a "R" vi-replace
bindkey -a "r" vi-replace-chars
bindkey -a "S" vi-change-whole-line
bindkey -a "s" vi-substitute
bindkey -a "t" vi-find-next-char-skip
bindkey -a "T" vi-find-prev-char-skip
bindkey "^[[A" up-line-or-history
bindkey -a "u" undo
bindkey -a "+" vi-down-line-or-history
bindkey -a "\$" vi-end-of-line
bindkey -a "\^" vi-first-non-blank
bindkey -a " " vi-forward-char
bindkey -a "|" vi-goto-column
bindkey -a "\`" vi-goto-mark
bindkey -a "'" vi-goto-mark-line
bindkey -a "/" vi-history-search-backward
bindkey -a "?" vi-history-search-forward
bindkey -a ">" vi-indent
bindkey -a "%" vi-match-bracket
bindkey -a "." vi-repeat-change
bindkey -a ";" vi-repeat-find
bindkey -a "," vi-rev-repeat-find
bindkey -a "\"" vi-set-buffer
bindkey -a "~" vi-swap-case
bindkey -a "<" vi-unindent
bindkey -a -- "-" vi-up-line-or-history
bindkey -a "V" visual-line-mode
bindkey -a "v" visual-mode
bindkey -a "W" vi-forward-blank-word
bindkey -a "w" vi-forward-word
bindkey -a "X" vi-backward-delete-char
bindkey -a "x" vi-delete-char
bindkey -a "y" vi-yank
bindkey -a "Y" vi-yank-whole-line
bindkey -a "^[[Z" reverse-menu-complete
bindkey "^?" backward-delete-char
bindkey "^[^?" backward-kill-word
bindkey "^[~" _bash_complete-word
bindkey "^B" backward-char
bindkey "^[b" backward-word
bindkey "^[B" backward-word
bindkey "^[[B" down-line-or-history
bindkey "^[<" beginning-of-buffer-or-history
bindkey "^[c" capitalize-word
bindkey "^[C" capitalize-word
bindkey "^[[C" forward-char
bindkey "^[^_" copy-prev-word
bindkey "^[[D" backward-char
bindkey "^D" delete-char-or-list
bindkey "^[d" kill-word
bindkey "^[D" kill-word
bindkey "^[^D" list-choices
bindkey "^E" end-of-line
bindkey "^[>" end-of-buffer-or-history
bindkey "^[ " expand-history
bindkey "^[!" expand-history
bindkey "^F" forward-char
bindkey "^[f" forward-word
bindkey "^[F" forward-word
bindkey "^[g" get-line
bindkey "^[G" get-line
bindkey "^[^G" send-break
bindkey "^G" send-break
bindkey "^H" backward-delete-char
bindkey "^[^H" backward-kill-word
bindkey "^[," _history-complete-newer
bindkey "^[/" _history-complete-older
bindkey "^[h" run-help
bindkey "^[H" run-help
bindkey "^I" expand-or-complete
bindkey "^[_" insert-last-word
bindkey "^[." insert-last-word
bindkey "^[^I" self-insert-unmeta
bindkey "^J" accept-line
bindkey "^[^J" self-insert-unmeta
bindkey "^K" kill-line
bindkey "^[^L" clear-screen
bindkey "^L" clear-screen
bindkey "^[L" down-case-word
bindkey "^M" accept-line
bindkey " " magic-space
bindkey -M command "^G" send-break
bindkey -M command "^J" accept-line
bindkey -M command "^M" accept-line
bindkey "^[m" copy-prev-shell-word
bindkey -M emacs "^[0" digit-argument
bindkey -M emacs "^[[1;5C" forward-word
bindkey -M emacs "^[[1;5D" backward-word
bindkey -M emacs "^[1" digit-argument
bindkey -M emacs "^[[200~" bracketed-paste
bindkey -M emacs "^[2" digit-argument
bindkey -M emacs "^[[2~" overwrite-mode
bindkey -M emacs "^[[3;5~" kill-word
bindkey -M emacs "^[[3~" delete-char
bindkey -M emacs "^[3" digit-argument
bindkey -M emacs "^[4" digit-argument
bindkey -M emacs "^[5" digit-argument
bindkey -M emacs "^[[5~" up-line-or-history
bindkey -M emacs "^[6" digit-argument
bindkey -M emacs "^[[6~" down-line-or-history
bindkey -M emacs "^[7" digit-argument
bindkey -M emacs "^[8" digit-argument
bindkey -M emacs "^[9" digit-argument
bindkey -M emacs "^[a" accept-and-hold
bindkey -M emacs "^[A" accept-and-hold
bindkey -M emacs "^A" beginning-of-line
bindkey -M emacs "^[[A" up-line-or-history
bindkey -M emacs "^?" backward-delete-char
bindkey -M emacs "^[^?" backward-kill-word
bindkey -M emacs "^[~" _bash_complete-word
bindkey -M emacs "^B" backward-char
bindkey -M emacs "^[b" backward-word
bindkey -M emacs "^[B" backward-word
bindkey -M emacs "^[[B" down-line-or-history
bindkey -M emacs "^[<" beginning-of-buffer-or-history
bindkey -M emacs "^[c" capitalize-word
bindkey -M emacs "^[C" capitalize-word
bindkey -M emacs "^[[C" forward-char
bindkey -M emacs "^[^_" copy-prev-word
bindkey -M emacs "^[[D" backward-char
bindkey -M emacs "^D" delete-char-or-list
bindkey -M emacs "^[d" kill-word
bindkey -M emacs "^[D" kill-word
bindkey -M emacs "^[^D" list-choices
bindkey -M emacs "^E" end-of-line
bindkey -M emacs "^[>" end-of-buffer-or-history
bindkey -M emacs "^[ " expand-history
bindkey -M emacs "^[!" expand-history
bindkey -M emacs "^F" forward-char
bindkey -M emacs "^[f" forward-word
bindkey -M emacs "^[F" forward-word
bindkey -M emacs "^[g" get-line
bindkey -M emacs "^[G" get-line
bindkey -M emacs "^[^G" send-break
bindkey -M emacs "^G" send-break
bindkey -M emacs "^H" backward-delete-char
bindkey -M emacs "^[^H" backward-kill-word
bindkey -M emacs "^[," _history-complete-newer
bindkey -M emacs "^[/" _history-complete-older
bindkey -M emacs "^[h" run-help
bindkey -M emacs "^[H" run-help
bindkey -M emacs "^I" expand-or-complete
bindkey -M emacs "^[_" insert-last-word
bindkey -M emacs "^[." insert-last-word
bindkey -M emacs "^[^I" self-insert-unmeta
bindkey -M emacs "^J" accept-line
bindkey -M emacs "^[^J" self-insert-unmeta
bindkey -M emacs "^K" kill-line
bindkey -M emacs "^[^L" clear-screen
bindkey -M emacs "^L" clear-screen
bindkey -M emacs "^[L" down-case-word
bindkey -M emacs "^M" accept-line
bindkey -M emacs " " magic-space
bindkey -M emacs "^[m" copy-prev-shell-word
bindkey -M emacs "^[^M" self-insert-unmeta
bindkey -M emacs "^N" down-line-or-history
bindkey -M emacs "^[-" neg-argument
bindkey -M emacs "^[n" history-search-forward
bindkey -M emacs "^[N" history-search-forward
bindkey -M emacs "^O" accept-line-and-down-history
bindkey -M emacs "^[OA" up-line-or-beginning-search
bindkey -M emacs "^[OB" down-line-or-beginning-search
bindkey -M emacs "^[OC" forward-char
bindkey -M emacs "^[OD" backward-char
bindkey -M emacs "^[OF" end-of-line
bindkey -M emacs "^[OH" beginning-of-line
bindkey -M emacs "^[p" history-search-backward
bindkey -M emacs "^[P" history-search-backward
bindkey -M emacs "^P" up-line-or-history
bindkey -M emacs "^[q" push-line
bindkey -M emacs "^[Q" push-line
bindkey -M emacs "^Q" push-line
bindkey -M emacs "^['" quote-line
bindkey -M emacs "^[\"" quote-region
bindkey -M emacs "^R" history-incremental-search-backward
bindkey -M emacs "^@" set-mark-command
bindkey -M emacs "^S" history-incremental-search-forward
bindkey -M emacs "^[\$" spell-word
bindkey -M emacs "^[s" spell-word
bindkey -M emacs "^[S" spell-word
bindkey -M emacs "^T" transpose-chars
bindkey -M emacs "^[t" transpose-words
bindkey -M emacs "^[T" transpose-words
bindkey -M emacs "^U" kill-whole-line
bindkey -M emacs "^_" undo
bindkey -M emacs "^[u" up-case-word
bindkey -M emacs "^[U" up-case-word
bindkey -M emacs "^[|" vi-goto-column
bindkey -M emacs "^V" quoted-insert
bindkey -M emacs "^W" backward-kill-word
bindkey -M emacs "^[W" copy-region-as-kill
bindkey -M emacs "^[?" which-command
bindkey -M emacs "^[w" kill-region
bindkey -M emacs "^Xa" _expand_alias
bindkey -M emacs "^X~" _bash_list-choices
bindkey -M emacs "^X^B" vi-match-bracket
bindkey -M emacs "^XC" _correct_filename
bindkey -M emacs "^Xc" _correct_word
bindkey -M emacs "^X?" _complete_debug
bindkey -M emacs "^Xd" _list_expansions
bindkey -M emacs "^X^E" edit-command-line
bindkey -M emacs "^Xe" _expand_word
bindkey -M emacs "^[x" execute-named-cmd
bindkey -M emacs "^X*" expand-word
bindkey -M emacs "^X^F" vi-find-next-char
bindkey -M emacs "^Xg" list-expand
bindkey -M emacs "^XG" list-expand
bindkey -M emacs "^Xh" _complete_help
bindkey -M emacs "^X^J" vi-join
bindkey -M emacs "^X^K" kill-buffer
bindkey -M emacs "^Xm" _most_recent_file
bindkey -M emacs "^X^N" infer-next-history
bindkey -M emacs "^Xn" _next_tags
bindkey -M emacs "^X^O" overwrite-mode
bindkey -M emacs "^Xr" history-incremental-search-backward
bindkey -M emacs "^X^R" _read_comp
bindkey -M emacs "^Xs" history-incremental-search-forward
bindkey -M emacs "^Xt" _complete_tag
bindkey -M emacs "^Xu" undo
bindkey -M emacs "^X^U" undo
bindkey -M emacs "^X^V" vi-cmd-mode
bindkey -M emacs "^X=" what-cursor-position
bindkey -M emacs "^X^X" exchange-point-and-mark
bindkey -M emacs "^Y" yank
bindkey -M emacs "^[y" yank-pop
bindkey -M emacs "^[z" execute-last-named-cmd
bindkey -M emacs "^[[Z" reverse-menu-complete
bindkey -M listscroll "^[[B" down-line-or-history
bindkey -M listscroll " " complete-word
bindkey -M listscroll "^I" complete-word
bindkey -M listscroll "^J" accept-line
bindkey -M listscroll "^M" accept-line
bindkey -M listscroll "^[OB" down-line-or-history
bindkey -M menuselect "^[[A" up-line-or-history
bindkey -M menuselect "^[[B" down-line-or-history
bindkey -M menuselect "^[[C" forward-char
bindkey -M menuselect "^[[D" backward-char
bindkey -M menuselect "^I" complete-word
bindkey -M menuselect "^J" accept-line
bindkey -M menuselect "^M" accept-line
bindkey -M menuselect "^O" accept-and-infer-next-history
bindkey -M menuselect "^[OA" up-line-or-history
bindkey -M menuselect "^[OB" down-line-or-history
bindkey -M menuselect "^[OC" forward-char
bindkey -M menuselect "^[OD" backward-char
bindkey -M .safe "^J" .accept-line
bindkey -M .safe "^M" .accept-line
bindkey "^[^M" self-insert-unmeta
bindkey -M viins "^[[1;5C" forward-word
bindkey -M viins "^[[1;5D" backward-word
bindkey -M viins "^[[200~" bracketed-paste
bindkey -M viins "^[[2~" overwrite-mode
bindkey -M viins "^[[3;5~" kill-word
bindkey -M viins "^[[3~" delete-char
bindkey -M viins "^[[5~" up-line-or-history
bindkey -M viins "^[[6~" down-line-or-history
bindkey -M viins "^[[A" up-line-or-history
bindkey -M viins "^?" backward-delete-char
bindkey -M viins "^[[B" down-line-or-history
bindkey -M viins "^[[C" vi-forward-char
bindkey -M viins "^D" list-choices
bindkey -M viins "^[[D" vi-backward-char
bindkey -M viins "^G" list-expand
bindkey -M viins "^H" vi-backward-delete-char
bindkey -M viins "^I" expand-or-complete
bindkey -M viins "^J" accept-line
bindkey -M viins "^K" self-insert
bindkey -M viins "^L" clear-screen
bindkey -M viins "^M" accept-line
bindkey -M viins "^[OA" up-line-or-beginning-search
bindkey -M viins "^[OB" down-line-or-beginning-search
bindkey -M viins "^[OC" vi-forward-char
bindkey -M viins "^[OD" vi-backward-char
bindkey -M viins "^[OF" end-of-line
bindkey -M viins "^[OH" beginning-of-line
bindkey -M viins "^Q" vi-quoted-insert
bindkey -M viins "^R" redisplay
bindkey -M viins "^U" vi-kill-line
bindkey -M viins "^[" vi-cmd-mode
bindkey -M viins "^V" vi-quoted-insert
bindkey -M viins "^W" vi-backward-kill-word
bindkey -M viins "^[[Z" reverse-menu-complete
bindkey -M viopp "aa" select-a-shell-word
bindkey -M viopp "^[[A" up-line
bindkey -M viopp "aW" select-a-blank-word
bindkey -M viopp "aw" select-a-word
bindkey -M viopp "^[[B" down-line
bindkey -M viopp "ia" select-in-shell-word
bindkey -M viopp "iW" select-in-blank-word
bindkey -M viopp "iw" select-in-word
bindkey -M viopp "j" down-line
bindkey -M viopp "k" up-line
bindkey -M viopp "^[OA" up-line
bindkey -M viopp "^[OB" down-line
bindkey -M viopp "^[" vi-cmd-mode
bindkey -M visual "aa" select-a-shell-word
bindkey -M visual "^[[A" up-line
bindkey -M visual "aW" select-a-blank-word
bindkey -M visual "aw" select-a-word
bindkey -M visual "^[[B" down-line
bindkey -M visual "^[" deactivate-region
bindkey -M visual "ia" select-in-shell-word
bindkey -M visual "iW" select-in-blank-word
bindkey -M visual "iw" select-in-word
bindkey -M visual "j" down-line
bindkey -M visual "k" up-line
bindkey -M visual "^[OA" up-line
bindkey -M visual "^[OB" down-line
bindkey -M visual "o" exchange-point-and-mark
bindkey -M visual "p" put-replace-selection
bindkey -M visual "u" vi-down-case
bindkey -M visual "U" vi-up-case
bindkey -M visual "~" vi-oper-swap-case
bindkey -M visual "x" vi-delete
bindkey "^N" down-line-or-history
bindkey "^[-" neg-argument
bindkey "^[n" history-search-forward
bindkey "^[N" history-search-forward
bindkey "^O" accept-line-and-down-history
bindkey "^[OA" up-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search
bindkey "^[OC" forward-char
bindkey "^[OD" backward-char
bindkey "^[OF" end-of-line
bindkey "^[OH" beginning-of-line
bindkey "^[p" history-search-backward
bindkey "^[P" history-search-backward
bindkey "^P" up-line-or-history
bindkey "^[q" push-line
bindkey "^[Q" push-line
bindkey "^Q" push-line
bindkey "^['" quote-line
bindkey "^[\"" quote-region
bindkey -R -a "1"-"9" digit-argument
bindkey "^R" history-incremental-search-backward
bindkey -R -M emacs "\M-^@"-"\M-^?" self-insert
bindkey -R -M emacs "!"-"~" self-insert
bindkey -R "\M-^@"-"\M-^?" self-insert
bindkey -R -M .safe "^@"-"^I" .self-insert
bindkey -R -M .safe "^K"-"^L" .self-insert
bindkey -R -M .safe "^N"-"\M-^?" .self-insert
bindkey -R -M viins "^A"-"^C" self-insert
bindkey -R -M viins "^E"-"^F" self-insert
bindkey -R -M viins "\M-^@"-"\M-^?" self-insert
bindkey -R -M viins "^N"-"^P" self-insert
bindkey -R -M viins "^\\\\"-"~" self-insert
bindkey -R -M viins "^S"-"^T" self-insert
bindkey -R -M viins "^Y"-"^Z" self-insert
bindkey -R "!"-"~" self-insert
bindkey -s -a "g~~" "g~g~"
bindkey -s -a "guu" "gugu"
bindkey -s -a "gUU" "gUgU"
bindkey "^@" set-mark-command
bindkey "^S" history-incremental-search-forward
bindkey -s "^[l" "ls^J"
bindkey -s -M emacs "^[l" "ls^J"
bindkey "^[\$" spell-word
bindkey "^[s" spell-word
bindkey "^[S" spell-word
bindkey "^T" transpose-chars
bindkey "^[t" transpose-words
bindkey "^[T" transpose-words
bindkey "^U" kill-whole-line
bindkey "^_" undo
bindkey "^[u" up-case-word
bindkey "^[U" up-case-word
bindkey "^[|" vi-goto-column
bindkey "^V" quoted-insert
bindkey "^W" backward-kill-word
bindkey "^[W" copy-region-as-kill
bindkey "^[?" which-command
bindkey "^[w" kill-region
bindkey "^Xa" _expand_alias
bindkey "^X~" _bash_list-choices
bindkey "^X^B" vi-match-bracket
bindkey "^XC" _correct_filename
bindkey "^Xc" _correct_word
bindkey "^X?" _complete_debug
bindkey "^Xd" _list_expansions
bindkey "^X^E" edit-command-line
bindkey "^Xe" _expand_word
bindkey "^[x" execute-named-cmd
bindkey "^X*" expand-word
bindkey "^X^F" vi-find-next-char
bindkey "^Xg" list-expand
bindkey "^XG" list-expand
bindkey "^Xh" _complete_help
bindkey "^X^J" vi-join
bindkey "^X^K" kill-buffer
bindkey "^Xm" _most_recent_file
bindkey "^X^N" infer-next-history
bindkey "^Xn" _next_tags
bindkey "^X^O" overwrite-mode
bindkey "^Xr" history-incremental-search-backward
bindkey "^X^R" _read_comp
bindkey "^Xs" history-incremental-search-forward
bindkey "^Xt" _complete_tag
bindkey "^Xu" undo
bindkey "^X^U" undo
bindkey "^X^V" vi-cmd-mode
bindkey "^X=" what-cursor-position
bindkey "^X^X" exchange-point-and-mark
bindkey "^Y" yank
bindkey "^[y" yank-pop
bindkey "^[z" execute-last-named-cmd
bindkey "^[[Z" reverse-menu-complete
