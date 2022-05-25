#!/bin/zsh

CWD=$(pwd)
cd $HOME

# yadm submodule add https://github.com/tmux-plugins/tpm  .config/tmux/plugins/tpm

$HOME/.local/bin/yadm submodule update --recursive --init

export TMUX_PLUGIN_MANAGER_PATH=$HOME/.config/tmux/plugins

$TMUX_PLUGIN_MANAGER_PATH/tpm/bin/clean_plugins
$TMUX_PLUGIN_MANAGER_PATH/tpm/bin/install_plugins
$TMUX_PLUGIN_MANAGER_PATH/tpm/bin/update_plugins all

cd "$CWD"