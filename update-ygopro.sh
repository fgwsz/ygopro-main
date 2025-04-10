#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
source "$root_path/lib_download.sh"
source "$root_path/lib_deck.sh"

reset_ygopro(){
    local name="$1"
    local ygopro_path="$root_path/install/ygopro.tar.gz"
    tar -zxvf "$ygopro_path" -C "$root_path/ygopro-$name/"
    #reset ext
    cp -r "$root_path/install/$name-ext"/* "$root_path/ygopro-$name/"
    #reset deck
    copy_install_deck "$root_path/ygopro-$name"
}
check_and_reset_ygopro(){
    local name="$1"
    if [ ! -e "$root_path/ygopro-$name/ygopro" ]; then
        reset_ygopro "$name"
    fi
}
update_ygopro(){
    local ygopro_download_url="https://cdn02.moecube.com:444/koishipro/archive/KoishiPro-master-linux-zh-CN.tar.gz"
    local ygopro_path="$root_path/install/ygopro.tar.gz"
    check_update "$ygopro_download_url" "$ygopro_path" "ygopro" "install/ygopro"
    if [ $? -eq 1 ]; then
        download_big_file "$ygopro_download_url" "$ygopro_path"
        pull_install_deck
        reset_ygopro "ocg"
        reset_ygopro "408"
        reset_ygopro "2011_11_11"
    else
        check_and_reset_ygopro "ocg"
        check_and_reset_ygopro "408"
        check_and_reset_ygopro "2011_11_11"
    fi
}
update_ygopro
