#!/bin/bash

#download super pre
root_path=$(dirname "$(readlink -f "$0")")
super_pre_download_url="https://cdn02.moecube.com:444/ygopro-super-pre/archive/ygopro-super-pre.ypk"
super_pre_path="$root_path/install/ygopro-super-pre.ypk"
if [[ -e "$super_pre_path" ]]; then
    rm -rf "$super_pre_path"
fi
curl -C - -o "$super_pre_path" "$super_pre_download_url"
#reset super pre in ygopro-ocg
ygopro_ocg_path="$root_path/ygopro-ocg"
cp -r "${super_pre_path}" "$ygopro_ocg_path/expansions/"
#reset super per in ygopro-mc
ygopro_mc_path=~/.config/MyCardLibrary/ygopro
if [ ! -e "$ygopro_mc_path" ]; then
    echo "Please install mycard ygopro!"
    exit 1
fi
if [ ! -e "$ygopro_mc_path/expansions" ]; then
    mkdir "$ygopro_mc_path/expansions"
fi
cp -r "${super_pre_path}" "$ygopro_mc_path/expansions/"
