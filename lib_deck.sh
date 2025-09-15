#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
pull_deck(){
    local ygopro_dir_path="$1"
    local deck_path="$ygopro_dir_path/deck"
    if [[ ! -e "$deck_path/.git" ]]; then
        rm -rf "$deck_path"
        cd "$ygopro_dir_path"
        git clone "git@github.com:fgwsz/ygopro-deck.git"
        mv "$ygopro_dir_path/ygopro-deck" "$ygopro_dir_path/deck"
    else
        cd "$deck_path"
        git pull
        "$deck_path/pull-deck.sh"
    fi
}
pull_mdpro3_deck(){
    local mdpro3_dir_path="$1"
    local deck_path="$mdpro3_dir_path/ygopro-deck"
    if [[ ! -e "$deck_path" ]]; then
        cd "$mdpro3_dir_path"
        git clone "git@github.com:fgwsz/ygopro-deck.git"
    else
        cd "$deck_path"
        git pull
        "$deck_path/pull-deck.sh"
    fi
    rsync -avzh --delete "$deck_path/mdpro3/" "$mdpro3_dir_path/Deck/"
}
push_deck(){
    local ygopro_dir_path="$1"
    local deck_category="$2"
    local deck_path="$ygopro_dir_path/deck"
    if find "$deck_path" -maxdepth 1 -type f -name "*.ydk" | grep -q .; then
        mv -f "$deck_path"/*.ydk "$deck_path/$deck_category/"
    fi
    "$deck_path/push-deck.sh"
}
push_mdpro3_deck(){
    local mdpro3_dir_path="$1"
    local deck_path="$mdpro3_dir_path/ygopro-deck"
    rsync -avzh --delete "$mdpro3_dir_path/Deck/" "$deck_path/mdpro3/"
    "$deck_path/push-deck.sh"
}
pull_install_deck(){
    local install_deck_path="$root_path/install/ygopro-deck"
    if [[ ! -e "$install_deck_path" ]]; then
        cd "$root_path/install"
        git clone "git@github.com:fgwsz/ygopro-deck.git"
    else
        cd "$install_deck_path"
        git pull
        "$install_deck_path/pull-deck.sh"
    fi
}
copy_install_deck(){
    local ygopro_dir_path="$1"
    local install_deck_path="$root_path/install/ygopro-deck"
    rm -rf "$ygopro_dir_path/deck"
    cp -rf "$install_deck_path" "$ygopro_dir_path/deck"
}
reset_deck(){
    local ygopro_dir_path="$1"
    local install_deck_path="$root_path/install/ygopro-deck"
    pull_install_deck
    copy_install_deck "$ygopro_dir_path"
}
