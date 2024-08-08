#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
mcpro_path=~/.config/MyCardLibrary/ygopro
#check mycard ygopro
if [ ! -e "$mcpro_path" ]; then
    echo "Please install mycard ygopro!"
    exit 1
fi
cp -r "$root_path/install/mcpro-ext"/* "$mcpro_path/"
