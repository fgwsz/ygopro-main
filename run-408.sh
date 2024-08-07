#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
#check ygopro 408
if [[ ! -e "$root_path/ygopro-408/ygopro" ]]; then
    ygopro_download_url="https://cdn02.moecube.com:444/koishipro/archive/KoishiPro-master-linux-zh-CN.tar.gz"
    ygopro_path="$root_path/install/ygopro.tar.gz"
    #check install/ygopro
    if [[ ! -e "$ygopro_path" ]]; then
        curl -C - -o "$ygopro_path" "$ygopro_download_url"
    fi
    #reset ygopro-408
    tar -zxvf "$ygopro_path" -C "$root_path/ygopro-408/"
    #reset 408-ext
    cp -r "$root_path/install/408-ext"/* "$root_path/ygopro-408/"
    #check install/ygopro-deck
    ygopro_deck_path="$root_path/install/ygopro-deck"
    if [[ ! -e "$ygopro_deck_path" ]]; then
        cd "$root_path/install"
        git clone "git@github.com:fgwsz/ygopro-deck.git"
    else
        cd "$ygopro_deck_path"
        git pull
    fi
    #reset ygopro-408/deck
    rm -rf "$root_path/ygopro-408/deck"
    cp -r "$ygopro_deck_path" "$root_path/ygopro-408/deck"
fi
#check ygopro-408/deck
ygopro_408_path="$root_path/ygopro-408"
deck_path="$ygopro_408_path/deck"
if [[ ! -e "$deck_path/.git" ]]; then
    rm -rf "$deck_path"
    cd "$ygopro_408_path"
    git clone "git@github.com:fgwsz/ygopro-deck.git"
    mv "$ygopro_408_path/ygopro-deck" "$ygopro_408_path/deck"
fi
#pull deck
cd "$deck_path"
git pull
#run ygopro
cd "$ygopro_408_path"
./ygopro
#mv deck to deck/408/
mv "$ygopro_408_path/deck"/*.ydk "$ygopro_408_path/deck/408/"
#push deck
"$deck_path/push-deck.sh"
