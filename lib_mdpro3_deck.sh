#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
pull_mdpro3_deck(){
    local mdpro3_dir_path="$1"
    local deck_repo_path="$mdpro3_dir_path/ygopro-deck"
    local deck_path="$mdpro3_dir_path/Deck"
    if [[ ! -e "$deck_repo_path" ]]; then
        cd "$mdpro3_dir_path"
        git clone "git@github.com:fgwsz/ygopro-deck.git"
    else
        cd "$deck_repo_path"
        git pull
        "$deck_repo_path/pull-deck.sh"
    fi
    rm -rf "$deck_path"/*
    cp -f "$deck_repo_path/ocg"/*.ydk "$deck_path/"
}
push_mdpro3_deck(){
    local mdpro3_dir_path="$1"
    local deck_repo_path="$mdpro3_dir_path/ygopro-deck"
    local deck_path="$mdpro3_dir_path/Deck"
    cp -f "$deck_path"/*.ydk "$deck_repo_path/ocg/"
    "$deck_repo_path/push-deck.sh"
}
