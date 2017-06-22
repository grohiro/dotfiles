#!/bin/bash

install -d -m 755 ~/.bash/

DOT_FILES=(.bashrc .bashrc.aliases .bashrc.color .bashrc.env .bashrc.functions .gitconfig .profile .screenrc .vimrc .gitignore .ansible.cfg .gvimrc .globalrc .bash_completion)
DOT_DIRS=(.lftp .vim .bash_completion.d)
HOME_BREW_PKGS="bash-completion gawk bash"

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
  for file in $(find $HOME/dotfiles/$dir -depth 1)
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
  curl https://raw.githubusercontent.com/git/git/master/contrib/diff-highlight/diff-highlight > ~/bin/diff-highlight
  chmod 755 ~/bin/diff-highlight
fi

if [ ! -e ~/.bash/git-completion.bash ]
then
  curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash > /tmp/git-completion.bash
  install -m 755 /tmp/git-completion.bash ~/.bash/
fi

# HomeBrew
which brew > /dev/null
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
sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
chsh -s /usr/local/bin/bash

# Install bash completion files
bash ~/.bash_completion.d/install

