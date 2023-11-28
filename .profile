# Environment variables

if [ -z "$PROMPT_COMMAND" ]; then
  export PROMPT_COMMAND="source ~/dotfiles/bin/lsdir-push"
else
  export PROMPT_COMMAND="$PROMPT_COMMAND; source ~/dotfiles/bin/lsdir-push"
fi

export SCREENDIR=~/.screen/session
export JAVA_HOME=`/usr/libexec/java_home`
export EDITOR="vim"
export LANG=ja_JP.UTF-8

# Setting command search path
# System path
PATH=""
PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:$PATH
PATH=/opt/local/bin:/opt/local/sbin:$PATH
PATH=/usr/local/opt/coreutils/bin:$PATH
#PATH=$HOME/Library/Android/sdk/platform-tools:$PATH
#PATH=$HOME/lib/web3j-3.5.0/bin:$PATH
#PATH=$HOME/lib/apache-maven-2.2.1/bin:$PATH
#PATH=$HOME/lib/LibreOffice.app/Contents/MacOS:$PATH
PATH=$HOME/.poetry/bin:$PATH
PATH=/opt/homebrew/bin:$PATH
PATH=/opt/homebrew/sbin:$PATH
PATH=/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin:$PATH

# Application path
PATH=/usr/local/postgresql83/bin:$PATH

# User path
PATH=$HOME/.anyenv/bin:$PATH
#eval "$(anyenv init -)"
. ~/.anyenvrc

#PATH=$PATH:$GOPATH/bin
#PATH=~/.composer/vendor/bin:$PATH
#PATH=~/.nodebrew/current/bin:$PATH
#PATH=~/git/phplint:$PATH
#PATH=~/bin:$PATH
#PATH=./node_modules/.bin:$PATH
#PATH=./vendor/bin:$PATH
export PATH

export BASH_SILENCE_DEPRECATION_WARNING=1

test -r ~/.bashrc && . ~/.bashrc
#test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

tmux ls

export PATH="$HOME/.poetry/bin:$PATH"

#source ~/.profile.anaconda
if [ -e $HOME/.cargo/env ]
then
  . "$HOME/.cargo/env"
fi
