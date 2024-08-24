# ygopro-main
YGOPro & MyCard manager in linux system.  
## `install.sh`
安装必要的第三方软件  
## `run-ocg.sh`
运行`ygopro-ocg/ygopro`  
+ 自动安装/更新`ygopro`  
+ 自动安装`ocg-ext`保持配置信息  
+ 自动同步`deck/`文件内容到远程仓库  
    - `deck`远程仓库<https://github.com/fgwsz/ygopro-deck>  
+ 自动安装/更新`ygopro-super-pre.ypk`萌卡超先行补丁  
## `run-408.sh`
运行`ygopro-408/ygopro`  
+ 自动安装/更新`ygopro`  
+ 自动安装`408-ext`保持配置信息  
+ 自动同步`deck/`文件内容到远程仓库  
    - `deck`远程仓库<https://github.com/fgwsz/ygopro-deck>  
## `run-mycard.sh`
运行`mycard`
+ 自动校检`mycard`完整性(若未安装则自动下载安装)  
    - `mycard`远程仓库<https://github.com/fgwsz/mycard-main>  
+ 若已使用`mycard`客户端安装了`mycard ygopro`  
    - 自动同步`deck/`文件内容到远程仓库  
        + `deck`远程仓库<https://github.com/fgwsz/ygopro-deck>  
    - 自动安装/更新`ygopro-super-pre.ypk`萌卡超先行补丁  
## `run-mcpro.sh`
运行`mycard ygopro`
+ 自动安装`mcpro-ext`保持配置信息  
+ 自动同步`deck/`文件内容到远程仓库  
    - `deck`远程仓库<https://github.com/fgwsz/ygopro-deck>  
+ 自动安装/更新`ygopro-super-pre.ypk`萌卡超先行补丁  
## `update-super-pre.sh`
安装/更新`ygopro-super-pre.ypk`萌卡超先行补丁  
+ 自动安装/更新到`ygopro-ocg/ygopro`
+ 自动安装/更新到`mycard ygopro`
## `update-ygopro.sh`
### 安装/更新`ygopro`
+ 自动安装/更新到`ygopro-ocg/ygopro`  
+ 自动安装/更新到`ygopro-408/ygopro`  
### 安装/更新`ygopro-super-pre.ypk`萌卡超先行补丁
+ 自动安装/更新到`ygopro-ocg/ygopro`  
+ 自动安装/更新到`mycard ygopro`  
