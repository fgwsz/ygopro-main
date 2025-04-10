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
        cp "$super_pre_path" "$ygopro_ocg_path/expansions/ygopro-super-pre.ypk"
        echo "$ygopro_path installed new super-pre."
    else
        echo "$ygopro_path has not ygopro, please install."
    fi
}
update_super_pre(){
    local super_pre_path="$root_path/install/ygopro-super-pre.ypk"
    local super_pre_download_url="https://cdn02.moecube.com:444/ygopro-super-pre/archive/ygopro-super-pre.ypk"
    local download_flag=false
    local ygopro_ocg_path="$root_path/ygopro-ocg"
    local mcpro_path=~/.config/MyCardLibrary/ygopro
    #check remote supre pre update
    check_update "$super_pre_download_url" "$super_pre_path" "super-pre" "install/super-pre"
    #update install/super pre
    if [ $? -eq 1 ]; then
        download "$super_pre_download_url" "$super_pre_path"
        download_flag=true
    fi
    if [ $download_flag = true ]; then
        copy_super_pre "$ygopro_ocg_path"
        copy_super_pre "$mcpro_path"
    fi
}
update_super_pre
