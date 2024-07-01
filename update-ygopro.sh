#!/bin/bash

ygopro_filename="KoishiPro-master-linux-zh-CN.tar.gz"
ygopro_download_url="https://cdn02.moecube.com:444/koishipro/archive/$ygopro_filename"
ygopro_path="./install/$ygopro_filename"
ygopro_old_path="./install/${ygopro_filename}.old"

if [[ -e "$ygopro_path" ]]; then
    mv "$ygopro_path" "$ygopro_old_path"
fi
curl -o "$ygopro_path" "$ygopro_download_url"
tar -zxvf "$ygopro_path" -C ./ygopro-ocg/
tar -zxvf "$ygopro_path" -C ./ygopro-408/
./update-ext.sh
rm -rf ./ygopro-ocg/deck/*
rm -rf ./ygopro-408/deck/*
./update-deck.sh
