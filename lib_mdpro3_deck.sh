#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
pull_mdpro3_deck(){
    local mdpro3_dir_path="$1"
    local deck_repo_path="$mdpro3_dir_path/ygopro-deck"
    local deck_path="$mdpro3_dir_path/Deck"
    if [[ ! -e "$deck_repo_path" ]]; then
        cd "$mdpro3_dir_path"
        git clone "git@github.com:fgwsz/ygopro-deck.git"
    else
        cd "$deck_repo_path"
        git pull
        "$deck_repo_path/pull-deck.sh"
    fi
    rm -rf "$deck_path"/*.ydk
    cp -f "$deck_repo_path/ocg"/*.ydk "$deck_path/"
}
push_mdpro3_deck(){
    local mdpro3_dir_path="$1"
    local deck_repo_path="$mdpro3_dir_path/ygopro-deck"
    local deck_path="$mdpro3_dir_path/Deck"
    #遍历deck_path下所有以" - 复制.ydk"结尾的文件
    for deck_file in "$deck_path"/*" - 复制.ydk"; do
        #检查文件是否存在(避免无匹配时执行错误操作)
        if [ -f "$deck_file" ]; then
            #提取原文件名
            base_name=$(basename "$deck_file")
            #去掉" - 复制"部分,构造新文件名
            new_name="${base_name/ - 复制/}"
            #重命名文件(保留原路径)
            mv -v "$deck_file" "$deck_path/$new_name"
        fi
    done
    rm -rf "$deck_repo_path/ocg"/*.ydk
    cp -f "$deck_path"/*.ydk "$deck_repo_path/ocg/"
    "$deck_repo_path/push-deck.sh"
}
