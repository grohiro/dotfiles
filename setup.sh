#!/bin/bash

install -d -m 755 ~/.bash/

DOT_FILES=( .bashrc .bashrc.aliases .bashrc.color .bashrc.env .bashrc.functions .gitconfig .profile .screenrc .vimrc .gitignore .ansible.cfg .gvimrc .globalrc)
DOT_DIRS=( .lftp .vim)

# dot files
for file in ${DOT_FILES[@]}
do
  ln -s $HOME/dotfiles/$file $HOME/$file
done

# dot directories (depth 1)
for dir in ${DOT_DIRS[@]}
do
  mkdir -p $HOME/$dir
  for file in $(find $HOME/dotfiles/$dir -depth 1)
  do
    fname=$(basename $file)
    ln -s $file $HOME/$dir/$fname
  done
done

# Install utilities

if [ ! -e ~/bin/diff-highlight ]
then
  curl https://raw.githubusercontent.com/git/git/master/contrib/diff-highlight/diff-highlight > ~/bin/diff-highlight
  chmod 755 ~/bin/diff-highlight
fi

if [ ! -e ~/.bash/git-completion.bash ]
then
  curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash > /tmp/git-completion.bash
  install -m 755 /tmp/git-completion.bash ~/.bash/
fi

# HomeBrew
which brew
if [ $? == 0 ]
then
  brew install bash-completion
fi
