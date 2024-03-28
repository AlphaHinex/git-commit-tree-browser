#!/bin/bash

# 列出当前目录下的所有文本文件
for file in $(ls -lt *.txt| awk '/^[-d]/ {print$NF}'); do
  # 检查文件是否存在
  if [ -f "$file" ]; then
    # 清屏
    clear
    
    # 将光标移动到居中的位置
    tput cup 0 0
    
    # 显示文件内容
    #head -80 "$file"
    cat $file
    
    # 等待(秒)
    #sleep 1 
    # 暂停脚本，等待用户按任意键
    read -s -n 1 -p "Press any key to continue..."
  fi
done

# 将光标恢复到屏幕底部
tput cup $TERM_HEIGHT 0

