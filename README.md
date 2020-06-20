# SCRIPTS

## 列表

| *    | NAME          | USE      | PLANTFORM | LINK                                                         |
| :--- | ------------- | -------- | --------- | ------------------------------------------------------------ |
| 1    | autoReconnect | 自动拨号 | Windows   | [CLICK](https://github.com/magicwenli/scripts/autoReconnect) |
|      |               |          |           |                                                              |
|      |               |          |           |                                                              |

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

