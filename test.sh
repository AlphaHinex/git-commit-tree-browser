#!/bin/bash

repo=AIAS

rm -f *.txt

# 使用ls命令按时间排序并获取文件列表，然后使用awk提取文件名
for commit in $(git --git-dir=$repo/.git log --all --pretty=format:'%h'); do
  git --git-dir=$repo/.git --work-tree=$repo checkout $commit
  tree -N -d -L 3 > "$commit".txt
  echo $commit >> "$commit".txt
done

