#!/bin/sh
echo "実行者: $(whoami)"

#####
echo "converting xlsx to csv"
pip install xlsx2csv
xlsx2csv test.xlsx test.csv

#####
echo "parsing test.csv"
filename='test.csv'
index=1 # for excluding header
targetRow=2

declare -a unSentLineNoArray # declare array

while read line; do
    flag=$(echo "$line" | cut -d, -f1) # 1st column
    jpWord=$(echo "$line" | cut -d, -f2) # Column: 1
    mmWord=$(echo "$line" | cut -d, -f3) # Column: 2
    # echo "flag=$flag">&2
    # echo "jpWord=$jpWord">&2
    # echo "mmWord=$mmWord">&2

    if [[ "$flag" = "0" ]] ; then  
      unSentLineNoArray+=($index)
    fi

    index=$((index+1)) # increments index
done < $filename

#echo "${unSentLineNoArray[@]}"
randomChoiceNo=${unSentLineNoArray[$RANDOM % ${#unSentLineNoArray[@]} ]}
echo "random choice line: $randomChoiceNo">&2

##### extract line with randomChoiceNo ## to fix

sed "$randomChoiceNo,$randomChoiceNo!d" $filename
echo $row

#####
count= wc -l < test.csv
echo "line numbers of test.csv $count"
