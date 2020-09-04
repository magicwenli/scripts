echo off

set cpath=%~dp0Backup.py
echo -----------------------------
echo 当前路径：%cpath%
echo -----------------------------
schtasks /Create /SC DAILY /TN qbBackup13 /TR %cpath% /ST 13:30
schtasks /Create /SC DAILY /TN qbBackup03 /TR %cpath% /ST 03:10
echo -----------------------------
echo 添加 13:30 和 03:10 的计划任务成功
echo -----------------------------
pause
