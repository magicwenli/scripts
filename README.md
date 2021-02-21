# SCRIPTS

## 列表

| *    | NAME              | USE             | PLANTFORM      | LINK                                                         |
| :--- | :---------------- | --------------- | -------------- | ------------------------------------------------------------ |
| 1    | autoReconnect     | 拨号与重连      | Windows        | [CLICK](https://github.com/magicwenli/scripts/tree/master/autoReconnect) |
| 2    | qbBackup          | qbittorrent备份 | Windows        | [CLICK](https://github.com/magicwenli/scripts/tree/master/qbBackup) |
| 3    | ubuntu | ubuntu 18.04 init shell | linux | [CLICK](https://github.com/magicwenli/scripts/tree/master/ubuntu) |

## 说明

### 1. autoReconnect

  这是一个带有日志功能的自动拨号脚本，已经在 Windows 7 x86 下测试通过。

  默认情况下 **Ping** IPV6 网关。如需在 IPV4 下使用，去除 **Ping** 命令尾部的 -6 即可。

  伪代码如下：

<details>
  
1. Ping 网关地址，检测是否已拨号。
  
	1.1 Ping 失败，转到 3
  
	1.2 Ping 成功，转到 2
  
2. 延时等待 600 秒，转到 1
  
3. 断开全部连接，重新拨号并 Ping 网关检测连接状态
  
	3.1 Ping 失败，延时 100 秒，转到 3；累计10次失败重启系统
  
	3.2 Ping 成功，延时 300 秒，转到 1
  
</details>

### 2. qbBackup

这是一个自动备份`qBittorrent`配置文件的脚本。

每天通过任务计划定时启动`Backup.py`，可以有效避免因NAS断电导致`qBittorrent`显示文件丢失的问题。

#### 备份方法

- 编辑`qbBackup/Backup.py`，修改`maxBackups=15`为欲保存的最大备份数。

- 执行`addSchTask.bat`添加计划任务（中午、午夜各执行 1 次）

#### 恢复方法

- 打开`qbBackup/Backups`目录
- 将欲恢复的备份拖放至`qbBackup/Restore.bat`上即可。

**注意**：恢复备份时`qBittorrent`需要在停止运行状态。

#### 便携版

需要修改`qbBackup/Backup.py`中的`backPath`参数以适应便携版。

### 3. ubuntu 

自用初始化脚本。
