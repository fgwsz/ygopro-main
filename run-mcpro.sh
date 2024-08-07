#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
mcpro_path=~/.config/MyCardLibrary/ygopro
#check mycard ygopro
if [ ! -e "$mcpro_path" ]; then
    echo "Please install mycard ygopro!"
    exit 1
fi
#download ygopro-deck git repo
deck_path="$mcpro_path/deck"
if [[ ! -e "$deck_path/.git" ]]; then
    rm -rf "$deck_path"
    cd "$mcpro_path"
    git clone "git@github.com:fgwsz/ygopro-deck.git"
    mv "$mcpro_path/ygopro-deck" "$mcpro_path/deck"
fi
#pull deck
cd "$deck_path"
git pull
#run ygopro
cd "$mcpro_path"
./ygopro
#push deck
"$deck_path/push-deck.sh"
