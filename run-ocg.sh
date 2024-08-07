#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
#download ygopro-deck git repo
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
#push deck
"$deck_path/push-deck.sh"
