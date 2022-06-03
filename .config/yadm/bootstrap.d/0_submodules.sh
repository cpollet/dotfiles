#!/bin/bash

# make sure yadm is here...
unset -f yadm && ! command -v yadm &> /dev/null && source <(curl -L bootstrap.yadm.io)

CWD=$(pwd)
cd $HOME

# yadm submodule add https://github.com/olivierverdier/zsh-git-prompt.git .config/zsh/plugins/zsh-git-prompt
# yadm submodule add https://github.com/zsh-users/zsh-syntax-highlighting.git .config/zsh/plugins/zsh-syntax-highlighting
# yadm submodule add https://github.com/jeffreytse/zsh-vi-mode.git .config/zsh/plugins/zsh-vi-mode
# yadm submodule add https://github.com/reegnz/jq-zsh-plugin.git .config/zsh/plugins/jq-zsh-plugin

# yadm submodule add $DOTFILES_SECRETS_REPO .local/share/dotfiles-secrets

# yadm submodule add https://github.com/TheLocehiliosan/yadm.git .local/lib/yadm

yadm submodule update --recursive --init

cd "$CWD"