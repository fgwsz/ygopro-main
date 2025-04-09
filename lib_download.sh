#!/bin/bash

# return 1 has update
# return 0 has not update
check_update(){
    local remote_url="$1"
    local local_path="$2"
    local remote_filename="$3"
    local local_filename="$4"
    local remote_size=""
    remote_size=$(curl -sI "$remote_url" | grep -i Content-Length | awk '{print $2}' | tr -d '\r')
    while true; do
        if [ -z "$remote_size" ]; then
            echo "Unable to retrieve the size of the $remote_filename."
            return 1
        fi
        remote_size=${remote_size% }
        if [ -f "$local_path" ]; then
            local_size=$(stat -c%s "$local_path")
        else
            echo "$local_filename does not exist."
            return 1
        fi
        if [ "$remote_size" -eq "$local_size" ]; then
            echo "$local_filename is up to date."
            return 0
        else
            echo "$local_filename has updates available."
            return 1
        fi
    done
}
download(){
    local remote_url="$1"
    local local_path="$2"
    while true; do
        if [[ -e "$local_path" ]]; then
            rm -rf "$local_path"
        fi
        axel -o "$local_path" "$remote_url"
        if [ $? -eq 0 ]; then
            break
        fi
    done
}
download_big_file(){
    local remote_url="$1"
    local local_path="$2"
    while true; do
        if [[ -e "$local_path" ]]; then
            rm -rf "$local_path"
        fi
        axel -n 20 -o "$local_path" "$remote_url"
        if [ $? -eq 0 ]; then
            break
        fi
    done
}
