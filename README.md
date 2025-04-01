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
2025/04/01  
(使用`mycard`卸载`mycard ygopro`后重新安装的)`mycard ygopro`运行错误:  
```bash
./ygopro: error while loading shared libraries: libIrrKlang.so: cannot open shared object file: No such file or directory
```
2025/04/01
使用`mycard`卸载`mycard ygopro`后重新安装`mycard ygopro`时,下载报错:  
```bash
request to http://127.0.0.1:6860/jsonrpc failed,reason:connect ECONNREFUSED 127.0.0.1:6860
```
