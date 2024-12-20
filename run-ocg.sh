#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
#update ygopro
"$root_path/update-ygopro.sh"
#check ygopro-ocg/deck
ygopro_ocg_path="$root_path/ygopro-ocg"
deck_path="$ygopro_ocg_path/deck"
if [[ ! -e "$deck_path/.git" ]]; then
    rm -rf "$deck_path"
    cd "$ygopro_ocg_path"
    git clone "git@github.com:fgwsz/ygopro-deck.git"
    mv "$ygopro_ocg_path/ygopro-deck" "$ygopro_ocg_path/deck"
else
    cd "$deck_path"
    git pull
    "$deck_path/pull-deck.sh"
fi
#run ygopro-ocg
cd "$ygopro_ocg_path"
./ygopro
#push deck
if find "$deck_path" -maxdepth 1 -type f -name "*.ydk" | grep -q .; then
    mv -f "$deck_path"/*.ydk "$deck_path/ocg/"
fi
"$deck_path/push-deck.sh"
