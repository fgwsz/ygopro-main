#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
source "$root_path/lib_download.sh"
source "$root_path/lib_deck.sh"

ygopro_path="$root_path/install/ygopro.tar.gz"
ygopro_download_url="https://cdn02.moecube.com:444/koishipro/archive/KoishiPro-master-linux-zh-CN.tar.gz"
#check remote ygopro update
check_update "$ygopro_download_url" "$ygopro_path" "ygopro" "install/ygopro"
#update install/ygopro
if [ $? -eq 1 ]; then
    download_big_file "$ygopro_download_url" "$ygopro_path"
    tar -zxvf "$ygopro_path" -C "$root_path/ygopro-ocg/"
    tar -zxvf "$ygopro_path" -C "$root_path/ygopro-408/"
    tar -zxvf "$ygopro_path" -C "$root_path/ygopro-2011_11_11/"
    #reset ext
    cp -r "$root_path/install/ocg-ext"/* "$root_path/ygopro-ocg/"
    cp -r "$root_path/install/408-ext"/* "$root_path/ygopro-408/"
    cp -r "$root_path/install/2011_11_11-ext"/* "$root_path/ygopro-2011_11_11/"
    #reset deck
    pull_install_deck
    copy_install_deck "$root_path/ygopro-ocg"
    copy_install_deck "$root_path/ygopro-408"
    copy_install_deck "$root_path/ygopro-2011_11_11"
fi
#check ygopro ocg
if [ ! -e "$root_path/ygopro-ocg/ygopro" ]; then
    tar -zxvf "$ygopro_path" -C "$root_path/ygopro-ocg/"
    #reset ext
    cp -r "$root_path/install/ocg-ext"/* "$root_path/ygopro-ocg/"
    #reset deck
    reset_deck "$root_path/ygopro-ocg"
fi
#check ygopro 408
if [ ! -e "$root_path/ygopro-408/ygopro" ]; then
    tar -zxvf "$ygopro_path" -C "$root_path/ygopro-408/"
    #reset ext
    cp -r "$root_path/install/408-ext"/* "$root_path/ygopro-408/"
    #reset deck
    reset_deck "$root_path/ygopro-408"
fi
#check ygopro 2011_11_11
if [ ! -e "$root_path/ygopro-2011_11_11/ygopro" ]; then
    tar -zxvf "$ygopro_path" -C "$root_path/ygopro-2011_11_11/"
    #reset ext
    cp -r "$root_path/install/2011_11_11-ext"/* "$root_path/ygopro-2011_11_11/"
    #reset deck
    reset_deck "$root_path/ygopro-2011_11_11"
fi
#update super pre
"$root_path/update-super-pre.sh"
