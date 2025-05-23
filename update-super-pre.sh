#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
source "$root_path/lib_download.sh"

check_ygopro(){
    local ygopro_path="$1"
    if [ ! -e "$ygopro_path/ygopro" ]; then
        return 0
    else
        return 1
    fi
}
mkdir_expansions(){
    local ygopro_path="$1"
    if [ ! -e "$ygopro_path/expansions" ]; then
        mkdir "$ygopro_path/expansions"
    fi
}
copy_super_pre(){
    local ygopro_path="$1"
    check_ygopro "$ygopro_path"
    if [ $? -eq 1 ]; then
        mkdir_expansions "$ygopro_path"
        cp "$super_pre_path" "$ygopro_path/expansions/ygopro-super-pre.ypk"
        echo "Update $ygopro_path super-pre."
    else
        echo "$ygopro_path hasn't ygopro, please install it."
    fi
}
check_and_copy_super_pre(){
    local ygopro_path="$1"
    check_ygopro "$ygopro_path"
    if [ $? -eq 0 ]; then
        echo "$ygopro_path hasn't ygopro, please install it."
        return
    fi
    mkdir_expansions "$ygopro_path"
    local local_path="$ygopro_path/expansions/ygopro-super-pre.ypk"
    if [ ! -e "$local_path" ]; then
        cp "$super_pre_path" "$local_path"
        echo "Update $ygopro_path super-pre."
        return
    fi
    local local_size=$(stat -c%s "$local_path")
    local install_size=$(stat -c%s "$super_pre_path")
    if [ "$local_size" -ne "$install_size" ]; then
        cp "$super_pre_path" "$local_path"
        echo "Update $ygopro_path super-pre."
    fi
}
update_super_pre(){
    local super_pre_path="$root_path/install/ygopro-super-pre.ypk"
    local super_pre_download_url="https://cdn02.moecube.com:444/ygopro-super-pre/archive/ygopro-super-pre.ypk"
    local ygopro_ocg_path="$root_path/ygopro-ocg"
    local mcpro_path=~/.config/MyCardLibrary/ygopro
    #check remote super pre update
    check_update "$super_pre_download_url" "$super_pre_path" "super-pre" "install/super-pre"
    #update install/super pre
    if [ $? -eq 1 ]; then
        download "$super_pre_download_url" "$super_pre_path"
        copy_super_pre "$ygopro_ocg_path"
        copy_super_pre "$mcpro_path"
    else
        check_and_copy_super_pre "$ygopro_ocg_path"
        check_and_copy_super_pre "$mcpro_path"
    fi
}
update_super_pre
