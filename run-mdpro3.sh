#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")

run_mdpro3(){
    local mdpro3_dir_path=~/.config/MyCardLibrary/mdpro3
    local mdpro3_path="$mdpro3_dir_path/MDPro3"
    #check mycard mdpro3
    if [ ! -e "$mdpro3_path" ]; then
        echo "Please install mycard mdpro3!"
        exit 1
    fi
    #reset mycard mdpro3/ext
    cp -rf "$root_path/install/mdpro3-ext"/* "$mdpro3_dir_path/"
    #update super pre
    "$root_path/update-super-pre.sh"
    #run mycard mdpro3
    cd "$mdpro3_dir_path"
    ./MDPro3
}
run_mdpro3
