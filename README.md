# ygopro-main
YGOPro & MyCard manager in linux system.  
## `install.sh`
安装必要的第三方软件  
## `run-ocg.sh`
(OCG环境)  
+ 自动安装/更新`ygopro-ocg`  
+ 自动安装`ocg-ext`配置信息  
+ 自动同步`deck`远程仓库内容到`deck/`文件夹  
    - `deck`远程仓库<https://github.com/fgwsz/ygopro-deck>  
+ 自动安装/更新萌卡超先行卡补丁`ygopro-super-pre.ypk`  
+ 运行`ygopro-ocg/ygopro`  
## `run-ocg_with_server.sh`
(OCG环境)  
+ 自动安装/更新`ygopro-ocg`  
+ 自动安装`ocg-ext`配置信息  
+ 自动同步`deck`远程仓库内容到`deck/`文件夹  
    - `deck`远程仓库<https://github.com/fgwsz/ygopro-deck>  
+ 自动安装/更新萌卡超先行卡补丁`ygopro-super-pre.ypk`  
+ 运行`ygopro-ocg/ygopro`  
    - 可配置用户信息(用户信息存放在`account.csv`)  
    - 选择服务器信息(服务器信息存放在在`duel_servers.csv`)  
    - 对已选择服务器进行连接测试  
    - 选择最近10个(不重复的)历史房间信息(历史房间信息存放在`room_history.csv`)  
    - 支持控制台手动输入房间信息  
## `run-408.sh`
(408环境)  
+ 自动安装/更新`ygopro-408`  
+ 自动安装`408-ext`配置信息  
+ 自动同步`deck`远程仓库内容到`deck/`文件夹  
    - `deck`远程仓库<https://github.com/fgwsz/ygopro-deck>  
+ 运行`ygopro-408/ygopro`  
## `run-2011_11_11.sh`
(2011.11.11环境)  
+ 自动安装/更新`ygopro-2011_11_11`  
+ 自动安装`2011_11_11-ext`配置信息  
+ 自动同步`deck`远程仓库内容到`deck/`文件夹  
    - `deck`远程仓库<https://github.com/fgwsz/ygopro-deck>  
+ 运行`ygopro-2011_11_11/ygopro`  
## `run-mycard.sh`
(MyCard OCG环境)  
+ 自动校检`mycard`完整性(若未安装则自动下载安装)  
    - `mycard`远程仓库<https://github.com/fgwsz/mycard-main>  
+ 若已使用`mycard`客户端安装了`mycard ygopro`  
    - 自动同步`deck`远程仓库内容到`mycard ygopro/deck/`文件夹  
        + `deck`远程仓库<https://github.com/fgwsz/ygopro-deck>  
    - 自动安装/更新萌卡超先行卡补丁`ygopro-super-pre.ypk`到`mycard ygopro`  
+ 运行`mycard`  
## `run-mcpro.sh`
(MyCard OCG环境)  
+ 自动安装`mcpro-ext`配置信息  
+ 自动同步`deck`远程仓库内容到`deck/`文件夹  
    - `deck`远程仓库<https://github.com/fgwsz/ygopro-deck>  
+ 自动安装/更新萌卡超先行卡补丁`ygopro-super-pre.ypk`  
+ 运行`mycard ygopro`  
## `run-mcpro_with_server.sh`
(MyCard OCG环境)  
+ 自动安装`mcpro-ext`配置信息  
+ 自动同步`deck`远程仓库内容到`deck/`文件夹  
    - `deck`远程仓库<https://github.com/fgwsz/ygopro-deck>  
+ 自动安装/更新萌卡超先行卡补丁`ygopro-super-pre.ypk`  
+ 运行`mycard ygopro`  
    - 可配置用户信息(用户信息存放在`account.csv`)  
    - 选择服务器信息(服务器信息存放在在`duel_servers.csv`)  
    - 对已选择服务器进行连接测试  
    - 选择最近10个(不重复的)历史房间信息(历史房间信息存放在`room_history.csv`)  
    - 支持控制台手动输入房间信息  
## `update-super-pre.sh`
+ 自动安装/更新萌卡超先行卡补丁`ygopro-super-pre.ypk`到`ygopro-ocg/ygopro`  
+ 自动安装/更新萌卡超先行卡补丁`ygopro-super-pre.ypk`到`mycard ygopro`  
## `update-ygopro.sh`
### 安装/更新`ygopro`
+ 自动安装/更新`ygopro`到`ygopro-ocg`  
+ 自动安装/更新`ygopro`到`ygopro-408`  
+ 自动安装/更新`ygopro`到`ygopro-2011_11_11`  
### 安装配置信息
+ 自动安装`ocg-ext`配置信息到`ygopro-ocg`  
+ 自动安装`408-ext`配置信息到`ygopro-408`  
+ 自动安装`2011_11_11-ext`配置信息到`ygopro-2011_11_11`  
### 同步卡组信息
+ 自动同步`deck`远程仓库内容到`ygopro-ocg/deck/`文件夹  
+ 自动同步`deck`远程仓库内容到`ygopro-408/deck/`文件夹  
+ 自动同步`deck`远程仓库内容到`ygopro-2011_11_11/deck/`文件夹  
    - `deck`远程仓库<https://github.com/fgwsz/ygopro-deck>  
### 安装/更新萌卡超先行卡补丁
+ 自动安装/更新萌卡超先行卡补丁`ygopro-super-pre.ypk`到`ygopro-ocg/ygopro`  
+ 自动安装/更新萌卡超先行卡补丁`ygopro-super-pre.ypk`到`mycard ygopro`  
## 已知问题
### [o] 0001
2025/04/01  
(使用`mycard`卸载`mycard ygopro`后重新安装的)`mycard ygopro`运行错误:  
```bash
./ygopro: error while loading shared libraries: libIrrKlang.so: cannot open shared object file: No such file or directory
```
问题:  
缺少`libIrrKlang.so`动态库文件.  
解决方式:  
联系了`mycard`的开发者,得到讯息是在最近的一次更新打包的过程中,  
`linux`版本的`mycard ygopro`打包时遗漏了`libIrrKlang.so`.  
于是我尝试安装了`mycard`提供的其他版本的`ygopro`作为代替,  
在`mycard ygopro`介绍页下拉菜单项目里面找到`koishipro`点击安装即可.  
### [o] 0002
2025/04/01  
使用`mycard`卸载`mycard ygopro`后重新安装`mycard ygopro`时,下载报错:  
```bash
request to http://127.0.0.1:6860/jsonrpc failed,reason:connect ECONNREFUSED 127.0.0.1:6860
```
问题:  
下面来自`mycard v3.0.71`源码的搜索信息:  
```bash
app/download.service.ts
96:    // 强制指定IPv4,接到过一个反馈无法监听v6的.默认的host值是localhost,会连v6.
97:    aria2 = new Aria2({ host: '127.0.0.1', port: 6860, secret: 'mycard' });
```
解决方式:  
`aria2`是一个外部的磁力链接下载工具,  
首先来验证一下`aria2`是否能够正常运行.  
`aria2c`是`aria2`下载器的控制台命令,在运行时出现了如下问题:  
```bash
$ aria2c
Exception caughtException: [download_helper.cc:562] errorCode=1 Failed to open the file ~/.config/aria2/aria2.session, cause: File not found or it is a directory
```
显示`~/.config/aria2/aria2.session`文件缺失,  
我来验证一下这个文件是否是真实存在的.  
```bash
$ ls -ld ~/.config/aria2/aria2.session
-rw-rw-r-- 1 fgwsz fgwsz 0 Apr  2 21:43 /home/fgwsz/.config/aria2/aria2.session
```
这个文件是真实存在的,根本不可能缺失,那么问题出在了哪里呢?  
`aria2`启动时会加载一系列配置文件,  
这些配置文件通常在存放在`~/.config/aria2/`这个文件路径下.  
```bash
$ tree ~/.config/aria2/
/home/fgwsz/.config/aria2/
├── aria2.conf
├── aria2.log
└── aria2.session
0 directories, 3 files
```
`aria2.conf`是配置文件,  
`aria2.log`是日志文件,  
`aria2.session`是下载器进度保存文件,  
`aria2`启动的过程中会从这个文件夹读取下载参数和配置.  
当上述文件缺失/配置不正确的时候,`aria2`会无法启动,下载服务也就无法进行  
答案就是`~`这个用户目录文件夹的通配符,
`aria2`可能不认识,它无法将其转换成正确的用户目录文件全路径,  
在`~/.config/aria2/aria2.conf`这个配置文件中有一系列的文件路径配置选项,  
我们来查看一下:  
```bash
# 日志文件路径
log=~/.config/aria2/aria2.log
# 下载目录
dir=~/Downloads
# 输入文件路径(记录下载历史)
input-file=~/.config/aria2/aria2.session
# 输出文件路径(保存下载历史)
save-session=~/.config/aria2/aria2.session
```
果然是`~`丛生,我们尝试将这些文件路径里面的`~`全部替换为用户目录的全路径,  
然后重新运行`aria2c`  
```bash
$ aria2c --version
aria2 version 1.36.0
Copyright (C) 2006, 2019 Tatsuhiro Tsujikawa
```
这下运行正常了,重新打开`mycard`,找到`ygopro`介绍页,点击`下载`按键,  
此时发现可以正常下载了.  
### [o] 0003
2025/04/01  
使用`mycard`下载`mycard ygopro`时下载速度慢,下载到中间(未达到100%)报错:  
问题原因:  
用户自己安装的`aria2`和`aria2`配置和`mycard`自带的`aria2`不兼容,  
`mycard`自带的`aria2`使用了用户的`aria2`配置,  
而用户的`aria2`配置可能因为没有针对`ygopro`资源进行过优化,  
因为配置不一致的原因,  
造成下载慢,下载重试次数不一致,引发下载中断等问题,.  
解决方式:  
卸载用户自己安装的`aria2`,并删除`aria2`配置文件.  
```bash
sudo apt remove aria2
sudo rm -rf ~/.config/aria2
```
重新启动`mycard`,找到`ygopro`介绍页,点击下载,  
发现此时下载慢和下载中断的问题消失了.  
