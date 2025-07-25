#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
source "$root_path/lib_download.sh"

check_ygopro(){
    local ygopro_dir_path="$1"
    if [ ! -e "$ygopro_dir_path/ygopro" ]; then
        return 0
    else
        return 1
    fi
}
check_mdpro3(){
    local mdpro3_dir_path="$1"
    if [ ! -e "$mdpro3_dir_path/MDPro3" ]; then
        return 0
    else
        return 1
    fi
}
mkdir_expansions(){
    local ygopro_dir_path="$1"
    if [ ! -e "$ygopro_dir_path/expansions" ]; then
        mkdir "$ygopro_dir_path/expansions"
    fi
}
mkdir_mdpro3_expansions(){
    local mdpro3_dir_path="$1"
    if [ ! -e "$mdpro3_dir_path/Expansions" ]; then
        mkdir "$mdpro3_dir_path/Expansions"
    fi
}
copy_super_pre(){
    local ygopro_dir_path="$1"
    check_ygopro "$ygopro_dir_path"
    if [ $? -eq 1 ]; then
        mkdir_expansions "$ygopro_dir_path"
        cp -f "$super_pre_path" "$ygopro_dir_path/expansions/ygopro-super-pre.ypk"
        echo "Update $ygopro_dir_path super-pre."
    else
        echo "$ygopro_dir_path hasn't ygopro, please install it."
    fi
}
copy_mdpro3_super_pre(){
    local mdpro3_dir_path="$1"
    check_mdpro3 "$mdpro3_dir_path"
    if [ $? -eq 1 ]; then
        mkdir_mdpro3_expansions "$mdpro3_dir_path"
        cp -f "$super_pre_path" "$mdpro3_dir_path/Expansions/ygopro-super-pre.ypk"
        echo "Update $mdpro3_dir_path super-pre."
    else
        echo "$mdpro3_dir_path hasn't mdpro3, please install it."
    fi
}
check_and_copy_super_pre(){
    local ygopro_dir_path="$1"
    check_ygopro "$ygopro_dir_path"
    if [ $? -eq 0 ]; then
        echo "$ygopro_dir_path hasn't ygopro, please install it."
        return
    fi
    mkdir_expansions "$ygopro_dir_path"
    local local_path="$ygopro_dir_path/expansions/ygopro-super-pre.ypk"
    if [ ! -e "$local_path" ]; then
        cp "$super_pre_path" "$local_path"
        echo "Update $ygopro_dir_path super-pre."
        return
    fi
    local local_size=$(stat -c%s "$local_path")
    local install_size=$(stat -c%s "$super_pre_path")
    if [ "$local_size" -ne "$install_size" ]; then
        cp "$super_pre_path" "$local_path"
        echo "Update $ygopro_dir_path super-pre."
    fi
}
check_and_copy_mdpro3_super_pre(){
    local mdpro3_dir_path="$1"
    check_mdpro3 "$mdpro3_dir_path"
    if [ $? -eq 0 ]; then
        echo "$mdpro3_dir_path hasn't mdpro3, please install it."
        return
    fi
    mkdir_mdpro3_expansions "$mdpro3_dir_path"
    local local_path="$mdpro3_dir_path/Expansions/ygopro-super-pre.ypk"
    if [ ! -e "$local_path" ]; then
        cp -f "$super_pre_path" "$local_path"
        echo "Update $mdpro3_dir_path super-pre."
        return
    fi
    local local_size=$(stat -c%s "$local_path")
    local install_size=$(stat -c%s "$super_pre_path")
    if [ "$local_size" -ne "$install_size" ]; then
        cp "$super_pre_path" "$local_path"
        echo "Update $mdpro3_dir_path super-pre."
    fi
}
update_super_pre(){
    local super_pre_path="$root_path/install/ygopro-super-pre.ypk"
    local super_pre_download_url="https://cdn02.moecube.com:444/ygopro-super-pre/archive/ygopro-super-pre.ypk"
    local ygopro_ocg_path="$root_path/ygopro-ocg"
    local mcpro_dir_path=~/.config/MyCardLibrary/ygopro
    local mdpro3_dir_path=~/.config/MyCardLibrary/mdpro3
    #check remote super pre update
    check_update "$super_pre_download_url" "$super_pre_path" "super-pre" "install/super-pre"
    #update install/super pre
    if [ $? -eq 1 ]; then
        download "$super_pre_download_url" "$super_pre_path"
        copy_super_pre "$ygopro_ocg_path"
        copy_super_pre "$mcpro_dir_path"
        copy_mdpro3_super_pre "$mdpro3_dir_path"
    else
        check_and_copy_super_pre "$ygopro_ocg_path"
        check_and_copy_super_pre "$mcpro_dir_path"
        check_and_copy_mdpro3_super_pre "$mdpro3_dir_path"
    fi
}
update_super_pre
