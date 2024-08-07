#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
#check install/mycard-main
mycard_main_path="$root_path/install/mycard-main"
if [[ ! -e "$mycard_main_path" ]]; then
    cd "$root_path/install"
    git clone "git@github.com:fgwsz/mycard-main.git"
    "$mycard_main_path/install.sh"
    "$mycard_main_path/build.sh"
fi
#check mycard ygopro
mcpro_path=~/.config/MyCardLibrary/ygopro
if [ ! -e "$mcpro_path" ]; then
    "$mycard_main_path/run.sh"
    exit 1
fi
#check mycard ygopro/deck
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
#run mycard
"$mycard_main_path/run.sh"
#mv deck to deck/ocg/
mv "$deck_path"/*.ydk "$deck_path/ocg/"
#push deck
"$deck_path/push-deck.sh"
