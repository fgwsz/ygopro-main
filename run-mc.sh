#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
ygopro_mc_path=~/.config/MyCardLibrary/ygopro
if [ ! -e "$ygopro_mc_path" ]; then
    echo "Please install mycard ygopro!"
    exit 1
fi
#download ygopro-deck git repo
deck_path="$ygopro_mc_path/deck"
if [[ ! -e "$deck_path/.git" ]]; then
    rm -rf "$deck_path"
    cd "$ygopro_mc_path"
    git clone "git@github.com:fgwsz/ygopro-deck.git"
    mv "$ygopro_mc_path/ygopro-deck" "$ygopro_mc_path/deck"
fi
#pull deck
cd "$deck_path"
git pull
#run ygopro
cd "$ygopro_mc_path"
./ygopro
#push deck
"$deck_path/push-deck.sh"
