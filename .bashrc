# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# color schema
if [ -f ~/.bashrc.color ]; then
  . ~/.bashrc.color
fi

# environment variables
if [ -f ~/.bashrc.env ]; then
  . ~/.bashrc.env
fi

# command aliases 
if [ -f ~/.bashrc.aliases ]; then
  . ~/.bashrc.aliases
fi

# shell functions
if [ -f ~/.bashrc.functions ]; then
  . ~/.bashrc.functions
fi

# local settings
if [ -f ~/.bashrc.local ]
then
  source ~/.bashrc.local
fi

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

if [ -f ~/.bash/git-completion.bash ]; then
  . ~/.bash/git-completion.bash
fi
