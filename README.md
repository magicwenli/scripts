# SCRIPTS

## 列表

| *    | NAME              | USE             | PLANTFORM      | LINK                                                         |
| :--- | :---------------- | --------------- | -------------- | ------------------------------------------------------------ |
| 1    | autoReconnect     | 拨号与重连      | Windows        | [CLICK](https://github.com/magicwenli/scripts/tree/master/autoReconnect) |
| 2    | qbBackup          | qbittorrent备份 | Windows        | [CLICK](https://github.com/magicwenli/scripts/tree/master/qbBackup) |
| 2.a  | qbittorrentBackup | qbittorrent备份 | Windows        | [CLICK](https://github.com/magicwenli/scripts/tree/master/qbittorrentBackup) |
| 3    | healthCheck       | 健康每日报check | Windows/Chrome | [CLICK](https://github.com/magicwenli/scripts/tree/master/healthCheck) |

## 说明

### 1. autoReconnect

  这是一个带有日志功能的自动拨号脚本，已经在 Windows 7 x86 下测试通过。

  默认情况下 **Ping** IPV6 网关。如需在 IPV4 下使用，去除 **Ping** 命令尾部的 -6 即可。

  伪代码如下：

<details>
```
1. Ping 网关地址，检测是否已拨号。
	1.1 Ping 失败，转到 3
	1.2 Ping 成功，转到 2
2. 延时等待 600 秒，转到 1
3. 断开全部连接，重新拨号并 Ping 网关检测连接状态
	3.1 Ping 失败，延时 100 秒，转到 3；累计10次失败重启系统
	3.2 Ping 成功，延时 300 秒，转到 1
```
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

### 2.a qbittorrentBackup

> 这个版本是批处理版，只能保存两个备份。由于CMD功能限制，增加更多备份的功能不便实现。所以现在使用python版，旧版弃用，保存以待观瞻学习。

使用方式：

- 双击执行`Backup.bat`，即可将`qBittorrent`的配置及种子备份到当前目录下的Backup文件夹中；
  如果已有旧的`Backup`备份，则会将旧备份重新更名为`Backup.old`；再久远的备份则会被删除，
  即脚本最多只会保留两次备份的文件。

- 双击执行`Restore.bat`，如果有`Backup`备份，则会优先从Backup中还原；否则再去查找是否有
  `Backup.old`备份，如果有则从`Backup.old`中还原；如果两个备份都没有，则会提示没有可用的备份并退出。

这个脚本是在互联网上找到的，年限久远，作者未知，但非常有用。

任务计划示例：

```batch
...\qbittorrentBackup\Backup.bat
timeout /nobreak /t 20
shutdown -r -t 20
```
### 3. healthCheck

Forked from [JerryYang666/XJTU-DHA-auto-complete](https://github.com/JerryYang666/XJTU-DHA-auto-complete). win7 x86 下测试通过。

#### Diff

- 增加日志
- 通过批处理添加每日签到的计划任务
- 修改几处延时为隐性延时

#### 环境

- python(selenium)
- chrome
- chromedriver([Here](https://chromedriver.storage.googleapis.com/index.html))

#### 定时任务

打开`addSchTask.bat`即可自动添加上午和下午的定时任务。


```