@echo off
IF NOT EXIST "%LocalAppData%\qBittorrent" GOTO CfgNotFound
IF NOT EXIST "%AppData%\qBittorrent" GOTO CfgNotFound
ECHO ������qBittorrent����������ļ���������Backup"��
ECHO ��Ҫ��ֹ���ݣ��밴Ctrl+C���������������ʼ����
:: PAUSE > NUL
IF EXIST ".\Backup" (
	IF EXIST ".\Backup.old" (
		RD /S /Q ".\Backup.old"
	)
	MOVE ".\Backup" ".\Backup.old"
	ECHO ��һ�εı����Ѹ���Ϊ��Backup.old��
)
XCOPY /E /I /Q "%LocalAppData%\qBittorrent" ".\Backup\Local\qBittorrent"
XCOPY /E /I /Q "%AppData%\qBittorrent" ".\Backup\Roaming\qBittorrent"
ECHO ������ɣ������������...
:: PAUSE > NUL
timeout /t 3
EXIT

:CfgNotFound
ECHO û���ҵ�qBittorrent�������ļ����޷����б��ݣ���������...
PAUSE > NUL