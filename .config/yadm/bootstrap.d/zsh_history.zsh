#!/bin/zsh

[ -f $HOME/.zsh_history ] && [ ! -f $HOME/.config/zsh/history ] \
    && mv $HOME/.zsh_history $HOME/.config/zsh/history 

[ ! -f $HOME/.config/zsh/history ] && touch $HOME/.config/zsh/history

chmod 0600 $HOME/.config/zsh/history