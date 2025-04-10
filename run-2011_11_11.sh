#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
source "$root_path/lib_deck.sh"

run_2011_11_11(){
    local ygopro_2011_11_11_path="$root_path/ygopro-2011_11_11"
    #update ygopro
    "$root_path/update-ygopro.sh"
    #check ygopro-2011_11_11/deck
    pull_deck "$ygopro_2011_11_11_path"
    #run ygopro-2011_11_11
    cd "$ygopro_2011_11_11_path"
    ./ygopro
    #push deck
    push_deck "$ygopro_2011_11_11_path" "2011_11_11"
}
run_2011_11_11
