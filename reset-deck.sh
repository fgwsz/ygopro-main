#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
deck_path="$root_path/install/ygopro-deck"

if [[ ! -e "$deck_path" ]]; then
    cd "$deck_root_path"
    git clone "git@github.com:fgwsz/ygopro-deck.git"
fi
cd  "$deck_path"
git pull
rm -rf "$root_path/ygopro-ocg/deck"
rm -rf "$root_path/ygopro-408/deck"
cp -r "${deck_path}" "$root_path/ygopro-ocg/deck"
cp -r "${deck_path}" "$root_path/ygopro-408/deck"
