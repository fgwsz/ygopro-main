#!/bin/bash

# return 1 has update
# return 0 has not update
# return -1 network error
check_update(){
    local remote_url="$1"
    local local_path="$2"
    local remote_filename="$3"
    local local_filename="$4"
    local max_retries=3
    local retry_count=0
    # 网络重试机制
    while [ $retry_count -lt $max_retries ]; do
        remote_size=$(curl -sIL "$remote_url" | grep -i "Content-Length" | tail -1 | awk '{print $2}' | tr -d '\r')
        #echo "remote_size:$remote_size"
        if [ $? -eq 0 ]; then
            break
        else
            echo "Retry Count:($((retry_count+1))/$max_retries)..."
            ((retry_count++))
            sleep 5
        fi
    done
    # 网络错误最终判断
    if [ $retry_count -eq $max_retries ]; then
        echo "Network Error:Unable to retrieve the size of the $remote_filename."
        return -1
    fi
    # 文件存在性检查
    if [ ! -f "$local_path" ]; then
        echo "$local_filename does not exist."
        return 1
    fi
    # 大小比对
    local_size=$(stat -c%s "$local_path")
    if [ "$remote_size" -eq "$local_size" ]; then
        echo "$local_filename is up to date."
        return 0
    else
        echo "$local_filename has updates available."
        return 1
    fi
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
