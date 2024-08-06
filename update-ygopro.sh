#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
ygopro_filename="ygopro.tar.gz"
ygopro_download_url="https://cdn02.moecube.com:444/koishipro/archive/KoishiPro-master-linux-zh-CN.tar.gz"
ygopro_path="$root_path/install/$ygopro_filename"

if [[ -e "$ygopro_path" ]]; then
    rm -rf "$ygopro_path"
fi
curl -C - -o "$ygopro_path" "$ygopro_download_url"
tar -zxvf "$ygopro_path" -C "$root_path/ygopro-ocg/"
tar -zxvf "$ygopro_path" -C "$root_path/ygopro-408/"
"$root_path/reset-ext.sh"
"$root_path/reset-deck.sh"
"$root_path/update-super-pre.sh"
