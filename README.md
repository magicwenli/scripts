# SCRIPTS

## 列表

| *    | NAME              | USE             | PLANTFORM      | LINK                                                         |
| :--- | ----------------- | --------------- | -------------- | ------------------------------------------------------------ |
| 1    | autoReconnect     | 自动拨号        | Windows        | [CLICK](https://github.com/magicwenli/scripts/tree/master/autoReconnect) |
| 2    | qbittorrentBackup | qbittorrent备份 | Windows        | [CLICK](https://github.com/magicwenli/scripts/tree/master/qbittorrentBackup) |
| 3    | healthCheck       | 健康每日报check | Windows/Chrome | [CLICK](https://github.com/magicwenli/scripts/tree/master/healthCheck) |

## 说明

### 1. autoReconnect

  这是一个带有日志功能的自动拨号脚本，已经在 Windows 7 x86 下测试通过。

  默认情况下 **Ping** IPV6 网关。如需在 IPV4 下使用，去除 **Ping** 命令尾部的 -6 即可。

  伪代码如下：

```
1. Ping 网关地址，检测是否已拨号。

	1.1 Ping 失败，转到 3

	1.2 Ping 成功，转到 2

2. 延时等待 600 秒，转到 1

3. 断开全部连接，重新拨号并 Ping 网关检测连接状态

	3.1 Ping 失败，延时 100 秒，转到 3；累计10次失败重启系统

	3.2 Ping 成功，延时 300 秒，转到 1
```

### 2. qbittorrentBackup

这是一个自动备份`qbittorrent`配置文件的脚本。

每天通过任务计划定时启动Backup.bat，可以有效避免因NAS断电导致`qbittorrent`显示文件丢失的问题。

使用方式：

1. 双击执行Backup.bat，即可将qBittorrent的配置及种子备份到当前目录下的Backup文件夹中；
   如果已有旧的Backup备份，则会将旧备份重新更名为Backup.old；再久远的备份则会被删除，
   即脚本最多只会保留两次备份的文件。

2. 双击执行Restore.bat，如果有Backup备份，则会优先从Backup中还原；否则再去查找是否有
   Backup.old备份，如果有则从Backup.old中还原；如果两个备份都没有，则会提示没有可用的备份
   并退出。

这个脚本是在互联网上找到的，年限久远，作者未知，但非常有用。

任务计划示例：

```batch
...\qbittorrentBackup\Backup.bat
timeout /nobreak /t 20
shutdown -r -t 20
```

### 3. healthCheck

Forked from [JerryYang666/XJTU-DHA-auto-complete](https://github.com/JerryYang666/XJTU-DHA-auto-complete). win7 x86 下测试通过。

#### 环境

- python(selenium)
- chrome
- chromedriver([Here](https://chromedriver.storage.googleapis.com/index.html))

#### 定时任务

打开`addSchTask.bat`即可添加上午和下午的定时任务。

