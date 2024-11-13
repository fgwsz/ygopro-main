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
#update super pre
"$root_path/update-super-pre.sh"
#check mycard ygopro/deck
deck_path="$mcpro_path/deck"
if [[ ! -e "$deck_path/.git" ]]; then
    cd "$mcpro_path"
    git clone "git@github.com:fgwsz/ygopro-deck.git"
    if find "$deck_path" -maxdepth 1 -type f -name "*.ydk" | grep -q .; then
        mv -f "$deck_path"/*.ydk "$mcpro_path/ygopro-deck/ocg/"
    fi
    "$mcpro_path/ygopro-deck/push-deck.sh"
    rm -rf "$deck_path"
    mv "$mcpro_path/ygopro-deck" "$mcpro_path/deck"
else
    cd "$deck_path"
    git pull
    "$deck_path/pull-deck.sh"
fi
#run mycard
"$mycard_main_path/run.sh"
#push deck
if find "$deck_path" -maxdepth 1 -type f -name "*.ydk" | grep -q .; then
    mv -f "$deck_path"/*.ydk "$deck_path/ocg/"
fi
"$deck_path/push-deck.sh"
