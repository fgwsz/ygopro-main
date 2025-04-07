#!/bin/bash
root_path=$(dirname "$(readlink -f "$0")")
servers_file="$root_path/duel_servers.csv"
account_file="$root_path/account.csv"
room_history_file="$root_path/room_history.csv"
max_history=10
room=""
declare -a servers
declare -a menu_options
#update ygopro
"$root_path/update-ygopro.sh"
#check ygopro-ocg/deck
ygopro_ocg_path="$root_path/ygopro-ocg"
deck_path="$ygopro_ocg_path/deck"
if [[ ! -e "$deck_path/.git" ]]; then
    rm -rf "$deck_path"
    cd "$ygopro_ocg_path"
    git clone "git@github.com:fgwsz/ygopro-deck.git"
    mv "$ygopro_ocg_path/ygopro-deck" "$ygopro_ocg_path/deck"
else
    cd "$deck_path"
    git pull
    "$deck_path/pull-deck.sh"
fi
# check config file
if [[ ! -f "$servers_file" ]]; then
    echo "错误:未找到配置文件 $servers_file" >&2
    exit 1
fi
if [[ ! -f "$account_file" ]]; then
    echo "错误:未找到配置文件 $account_file" >&2
    exit 1
fi
if [[ ! -f "$room_history_file" ]]; then
    echo "错误:未找到配置文件 $room_history_file" >&2
    exit 1
fi
# read account info
{
    read -r _  # 跳过标题行
    IFS=, read -r user password  # 只读取第一行账号
    user=$(xargs <<< "$user")
    password=$(xargs <<< "$password")
} < "$account_file"
# read duel servers info
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
        menu_item=$(printf "\033[34m%-25s\033[0m | Host: \033[32m%-18s\033[0m | Port: %-4s" \
            "$name" "$host" "$port")
        # 存储配置
        servers+=("$host $port")
        menu_options+=("$menu_item")
    done
} < "$servers_file"
# show menu
echo "┌────────────────────────────────────────────────────────────────────────┐"
echo "│                       帐号 ($user)                                  │"
echo "│                       请选择要连接的服务器 (1-${#menu_options[@]})                     │"
echo "├──────────────────────────┬────────────────────────────┬───────────────┤"
for ((i=0; i<${#menu_options[@]}; i++)); do
    printf "│ %2d) %-69s │\n" $((i+1)) "${menu_options[i]}"
    if ((i < ${#menu_options[@]}-1)); then
        echo "├──────────────────────────┼─────────────────────────────┼───────────────┤"
    fi
done
echo "└──────────────────────────┴─────────────────────────────┴───────────────┘"
# select room info
select_room() {
    # 检查历史文件是否存在且有内容
    if [[ -f "$room_history_file" && -s "$room_history_file" ]]; then
        # 读取最后10条历史记录(不含标题)
        mapfile -t rooms < <(tail -n "$max_history" "$room_history_file" | awk 'NF>0')
        if [[ ${#rooms[@]} -gt 0 ]]; then
            echo -e "\n最近使用的房间:"
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
# run ygopro-ocg main loop
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
    # 解析配置参数
    IFS=' ' read -r host port user password <<< "${servers[index]}"
    # 执行带密码的命令
    echo -e "\n正在连接到:${menu_options[index]}"
    # 在执行命令前添加测试
    if ! nc -z -w2 "$host" "$port"; then
        echo "错误:无法连接到 $host:$port"
        exit 3
    fi
    # 房间选择主执行流程
    select_room
    # 拼接用户凭证参数
    DELIMITER="$"
    user_credential="${user}${DELIMITER}${password}"
    # 执行 ygopro 命令
    #conf_file="$ygopro_ocg_path/system_user.conf"
    #if grep -q "^roompass = " "$conf_file"; then
    #    sed -i.bak "s|^roompass = .*|roompass = $room|" "$conf_file"
    #else
    #    echo "roompass = $room" >> "$conf_file"
    #fi
    #cd "$ygopro_ocg_path"
    #./ygopro -h "$host" -p "$port" -n "$user_credential" -r "$room" 2>&1 | sed "s/$user_credential/*****/g"
    ./ygopro -h "$host" -p "$port" -n "$user_credential" 2>&1 | sed "s/$user_credential/*****/g"
    break
done
#push deck
if find "$deck_path" -maxdepth 1 -type f -name "*.ydk" | grep -q .; then
    mv -f "$deck_path"/*.ydk "$deck_path/ocg/"
fi
"$deck_path/push-deck.sh"
