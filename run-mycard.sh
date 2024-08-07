#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
mycard_main_path="$root_path/install/mycard-main"
if [[ ! -e "$mycard_main_path" ]]; then
    cd "$root_path/install"
    git clone "git@github.com:fgwsz/mycard-main.git"
    "$mycard_main_path/install.sh"
    "$mycard_main_path/build.sh"
fi
ygopro_mc_path=~/.config/MyCardLibrary/ygopro
if [ ! -e "$ygopro_mc_path" ]; then
    "$mycard_main_path/run.sh"
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
#run mycard
"$mycard_main_path/run.sh"
#push deck
"$deck_path/push-deck.sh"
