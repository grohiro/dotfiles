#!/bin/bash
#
# ディレクトリ一覧を表示して選択されたディレクトリを echo する.
# alias j='source  ~/bin/jump.sh'
#

# リストファイル
if [ $# == 0 ]
then
  echo ${LSDIR[*]} | tr " " "\n" 
  #echo ${LSDIR[*]} | tr " " "\n" | sed -e "s|$HOME|~|" | cat -n
	#echo -n "No? "
	#read no
else
	no=$1
  cd `echo ${LSDIR[*]} | tr " " "\n" | sed -n "${no}p"`
fi

#cd `echo ${LSDIR[*]} | tr " " "\n" | sed -n "${no}p"`

