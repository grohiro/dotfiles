#!/bin/bash

install -d -m 755 ~/.bash/

DOT_FILES=(.bash_profile .bashrc .bashrc.aliases .bashrc.color .bashrc.env .bashrc.functions .gitconfig .profile .screenrc .vimrc .gitignore .ansible.cfg .gvimrc .globalrc .bash_completion .tmux.conf .tigrc .greprc .anyenvrc)
DOT_DIRS=(.lftp .vim .bash_completion.d .ctags.d)
HOME_BREW_PKGS="bash-completion gawk bash coreutils gnu-sed"

# dot files
for file in ${DOT_FILES[@]}
do
  if [ ! -e $HOME/$file ]
  then
    ln -s $HOME/dotfiles/$file $HOME/$file
  fi
done

# dot directories (depth 1)
for dir in ${DOT_DIRS[@]}
do
  mkdir -p $HOME/$dir
  if [ "`uname`" == 'Linux' ]; then
    files=$(find $HOME/dotfiles/$dir -maxdepth 1)
  else
    files=$(find $HOME/dotfiles/$dir -depth 1)
  fi

  for file in $files
  do
    fname=$(basename $file)
    if [ ! -e $HOME/$dir/$fname ]
    then
      ln -s $file $HOME/$dir/$fname
    fi
  done
done

# Install utilities

if [ ! -e ~/bin/diff-highlight ]
then
  curl https://raw.githubusercontent.com/git/git/v2.13.0/contrib/diff-highlight/diff-highlight > ~/bin/diff-highlight
  chmod 755 ~/bin/diff-highlight
fi

if [ ! -e ~/.bash/git-completion.bash ]
then
  curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash > /tmp/git-completion.bash
  install -m 755 /tmp/git-completion.bash ~/.bash/
fi

# HomeBrew
which brew 2>&1 > /dev/null
if [ $? == 0 ]
then
  for pkg in $HOME_BREW_PKGS
  do
    if [ ! $(brew --prefix $pkg) ]
    then
      brew install $pkg
    fi
  done
fi

# Use bash version4
if [ -f /usr/local/bin/bash ]; then
  sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
  chsh -s /usr/local/bin/bash
fi

# Install bash completion files
bash ~/.bash_completion.d/install
