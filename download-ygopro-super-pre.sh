#!/bin/bash

ygopro_super_pre_filename="ygopro-super-pre.ypk"
ygopro_super_pre_download_url="https://cdn02.moecube.com:444/ygopro-super-pre/archive/$ygopro_super_pre_filename"
ygopro_super_pre_path="./install/$ygopro_super_pre_filename"
ygopro_super_pre_old_path="./install/${ygopro_super_pre_filename}.old"

if [[ -e "$ygopro_super_pre_path" ]]; then
    mv "$ygopro_super_pre_path" "$ygopro_super_pre_old_path"
fi
curl -C - -o "$ygopro_super_pre_path" "$ygopro_super_pre_download_url"
