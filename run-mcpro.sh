#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
mcpro_path=~/.config/MyCardLibrary/ygopro
#check mycard ygopro
if [ ! -e "$mcpro_path" ]; then
    echo "Please install mycard ygopro!"
    exit 1
fi
#reset mycard ygopro/ext
cp -r "$root_path/install/mcpro-ext"/* "$mcpro_path/"
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
    git fetch origin
    git reset --hard origin/main
fi
#run mycard ygopro
cd "$mcpro_path"
./ygopro
#update deck
if find "$deck_path" -maxdepth 1 -type f -name "*.ydk" | grep -q .; then
    mv -f "$deck_path"/*.ydk "$deck_path/ocg/"
fi
"$deck_path/update-deck.sh"
