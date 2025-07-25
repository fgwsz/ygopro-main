#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
source "$root_path/lib_deck.sh"

run_mcpro(){
    local mcpro_dir_path=~/.config/MyCardLibrary/ygopro
    local mcpro_path="$mcpro_dir_path/ygopro"
    #check mycard ygopro
    if [ ! -e "$mcpro_path" ]; then
        echo "Please install mycard ygopro!"
        exit 1
    fi
    #reset mycard ygopro/ext
    cp -rf "$root_path/install/mcpro-ext"/* "$mcpro_dir_path/"
    #update super pre
    "$root_path/update-super-pre.sh"
    #check mycard ygopro/deck
    pull_deck "$mcpro_dir_path"
    #run mycard ygopro
    cd "$mcpro_dir_path"
    ./ygopro
    #push deck
    push_deck "$mcpro_dir_path" "ocg"
}
run_mcpro
