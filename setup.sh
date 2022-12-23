#!/bin/bash
DOT_FILES=(.zshrc .vimrc)
for file in ${DOT_FILES[@]}
do
    ln -svf ~/git/taiki/dotfiles/$file ~/
done