#!/bin/bash
#
# ディレクトリ一覧を表示して選択されたディレクトリを echo する.
# alias j='source  ~/bin/jump.sh'
#

# リストファイル
LIST=~/.jump.list


has_peco=$(which fzf)
# -p       Print list
while getopts "p" flag; do
  case $flag in
    p) opt_p=true
        ;;
  esac
done
shift `expr $OPTIND - 1`

if [ "$opt_p" = true ]; then
  cat $LIST
  exit
fi

if [ $# = 0 -a ! -z "$has_peco" ]; then
  cd $(cat $LIST | $has_peco --reverse)
  return
fi

if [ $# == 0 ]; then
  cat -n $LIST | sed -e "s|$HOME|~|"
  echo -n "No? "
  read no
else
  no=$1
fi

cd `sed -n "${no}p" $LIST`

