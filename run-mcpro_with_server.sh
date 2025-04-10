#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
source "$root_path/lib_deck.sh"
source "$root_path/lib_ygopro_launch_with_server.sh"

run_mcpro_with_server(){
    local mcpro_path=~/.config/MyCardLibrary/ygopro
    #check mycard ygopro
    if [ ! -e "$mcpro_path" ]; then
        echo "Please install mycard ygopro!"
        exit 1
    fi
    #reset mycard ygopro/ext
    cp -r "$root_path/install/mcpro-ext"/* "$mcpro_path/"
    #update super pre
    "$root_path/update-super-pre.sh"
    #check mycard ygopro/deck
    pull_deck "$mcpro_path"
    #run mycard ygopro
    ygopro_launch_with_server "$mcpro_path"
    #push deck
    push_deck "$mcpro_path" "ocg"
}
run_mcpro_with_server
