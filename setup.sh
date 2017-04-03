#!/bin/bash
DOT_FILES=( .bashrc .bashrc.aliases .bashrc.color .bashrc.env .bashrc.functions .gitconfig .profile .screenrc .vimrc)
DOT_DIRS=( .lftp .vim)

# dot files
for file in ${DOT_FILES[@]}
do
  ln -s $HOME/dotfiles/$file $HOME/$file
done

# dot directories
for dir in ${DOT_DIRS[@]}
do
  mkdir -p $HOME/$dir
  for file in $(find $HOME/dotfiles/$dir -type f -depth 1)
  do
    fname=$(basename $file)
    ln -s $file $HOME/$dir/$fname
  done
done
