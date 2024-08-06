#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
deck_root_path="$root_path/install/"
deck_repo_name="ygopro-deck"
deck_path="${deck_root_path}${deck_repo_name}"

if [[ ! -e "$deck_path" ]]; then
    cd "$deck_root_path"
    git clone "git@github.com:fgwsz/${deck_repo_name}.git"
fi
cd  "$deck_path"
git pull
cd "$root_path"
rm -rf "$root_path/ygopro-ocg/deck"
rm -rf "$root_path/ygopro-408/deck"
cp -r "${deck_path}" "$root_path/ygopro-ocg/deck"
cp -r "${deck_path}" "$root_path/ygopro-408/deck"
