#!/bin/bash

ygopro_filename="ygopro.tar.gz"
ygopro_download_url="https://cdn02.moecube.com:444/koishipro/archive/KoishiPro-master-linux-zh-CN.tar.gz"
ygopro_path="./install/$ygopro_filename"

if [[ -e "$ygopro_path" ]]; then
    rm -rf "$ygopro_path"
fi
curl -C - -o "$ygopro_path" "$ygopro_download_url"
tar -zxvf "$ygopro_path" -C ./ygopro-ocg/
tar -zxvf "$ygopro_path" -C ./ygopro-408/
./reset-ext.sh
./reset-deck.sh
./update-super-pre.sh
