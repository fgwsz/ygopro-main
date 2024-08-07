#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
#download ygopro-deck git repo
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
#push deck
"$deck_path/push-deck.sh"
