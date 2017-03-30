#!/bin/bash
#
# 近くのディレクトリ一覧を表示して移動する
#

if [ $# -lt 1 ]
then
	basedir="../"
else
	basedir=$1
fi

no=0
paths=()
for d1 in `find $basedir -type d \! -name ".*" -depth 1`
do
	no=$((no + 1))
	paths[$no]=$d1
	echo $no")" ${d1/$basedir/}"/"
	for d2 in `find $d1 -type d \! -name ".*" -depth 1`
	do
		no=$((no + 1))
		paths[$no]=$d2
		echo -n " "$no")   "
		echo ${d2/$d1/}"/"
	done
done
echo -n "no? "
read c
cd ${paths[$c]}



