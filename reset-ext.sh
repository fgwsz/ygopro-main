#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
cp -r "$root_path/install/ocg-ext"/* "$root_path/ygopro-ocg/"
cp -r "$root_path/install/408-ext"/* "$root_path/ygopro-408/"
