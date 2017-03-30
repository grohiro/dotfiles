#!/bin/bash
#
# 複数の画像を結合して1枚のタイル画像を作成します.
#

IM_FILE="png32:"

if [ $# -lt 5 ]
then
	echo "Usage: tile.sh num_col width height filename file [...]"
	echo "  num_col          横の画像数"
	echo "  width            タイル画像のサイズ"
	echo "  height           タイル画像のサイズ"
	echo "  filename         出力ファイル名"
	exit 1
fi

numCol=$1
width=$2
height=$3
output=$4
shift 4

if [ -e $output ]
then
	echo "出力先は既に存在します: $output"
	exit 1
fi


#if [ $((numCol * numRow)) -ne $# ]
#then
	#echo "ファイル数とタイルの数が一致しません: ${numCol}x${numRow} のタイル, ${#}枚の画像"
	#exit 1
#fi

colCount=0
rowCount=0
for file in $@
do
	colCount=$((colCount + 1))

	if [ $colCount -gt $numCol ]
	then
		rowCount=$((rowCount + 1))
		colCount=1
		if [ -e $output ]
		then
			convert -append $output $ftmp $IM_FILE$output
		else
			cp -f $ftmp $output
		fi

		rm -f $ftmp
	fi

	ftmp=$output.$rowCount.tmp
	if [ -e $ftmp ]
	then
		convert +append $ftmp $file $IM_FILE$ftmp
	else
		cp -f $file $ftmp
	fi
done

if [ -e $output ]
then
	convert -append $output $ftmp $IM_FILE$output
else
	cp -f $ftmp $output
fi

rm -f $ftmp


cmd="convert -background None -extent "!${width}x${height}" $output $IM_FILE$output"
echo $cmd
$cmd

