#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
source "$root_path/lib_deck.sh"

run_ocg(){
    local ygopro_ocg_path="$root_path/ygopro-ocg"
    #update ygopro
    "$root_path/update-ygopro.sh"
    #update ygopro-super-pre
    "$root_path/update-super-pre.sh"
    #check ygopro-ocg/deck
    pull_deck "$ygopro_ocg_path"
    #run ygopro-ocg
    cd "$ygopro_ocg_path"
    ./ygopro
    #push deck
    push_deck "$ygopro_ocg_path" "ocg"
}
run_ocg
