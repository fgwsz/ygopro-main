#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
mcpro_path=~/.config/MyCardLibrary/ygopro
#reset 408-ext
cp -r "$root_path/install/mcpro-ext"/* "$mcpro_path/"
