#!/bin/bash

if [ -z "$1" ]; then
    echo "Error: Missing required parameter."
    echo "Usage: $0 <path_to_git_repo>"
    exit 1
fi

echo "Prepare to generate each commit file tree of git repo: $1"

repo=$1

rm -f *.txt

# 使用ls命令按时间排序并获取文件列表，然后使用awk提取文件名
for commit in $(git --git-dir=$repo/.git log --all --pretty=format:'%h'); do
  git --git-dir=$repo/.git --work-tree=$repo checkout $commit
  tree -N -d -L 3 > "$commit".txt
  echo $commit >> "$commit".txt
done

