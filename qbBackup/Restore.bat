@echo off

if "%~1" == "" (
    echo -----------------------------
    echo ����Ҫ�ָ��ı����Ϸŵ�bat�ļ���
    echo ֱ�Ӵ򿪲�ִ���κβ���
    echo -----------------------------
    pause
    goto endProg
)

set Local = %~1\Local\qBittorrent
set Roaming = %~1\Roaming\qBittorrent

IF EXIST "%LocalAppData%\qBittorrent" (
	RD /S /Q  "%LocalAppData%\qBittorrent"
)
XCOPY /E /I /Q "%Local%" "%LocalAppData%\qBittorrent"
if %errorlevel% == 4 goto error1

IF EXIST "%AppData%\qBittorrent" (
	RD /S /Q "%AppData%\qBittorrent"
)
XCOPY /E /I /Q "%Roaming%" "%AppData%\qBittorrent"
if %errorlevel% == 4 goto error1

ECHO �ɹ��ӡ�Backup����ԭ���ã������������...
pause

:endProg
exit

:error1
echo �ָ�����ʱ���ִ��󣬹ر�Qbittorrent������
pause
exit