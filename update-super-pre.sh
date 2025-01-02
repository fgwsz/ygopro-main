#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
super_pre_path="$root_path/install/ygopro-super-pre.ypk"
super_pre_download_url="https://cdn02.moecube.com:444/ygopro-super-pre/archive/ygopro-super-pre.ypk"
super_pre_remote_size=$(curl -sI "$super_pre_download_url" | grep -i Content-Length | awk '{print $2}' | tr -d '\r')
download_flag=false
#check remote supre pre size
if [ -z "$super_pre_remote_size" ]; then
    download_flag=true
    echo "Unable to retrieve the size of the remote super pre file."
fi
super_pre_remote_size=${super_pre_remote_size% }
if [ -f "$super_pre_path" ]; then
    super_pre_size=$(stat -c%s "$super_pre_path")
else
    download_flag=true
    echo "install/super pre file does not exist."
fi
if [ "$super_pre_remote_size" -eq "$super_pre_size" ]; then
    download_flag=false
    echo "install/super pre is up to date."
else
    download_flag=true
    echo "super pre has updates available."
fi
#update install/super pre
if [ $download_flag = true ]; then
    if [[ -e "$super_pre_path" ]]; then
        rm -rf "$super_pre_path"
    fi
    while true; do
        #Why --http1.1?
        #Fix:curl: (92) HTTP/2 stream 0 was not closed cleanly: INTERNAL_ERROR (err 2)
        curl -C - --http1.1 --retry 999 --retry-delay 2 -o "$super_pre_path" "$super_pre_download_url"
        if [ $? -eq 0 ]; then
            break
        fi
    done
fi
super_pre_size=$(stat -c%s "$super_pre_path")
#update ocg/super pre
ygopro_ocg_path="$root_path/ygopro-ocg"
if [ ! -e "$ygopro_ocg_path/expansions" ]; then
    mkdir "$ygopro_ocg_path/expansions"
fi
super_pre_ocg_path="$ygopro_ocg_path/expansions/ygopro-super-pre.ypk"
if [ -f "$super_pre_ocg_path" ]; then
    super_pre_ocg_size=$(stat -c%s "$super_pre_ocg_path")
    if [ "$super_pre_size" -eq "$super_pre_ocg_size" ]; then
        echo "ocg/super pre is up to date."
    else
        echo "Update ocg/super pre."
        cp "$super_pre_path" "$super_pre_ocg_path"
    fi
else
    echo "Update ocg/super pre."
    cp "$super_pre_path" "$super_pre_ocg_path"
fi
#update mcpro/super per
mcpro_path=~/.config/MyCardLibrary/ygopro
if [ ! -e "$mcpro_path" ]; then
    echo "Please install mycard ygopro!"
    exit 1
fi
if [ ! -e "$mcpro_path/expansions" ]; then
    mkdir "$mcpro_path/expansions"
fi
super_pre_mcpro_path="$mcpro_path/expansions/ygopro-super-pre.ypk"
if [ -f "$super_pre_mcpro_path" ]; then
    super_pre_mcpro_size=$(stat -c%s "$super_pre_mcpro_path")
    if [ "$super_pre_size" -eq "$super_pre_mcpro_size" ]; then
        echo "mcpro/super pre is up to date."
    else
        cp "$super_pre_path" "$super_pre_mcpro_path"
        echo "Update mcpro/super pre."
    fi
else
    cp "$super_pre_path" "$super_pre_mcpro_path"
    echo "Update mcpro/super pre."
fi
