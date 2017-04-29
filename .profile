# Environment variables
if [ -z "$PROMPT_COMMAND" ]; then
  export PROMPT_COMMAND="source ~/dotfiles/bin/lsdir-push"
fi

export SCREENDIR=~/.screen/session
export GOPATH=~/go
export JAVA_HOME=/usr
export EDITOR="vim"
export LANG=ja_JP.UTF-8

# Setting command search path
# System path
PATH=""
PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:$PATH
PATH=/opt/local/bin:/opt/local/sbin:$PATH
PATH=/usr/local/opt/coreutils/bin:$PATH

# Application path
PATH=/usr/local/postgresql83/bin:$PATH

# User path
PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"
PATH=$GOPATH/bin:$PATH
PATH=~/.composer/vendor/bin:$PATH
PATH=~/.nodebrew/current/bin:$PATH
PATH=~/git/phplint:$PATH
PATH=~/bin:$PATH
PATH=./node_modules/.bin:$PATH
PATH=./vendor/.bin:$PATH
export PATH

test -r ~/.bashrc && . ~/.bashrc
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

eval "$(ndenv init -)"

screen -ls
