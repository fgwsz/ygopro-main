#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
super_pre_filename="ygopro-super-pre.ypk"
super_pre_download_url="https://cdn02.moecube.com:444/ygopro-super-pre/archive/ygopro-super-pre.ypk"
super_pre_path="$root_path/install/$super_pre_filename"

if [[ -e "$super_pre_path" ]]; then
    rm -rf "$super_pre_path"
fi
curl -C - -o "$super_pre_path" "$super_pre_download_url"
cp -r "${super_pre_path}" "$root_path/ygopro-ocg/expansions/"
