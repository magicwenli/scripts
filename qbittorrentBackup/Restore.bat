@echo off
IF NOT EXIST ".\Backup" GOTO SearchBakOld
ECHO �����ӡ�Backup���лָ�qBittorrent�������
ECHO ��Ҫֹͣ��ԭ���밴Ctrl+C���������������ʼ��ԭ
PAUSE > NUL
IF EXIST "%LocalAppData%\qBittorrent" (
	RD /S /Q  "%LocalAppData%\qBittorrent"
)
XCOPY /E /I /Q ".\Backup\Local\qBittorrent" "%LocalAppData%\qBittorrent"
IF EXIST "%AppData%\qBittorrent" (
	RD /S /Q "%AppData%\qBittorrent"
)
XCOPY /E /I /Q ".\Backup\Roaming\qBittorrent" "%AppData%\qBittorrent"
ECHO �ɹ��ӡ�Backup����ԭ���ã������������...
PAUSE > NUL
EXIT

:SearchBakOld
IF NOT EXIST ".\Backup.old" GOTO BakNotFound
ECHO �����ӡ�Backup.old���лָ�qBittorrent�������
ECHO ��Ҫֹͣ��ԭ���밴Ctrl+C���������������ʼ��ԭ
PAUSE > NUL
IF EXIST "%LocalAppData%\qBittorrent" (
	RD /S /Q  "%LocalAppData%\qBittorrent"
)
XCOPY /E /I /Q ".\Backup.old\Local\qBittorrent" "%LocalAppData%\qBittorrent"
IF EXIST "%AppData%\qBittorrent" (
	RD /S /Q "%AppData%\qBittorrent"
)
XCOPY /E /I /Q ".\Backup.old\Roaming\qBittorrent" "%AppData%\qBittorrent"
ECHO �ɹ��ӡ�Backup.old����ԭ���ã������������...
PAUSE > NUL
EXIT

:BakNotFound
ECHO û�п���ʹ�õı��ݣ���ԭ��ֹ�������������...
PAUSE > NUL
