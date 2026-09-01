#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
source "$root_path/lib_deck.sh"
source "$root_path/lib_ygopro_launch_with_server.sh"

run_2011_11_11_with_server(){
    local ygopro_2011_11_11_path="$root_path/ygopro-2011_11_11"
    #update ygopro
    "$root_path/update-ygopro.sh"
    #check ygopro-2011_11_11/deck
    pull_deck "$ygopro_2011_11_11_path"
    #run ygopro-2011_11_11
    ygopro_launch_with_server "$ygopro_2011_11_11_path"
    #push deck
    push_deck "$ygopro_2011_11_11_path" "2011_11_11"
}
run_2011_11_11_with_server
