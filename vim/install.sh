#!/bin/bash

mkdir -p $HOME/.vim/bundle
ln -s $HOME/.dotfiles/vim/snippets $HOME/.vim
ln -s $HOME/.dotfiles/vim/plugin   $HOME/.vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
