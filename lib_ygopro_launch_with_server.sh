#!/bin/bash

user=""
password=""
host=""
port=""
room=""
root_path=$(dirname "$(readlink -f "$0")")
read_account(){
    local account_file="$root_path/account.csv"
    if [[ ! -f "$account_file" ]]; then
        echo "错误:未找到配置文件 $account_file" >&2
        exit 1
    fi
    {
        read -r _  # 跳过标题行
        IFS=, read -r user password  # 只读取第一行账号
        user=$(xargs <<< "$user")
        password=$(xargs <<< "$password")
    } < "$account_file"
    echo "User: $user"
    echo "Password: $password"
}
select_server(){
    local servers_file="$root_path/duel_servers.csv"
    if [[ ! -f "$servers_file" ]]; then
        echo "错误:未找到配置文件 $servers_file" >&2
        exit 1
    fi
    declare -a servers
    declare -a menu_options
    {
        read -r _  # 跳过标题行
        while IFS=, read -r name host port; do
            # 在读取字段后添加空值检查
            if [[ -z "$host" || -z "$port" ]]; then
                echo "错误:服务器配置不完整" >&2
                exit 2
            fi
            # 去除字段可能的空格
            name=$(echo "$name" | xargs)
            host=$(echo "$host" | xargs)
            port=$(echo "$port" | xargs)
            # 构建完整菜单项
            #menu_item=$(printf "\033[32m%-30s\033[0m | Host: \033[32m%-23s\033[0m | Port: \033[32m%-5s\033[0m" \
            menu_item=$(printf "\033[32m%-30s\033[0m | \033[32m%-33s\033[0m | \033[32m%-6s\033[0m" \
                "$name" "$host" "$port")
            # 存储配置
            servers+=("$host $port")
            menu_options+=("$menu_item")
        done
    } < "$servers_file"
    # show menu
    echo "───────────────────────────────────────────────────────────────────────────────"
    echo " Name                              | Host                              | Port  "
    echo "───────────────────────────────────────────────────────────────────────────────"
    for ((i=0; i<${#menu_options[@]}; i++)); do
        printf "%2d) %-76s\n" $((i+1)) "${menu_options[i]}"
        if ((i < ${#menu_options[@]}-1)); then
            echo "───────────────────────────────────────────────────────────────────────────────"
        fi
    done
    echo "───────────────────────────────────────────────────────────────────────────────"
    local index=""
    echo "请选择要连接的服务器"
    while true; do
        read -p "请输入选择数字 (1-${#menu_options[@]},回车自动选择第一个):" choice
        # 处理回车自动选择
        [[ -z "$choice" ]] && choice=1
        # 验证输入有效性
        if [[ ! "$choice" =~ ^[0-9]+$ ]] || ((choice < 1 || choice > ${#menu_options[@]})); then
            echo "无效的选项,请重新选择"
            continue
        fi
        # 获取选中配置的索引
        index=$((choice - 1))
        break
    done
    # 解析配置参数
    IFS=' ' read -r host port<<< "${servers[index]}"
}
test_server(){
    echo "正在连接到服务器 $host:$port"
    if ! nc -z -w2 "$host" "$port"; then
        echo "错误:无法连接到 $host:$port"
        exit 1
    fi
    echo "服务器 $host:$port 连接测试正常"
}
select_room(){
    local room_history_file="$root_path/room_history.csv"
    local max_history=10
    # 检查历史文件是否存在且有内容
    if [[ -f "$room_history_file" && -s "$room_history_file" ]]; then
        # 读取最后10条历史记录(不含标题)
        mapfile -t rooms < <(tail -n "$max_history" "$room_history_file" | awk 'NF>0')
        if [[ ${#rooms[@]} -gt 0 ]]; then
            echo "最近使用的房间:"
            for i in "${!rooms[@]}"; do
                printf "%2d) %s\n" $((i+1)) "${rooms[i]}"
            done
            echo " 0) 手动输入房间"
            while true; do
                read -p "请选择(0-${#rooms[@]})[直接回车跳过]: " choice
                # 处理空输入
                [[ -z "$choice" ]] && return 0
                if [[ "$choice" =~ ^[0-9]+$ ]]; then
                    if (( choice == 0 )); then
                        break
                    elif (( choice > 0 && choice <= ${#rooms[@]} )); then
                        room="${rooms[choice-1]}"
                        echo "已选择历史房间: $room"
                        return 0
                    fi
                fi
                echo "无效选择,请重新输入"
            done
        fi
    fi
    # 手动输入处理
    while true; do
        read -p "输入房间名称(留空跳过): " room
        [[ -z "$room" ]] && return 0
        # 检查是否纯空格
        if [[ "$room" =~ ^[[:space:]]+$ ]]; then
            echo "房间名不能全是空格"
            continue
        fi
        # 保存到历史记录
        if [[ -n "$room" ]]; then
            # 去重处理
            temp_file=$(mktemp)
            [[ -f "$room_history_file" ]] && awk '!/^$/' "$room_history_file" > "$temp_file"
            echo "$room" >> "$temp_file"
            # 去重并保留最新10条
            awk '!seen[$0]++' "$temp_file" | tail -n "$max_history" > "$room_history_file"
            rm "$temp_file"
        fi
        return 0
    done
}
set_room(){
    local ygopro_path="$1"
    local conf_files=("$ygopro_path/system.conf" "$ygopro_path/system_user.conf")
    # 遍历所有配置文件
    for conf in "${conf_files[@]}"; do
        # 检查文件存在性
        if [[ ! -f "$conf" ]]; then
            echo "警告：配置文件 $conf 不存在，已跳过" >&2
            continue
        fi
        # 创建带时间戳的备份
        backup_file="${conf}.bak.$(date +%s)"
        cp "$conf" "$backup_file" 2>/dev/null || {
            echo "错误：无法备份 $conf" >&2
            exit 1
        }
        # 执行配置修改
        sed -i -E "
            /^[[:space:]]*roompass[[:space:]]*=/ {
                s|=.*|= ${room}|;
                h;
                d;
            }
            /^[[:space:]]*#[[:space:]]*roompass[[:space:]]*=/ {
                s/#//;
                s/=.*/= ${room}/;
                h;
                d;
            }
            /^lasthost[[:space:]]*=/ {
                a\\
roompass = ${room}
            }
            \$a\\
roompass = ${room}
        " "$conf"
        # 验证修改结果
        if ! grep -q "^roompass[[:space:]]*=[[:space:]]*${room}$" "$conf"; then
            echo "错误：$conf 修改失败，已恢复" >&2
            mv "$backup_file" "$conf"
            exit 1
        else
            # 保留最新备份用于恢复
            mv "$backup_file" "${conf}.bak"
            echo "已配置: $conf"
        fi
    done
}
reset_room(){
    local ygopro_path="$1"
    local conf_files=("$ygopro_path/system.conf" "$ygopro_path/system_user.conf")
    for conf in "${conf_files[@]}"; do
        if [[ -f "${conf}.bak" ]]; then
            mv "${conf}.bak" "$conf" && \
            echo "已恢复: $conf"
        fi
    done
}
ygopro_launch(){
    local ygopro_path="$1"
    DELIMITER="$"
    user_credential="${user}${DELIMITER}${password}"
    cd "$ygopro_path"
    ./ygopro -h "$host" -p "$port" -n "$user_credential"
}
ygopro_launch_with_server(){
    local ygopro_path="$1"
    read_account
    select_server
    test_server
    select_room
    set_room "$ygopro_path"
    ygopro_launch "$ygopro_path"
    reset_room "$ygopro_path"
}
