#!/bin/bash

#download super pre
root_path=$(dirname "$(readlink -f "$0")")
super_pre_path="$root_path/install/ygopro-super-pre.ypk"
super_pre_download_url="https://cdn02.moecube.com:444/ygopro-super-pre/archive/ygopro-super-pre.ypk"
while true; do
    if [[ -e "$super_pre_path" ]]; then
        rm -rf "$super_pre_path"
    fi
    curl -C - -o "$super_pre_path" "$super_pre_download_url"
    if [ $? -eq 0 ]; then
        break
    fi
done
#reset super pre in ygopro-ocg
ygopro_ocg_path="$root_path/ygopro-ocg"
cp "$super_pre_path" "$ygopro_ocg_path/expansions/"
#reset super per in mycard ygopro
mcpro_path=~/.config/MyCardLibrary/ygopro
if [ ! -e "$mcpro_path" ]; then
    echo "Please install mycard ygopro!"
    exit 1
fi
if [ ! -e "$mcpro_path/expansions" ]; then
    mkdir "$mcpro_path/expansions"
fi
cp "$super_pre_path" "$mcpro_path/expansions/"
