#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
source "$root_path/lib_deck.sh"
source "$root_path/lib_ygopro_launch_with_server.sh"

run_706_with_server(){
    local ygopro_706_path="$root_path/ygopro-706"
    #update ygopro
    "$root_path/update-ygopro.sh"
    #check ygopro-706/deck
    pull_deck "$ygopro_706_path"
    #run ygopro-706
    ygopro_launch_with_server "$ygopro_706_path"
    #push deck
    push_deck "$ygopro_706_path" "706"
}
run_706_with_server
