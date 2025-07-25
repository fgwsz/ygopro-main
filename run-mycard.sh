#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
source "$root_path/lib_deck.sh"
source "$root_path/lib_mdpro3_deck.sh"

run_mycard(){
    #check install/mycard-main
    local mycard_main_path="$root_path/install/mycard-main"
    if [[ ! -e "$mycard_main_path" ]]; then
        cd "$root_path/install"
        git clone "git@github.com:fgwsz/mycard-main.git"
        "$mycard_main_path/install.sh"
        "$mycard_main_path/build.sh"
    fi

    local mcpro_dir_path=~/.config/MyCardLibrary/ygopro
    local mcpro_path="$mcpro_dir_path/ygopro"
    local mdpro3_dir_path=~/.config/MyCardLibrary/mdpro3
    local mdpro3_path="$mdpro3_dir_path/MDPro3"

    # update super pre
    "$root_path/update-super-pre.sh"
    #pull mycard mcpro deck
    if [ -e "$mcpro_path" ]; then
        pull_deck "$mcpro_dir_path"
    fi
    #pull mycard mdpro3 deck
    if [ -e "$mdpro3_path" ]; then
        pull_mdpro3_deck "$mdpro3_dir_path"
    fi
    #run mycard
    "$mycard_main_path/run.sh"
    #push mycard mcpro deck
    if [ -e "$mcpro_path" ]; then
        push_deck "$mcpro_dir_path" "ocg"
    fi
    #push mycard mdpro3 deck
    if [ -e "$mdpro3_path" ]; then
        push_mdpro3_deck "$mdpro3_dir_path"
    fi
}
run_mycard
