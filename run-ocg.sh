#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
#check ygopro ocg
if [[ ! -e "$root_path/ygopro-ocg/ygopro" ]]; then
    ygopro_download_url="https://cdn02.moecube.com:444/koishipro/archive/KoishiPro-master-linux-zh-CN.tar.gz"
    ygopro_path="$root_path/install/ygopro.tar.gz"
    #check install/ygopro
    if [[ ! -e "$ygopro_path" ]]; then
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
    rm -rf "$root_path/ygopro-ocg/deck"
    cp -r "$ygopro_deck_path" "$root_path/ygopro-ocg/deck"
    #reser super pre
    "$root_path/update-super-pre.sh"
fi
#check ygopro-ocg/deck
ygopro_ocg_path="$root_path/ygopro-ocg"
deck_path="$ygopro_ocg_path/deck"
if [[ ! -e "$deck_path/.git" ]]; then
    rm -rf "$deck_path"
    cd "$ygopro_ocg_path"
    git clone "git@github.com:fgwsz/ygopro-deck.git"
    mv "$ygopro_ocg_path/ygopro-deck" "$ygopro_ocg_path/deck"
fi
#pull deck
cd "$deck_path"
git pull
#run ygopro
cd "$ygopro_ocg_path"
./ygopro
#mv deck to deck/ocg/
mv "$ygopro_ocg_path/deck"/*.ydk "$ygopro_ocg_path/deck/ocg/"
#push deck
"$deck_path/push-deck.sh"
