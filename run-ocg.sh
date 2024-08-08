#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
#check ygopro-ocg
if [[ ! -e "$root_path/ygopro-ocg/ygopro" ]]; then
    ygopro_path="$root_path/install/ygopro.tar.gz"
    #check install/ygopro
    if [[ ! -e "$ygopro_path" ]]; then
        ygopro_download_url="https://cdn02.moecube.com:444/koishipro/archive/KoishiPro-master-linux-zh-CN.tar.gz"
        curl -C - -o "$ygopro_path" "$ygopro_download_url"
    fi
    #reset ygopro-ocg
    tar -zxvf "$ygopro_path" -C "$root_path/ygopro-ocg/"
    #reset ocg-ext
    cp -r "$root_path/install/ocg-ext"/* "$root_path/ygopro-ocg/"
    #check install/ygopro-deck
    ygopro_deck_path="$root_path/install/ygopro-deck"
    if [[ ! -e "$ygopro_deck_path" ]]; then
        cd "$root_path/install"
        git clone "git@github.com:fgwsz/ygopro-deck.git"
    else
        cd "$ygopro_deck_path"
        git pull
    fi
    #reset ygopro-ocg/deck
    mv -f "$root_path/ygopro-ocg/deck"/*.ydk "$ygopro_deck_path/ocg/"
    "$ygopro_deck_path/push-deck.sh"
    rm -rf "$root_path/ygopro-ocg/deck"
    cp -r "$ygopro_deck_path" "$root_path/ygopro-ocg/deck"
    #reser ygopro-ocg/super pre
    super_pre_path="$root_path/install/ygopro-super-pre.ypk"
    if [[ ! -e "$super_pre_path" ]]; then
        super_pre_download_url="https://cdn02.moecube.com:444/ygopro-super-pre/archive/ygopro-super-pre.ypk"
        curl -C - -o "$super_pre_path" "$super_pre_download_url"
    fi
    cp "$super_pre_path" "$ygopro_ocg_path/expansions/"
fi
#check ygopro-ocg/deck
ygopro_ocg_path="$root_path/ygopro-ocg"
deck_path="$ygopro_ocg_path/deck"
if [[ ! -e "$deck_path/.git" ]]; then
    cd "$ygopro_ocg_path"
    git clone "git@github.com:fgwsz/ygopro-deck.git"
    mv -f "$deck_path"/*.ydk "$ygopro_ocg_path/ygopro-deck/ocg/"
    "$ygopro_ocg_path/ygopro-deck/push-deck.sh"
    rm -rf "$deck_path"
    mv "$ygopro_ocg_path/ygopro-deck" "$ygopro_ocg_path/deck"
else
    cd "$deck_path"
    git pull
fi
#check ygopro-ocg/super pre
if [[ ! -e "$ygopro_ocg_path/expansions/ygopro-super-pre.ypk" ]]; then
    super_pre_path="$root_path/install/ygopro-super-pre.ypk"
    if [[ ! -e "$super_pre_path" ]]; then
        super_pre_download_url="https://cdn02.moecube.com:444/ygopro-super-pre/archive/ygopro-super-pre.ypk"
        curl -C - -o "$super_pre_path" "$super_pre_download_url"
    fi
    cp "$super_pre_path" "$ygopro_ocg_path/expansions/"
fi
#run ygopro-ocg
cd "$ygopro_ocg_path"
./ygopro
#push deck
mv -f "$deck_path"/*.ydk "$deck_path/ocg/"
"$deck_path/push-deck.sh"
