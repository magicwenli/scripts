echo off

set cpath=%~dp0Backup.py
echo -----------------------------
echo ��ǰ·����%cpath%
echo -----------------------------
schtasks /Create /SC DAILY /TN qbBackup13 /TR %cpath% /ST 13:30
schtasks /Create /SC DAILY /TN qbBackup03 /TR %cpath% /ST 03:10
echo -----------------------------
echo ��� 13:30 �� 03:10 �ļƻ�����ɹ�
echo -----------------------------
pause
