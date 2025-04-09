#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
source "$root_path/lib_download.sh"

super_pre_path="$root_path/install/ygopro-super-pre.ypk"
super_pre_download_url="https://cdn02.moecube.com:444/ygopro-super-pre/archive/ygopro-super-pre.ypk"
download_flag=false
#check remote supre pre update
check_update "$super_pre_download_url" "$super_pre_path" "super-pre" "install/super-pre"
#update install/super pre
if [ $? -eq 1 ]; then
    download "$super_pre_download_url" "$super_pre_path"
    download_flag=true
fi
#update ocg/super pre
ygopro_ocg_path="$root_path/ygopro-ocg"
if [ ! -e "$ygopro_ocg_path/expansions" ]; then
    mkdir "$ygopro_ocg_path/expansions"
fi
super_pre_ocg_path="$ygopro_ocg_path/expansions/ygopro-super-pre.ypk"
if [ $download_flag = true ]; then
    cp "$super_pre_path" "$super_pre_ocg_path"
    echo "Update ocg/super-pre."
fi
#update mcpro/super per
mcpro_path=~/.config/MyCardLibrary/ygopro
if [ ! -e "$mcpro_path" ]; then
    echo "Please install mycard ygopro!"
    exit 1
fi
if [ ! -e "$mcpro_path/expansions" ]; then
    mkdir "$mcpro_path/expansions"
fi
super_pre_mcpro_path="$mcpro_path/expansions/ygopro-super-pre.ypk"
if [ $download_flag = true ]; then
    cp "$super_pre_path" "$super_pre_mcpro_path"
    echo "Update mcpro/super-pre."
fi
