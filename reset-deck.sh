#!/bin/bash

deck_root_path="./install/"
deck_repo_name="ygopro-deck"
deck_path="${deck_root_path}${deck_repo_name}"

if [[ ! -e "$deck_path" ]]; then
    cd "$deck_root_path"
    git clone "git@github.com:fgwsz/$deck_repo_name"
    cd ..
fi
cd  "$deck_path"
git pull
cd ../..
rm -rf ./ygopro-ocg/deck/*
rm -rf ./ygopro-408/deck/*
cp -r "${deck_path}" ./ygopro-ocg/deck/
cp -r "${deck_path}" ./ygopro-408/deck/
