#!/bin/zsh

cd $HOME

# yadm submodule add https://github.com/olivierverdier/zsh-git-prompt.git .config/zsh/plugins/zsh-git-prompt
# yadm submodule add https://github.com/zsh-users/zsh-syntax-highlighting.git .config/zsh/plugins/zsh-syntax-highlighting
# yadm submodule add https://github.com/jeffreytse/zsh-vi-mode.git .config/zsh/plugins/zsh-vi-mode

yadm submodule update --recursive --init