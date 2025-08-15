export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

if [ -f ~/.bash/git-completion.bash ]; then
  . ~/.bash/git-completion.bash
fi

eval "$(anyenv init -)"

test -r ~/.bashrc && . ~/.bashrc
