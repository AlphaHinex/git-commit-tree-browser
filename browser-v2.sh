#!/bin/bash

# 列出当前目录下的所有文件，按名称排序
files=($(ls -t *.txt))

# 用于存储文件内容的数组
declare -a file_contents=()

# 读取所有文件内容到数组中
for file in "${files[@]}"; do
  if [ -f "$file" ]; then
    file_contents+=("$(cat "$file")")
  fi
done

# 当前显示的文件索引
current_index=0

# 显示文件内容的函数
show_file() {
  # 清屏
  clear
  # 显示当前文件名
  echo "File: ${files[$current_index]}"
  # 显示当前文件内容
  echo "${file_contents[$current_index]}"
}

# 主循环，用于显示文件内容并处理用户输入
while true; do
  # 显示当前文件
  show_file

  # 读取用户输入
  read -p "Press left/right arrow to navigate, or Enter to jump to a file: " -s -n 3 key

  # 检查用户按下的键
  case $key in
    $'\e[D') # 左方向键
      ((current_index--))
      if [ $current_index -lt 0 ]; then
        current_index=0
      fi
      ;;
    $'\e[C') # 右方向键
      ((current_index++))
      if [ $current_index -ge${#files[@]} ]; then
        current_index=$((current_index - 1))
      fi
      ;;
    *) # 其他输入
      # 如果输入了字符，则认为用户要输入文件名
      read -p "Enter the filename to jump to: " filename
      # 检查输入是否为文件名
      if [[ " ${files[*]} " == *"$filename "* ]]; then
        # 跳转到指定文件
        current_index=$(echo "${files[@]}" | tr ' ' '\n' | nl | grep -w "$filename" | awk '{print$1 - 1}')
      else
        echo "File not found."
      fi
      ;;
  esac
done

# 结束脚本
echo "Script ended."

