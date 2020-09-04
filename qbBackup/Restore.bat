@echo off

if "%~1" == "" (
    echo -----------------------------
    echo 将需要恢复的备份拖放到bat文件上
    echo 直接打开不执行任何操作
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

ECHO 成功从“Backup”还原配置，按任意键结束...
pause

:endProg
exit

:error1
echo 恢复备份时出现错误，关闭Qbittorrent后重试
pause
exit