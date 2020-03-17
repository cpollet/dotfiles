#!/bin/bash

git clone https://github.com/cpollet/gitconfig.git .gitconfig.git

ln -s .gitconfig.git/gitconfig .gitconfig
ln -s .gitconfig.git/gitignore .gitignore
