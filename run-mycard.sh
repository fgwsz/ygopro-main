#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
source "$root_path/lib_deck.sh"
source "$root_path/lib_download.sh"

run_mycard(){
    #check install/mycard
    local mycard_download_url="https://cdntx.moecube.com/downloads/MyCard-3.0.85.AppImage"
    local mycard_path="$root_path/install/mycard.AppImage"
    check_update "$mycard_download_url" "$mycard_path" "mycard" "install/mycard"
    if [ $? -eq 1 ]; then
        download_big_file "$mycard_download_url" "$mycard_path"
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
    chmod +x "$mycard_path"
    "$mycard_path"
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
