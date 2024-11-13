#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
#update ygopro
"$root_path/update-ygopro.sh"
#check ygopro-408/deck
ygopro_408_path="$root_path/ygopro-408"
deck_path="$ygopro_408_path/deck"
if [[ ! -e "$deck_path/.git" ]]; then
    rm -rf "$deck_path"
    cd "$ygopro_408_path"
    git clone "git@github.com:fgwsz/ygopro-deck.git"
    mv "$ygopro_408_path/ygopro-deck" "$ygopro_408_path/deck"
else
    cd "$deck_path"
    git pull
    "$deck_path/pull-deck.sh"
fi
#run ygopro-408
cd "$ygopro_408_path"
./ygopro
#push deck
if find "$deck_path" -maxdepth 1 -type f -name "*.ydk" | grep -q .; then
    mv -f "$deck_path"/*.ydk "$deck_path/408/"
fi
"$deck_path/push-deck.sh"
