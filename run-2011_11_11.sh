#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
#update ygopro
"$root_path/update-ygopro.sh"
#check ygopro-2011_11_11/deck
ygopro_2011_11_11_path="$root_path/ygopro-2011_11_11"
deck_path="$ygopro_2011_11_11_path/deck"
if [[ ! -e "$deck_path/.git" ]]; then
    rm -rf "$deck_path"
    cd "$ygopro_2011_11_11_path"
    git clone "git@github.com:fgwsz/ygopro-deck.git"
    mv "$ygopro_2011_11_11_path/ygopro-deck" "$ygopro_2011_11_11_path/deck"
else
    cd "$deck_path"
    git pull
    "$deck_path/pull-deck.sh"
fi
#run ygopro-2011_11_11
cd "$ygopro_2011_11_11_path"
./ygopro
#push deck
if find "$deck_path" -maxdepth 1 -type f -name "*.ydk" | grep -q .; then
    mv -f "$deck_path"/*.ydk "$deck_path/2011_11_11/"
fi
"$deck_path/push-deck.sh"
