@echo off
IF NOT EXIST ".\Backup" GOTO SearchBakOld
ECHO 即将从“Backup”中恢复qBittorrent相关配置
ECHO 若要停止还原，请按Ctrl+C键，否则按任意键开始还原
PAUSE > NUL
IF EXIST "%LocalAppData%\qBittorrent" (
	RD /S /Q  "%LocalAppData%\qBittorrent"
)
XCOPY /E /I /Q ".\Backup\Local\qBittorrent" "%LocalAppData%\qBittorrent"
IF EXIST "%AppData%\qBittorrent" (
	RD /S /Q "%AppData%\qBittorrent"
)
XCOPY /E /I /Q ".\Backup\Roaming\qBittorrent" "%AppData%\qBittorrent"
ECHO 成功从“Backup”还原配置，按任意键结束...
PAUSE > NUL
EXIT

:SearchBakOld
IF NOT EXIST ".\Backup.old" GOTO BakNotFound
ECHO 即将从“Backup.old”中恢复qBittorrent相关配置
ECHO 若要停止还原，请按Ctrl+C键，否则按任意键开始还原
PAUSE > NUL
IF EXIST "%LocalAppData%\qBittorrent" (
	RD /S /Q  "%LocalAppData%\qBittorrent"
)
XCOPY /E /I /Q ".\Backup.old\Local\qBittorrent" "%LocalAppData%\qBittorrent"
IF EXIST "%AppData%\qBittorrent" (
	RD /S /Q "%AppData%\qBittorrent"
)
XCOPY /E /I /Q ".\Backup.old\Roaming\qBittorrent" "%AppData%\qBittorrent"
ECHO 成功从“Backup.old”还原配置，按任意键结束...
PAUSE > NUL
EXIT

:BakNotFound
ECHO 没有可以使用的备份，还原终止，按任意键结束...
PAUSE > NUL
