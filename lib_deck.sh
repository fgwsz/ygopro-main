#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
pull_deck(){
    local ygopro_path="$1"
    local deck_path="$ygopro_path/deck"
    if [[ ! -e "$deck_path/.git" ]]; then
        rm -rf "$deck_path"
        cd "$ygopro_path"
        git clone "git@github.com:fgwsz/ygopro-deck.git"
        mv "$ygopro_path/ygopro-deck" "$ygopro_path/deck"
    else
        cd "$deck_path"
        git pull
        "$deck_path/pull-deck.sh"
    fi
}
push_deck(){
    local ygopro_path="$1"
    local deck_category="$2"
    local deck_path="$ygopro_path/deck"
    if find "$deck_path" -maxdepth 1 -type f -name "*.ydk" | grep -q .; then
        mv -f "$deck_path"/*.ydk "$deck_path/$deck_category/"
    fi
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
    local ygopro_path="$1"
    local install_deck_path="$root_path/install/ygopro-deck"
    rm -rf "$ygopro_path/deck"
    cp -r "$install_deck_path" "$ygopro_path/deck"
}
reset_deck(){
    local ygopro_path="$1"
    local install_deck_path="$root_path/install/ygopro-deck"
    pull_install_deck
    copy_install_deck "$ygopro_path"
}
