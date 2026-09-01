#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
source "$root_path/lib_deck.sh"

run_706(){
    local ygopro_706_path="$root_path/ygopro-706"
    #update ygopro
    "$root_path/update-ygopro.sh"
    #check ygopro-706/deck
    pull_deck "$ygopro_706_path"
    #run ygopro-706
    cd "$ygopro_706_path"
    ./ygopro
    #push deck
    push_deck "$ygopro_706_path" "706"
}
run_706
