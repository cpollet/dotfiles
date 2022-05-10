#!/bin/zsh

#- name: "Clone tpm"
#  git:
#    repo: https://github.com/tmux-plugins/tpm 
#    dest: ~/.config/tmux/plugins/tpm
#    update: yes
#
#- name: Cleanup tmux plugins
#  shell: TMUX_PLUGIN_MANAGER_PATH=$HOME/.config/tmux/plugins ~/.config/tmux/plugins/tpm/bin/clean_plugins
#
#- name: Install tmux plugins
#  shell: TMUX_PLUGIN_MANAGER_PATH=$HOME/.config/tmux/plugins ~/.config/tmux/plugins/tpm/bin/install_plugins
#
#- name: Update tmux plugins
#  shell: TMUX_PLUGIN_MANAGER_PATH=$HOME/.config/tmux/plugins ~/.config/tmux/plugins/tpm/bin/update_plugins all