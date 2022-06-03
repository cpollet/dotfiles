#!/bin/zsh

ln $HOME/.local/share/dotfiles-secrets/archive $HOME/.local/share/yadm/archive

$HOME/.local/bin/yadm gitconfig user.name "Christophe Pollet"
$HOME/.local/bin/yadm gitconfig user.email "cpollet@users.noreply.github.com"