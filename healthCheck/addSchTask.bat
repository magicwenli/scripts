echo off

set cpath=%~dp0check.py
echo -----------------------------
echo ��ǰ·����%cpath%
echo -----------------------------
schtasks /Create /SC DAILY /TN healthCheck9 /TR %cpath% /ST 09:30
schtasks /Create /SC DAILY /TN healthCheck16 /TR %cpath% /ST 16:10
echo -----------------------------
echo ���9��30��16��10�ļƻ�����ɹ�
echo -----------------------------
pause
