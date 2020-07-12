@echo off
IF NOT EXIST "%LocalAppData%\qBittorrent" GOTO CfgNotFound
IF NOT EXIST "%AppData%\qBittorrent" GOTO CfgNotFound
ECHO 即将把qBittorrent的相关配置文件备份至“Backup"中
ECHO 若要终止备份，请按Ctrl+C键，否则按任意键开始备份
:: PAUSE > NUL
IF EXIST ".\Backup" (
	IF EXIST ".\Backup.old" (
		RD /S /Q ".\Backup.old"
	)
	MOVE ".\Backup" ".\Backup.old"
	ECHO 上一次的备份已更名为“Backup.old”
)
XCOPY /E /I /Q "%LocalAppData%\qBittorrent" ".\Backup\Local\qBittorrent"
XCOPY /E /I /Q "%AppData%\qBittorrent" ".\Backup\Roaming\qBittorrent"
ECHO 备份完成，按任意键结束...
:: PAUSE > NUL
timeout /t 3
EXIT

:CfgNotFound
ECHO 没有找到qBittorrent的配置文件，无法进行备份，即将结束...
PAUSE > NUL