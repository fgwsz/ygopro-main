#!/bin/bash

ygopro_filename="KoishiPro-master-linux-zh-CN.tar.gz"
ygopro_download_url="https://cdn02.moecube.com:444/koishipro/archive/$ygopro_filename"
ygopro_path="./install/$ygopro_filename"
ygopro_old_path="./install/${ygopro_filename}.old"

if [[ -e "$ygopro_path" ]]; then
    mv "$ygopro_path" "$ygopro_old_path"
fi
curl -C - -o "$ygopro_path" "$ygopro_download_url"
