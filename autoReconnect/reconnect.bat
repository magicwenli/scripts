@echo off

REM *************************************************************
REM   Open with GB2312 / 使用 GB2312 打开
REM   Author:magicwenli
REM   Date:2020/06/20
REM   https://github.com/magicwenli/scripts
REM   Description:
REM     ����һ��������־���ܵ��Զ����Žű����Ѿ��� Windows 7 x86 �²���ͨ����
REM     Ĭ������� Ping IPV6 ���ء������� IPV4 ��ʹ�ã�ȥ�� Ping ����β���� -6 ���ɡ�
REM     α�������£�
REM     1. Ping ���ص�ַ������Ƿ��Ѳ��š�
REM       1.1 Ping ʧ�ܣ�ת�� 3
REM       1.2 Ping �ɹ���ת�� 2
REM     2. ��ʱ�ȴ� 600 �룬ת�� 1
REM     3. �Ͽ�ȫ�����ӣ����²��Ų� Ping ���ؼ������״̬
REM       3.1 Ping ʧ�ܣ���ʱ 100 ����ز����ۼ�10��ʧ������ϵͳ
REM       3.2 Ping �ɹ�����ʱ 300 �룬ת�� 1
REM *************************************************************

set /a counter=0

set folder=log
set filename=%Date:~0,4%-%Date:~5,2%-%Date:~8,2%.txt

REM *************************************************************
REM ��д ���ص�ַ���������ӵ����ƣ��˺ţ�����
set gate=fe80::1:2:3:cccc
set netname=��������
set username=username
set password=password
REM *************************************************************

set wait=timeout /nobreak /t SECONDS 1>nul

:Begin
REM *************************************************************
REM Ping ����
ping -n 4 %gate% -6
REM *************************************************************
if errorlevel 1 goto Reconnect

if errorlevel 0 goto Continue

:Continue

echo %Date:~0,4%-%Date:~5,2%-%Date:~8,2% %time:~0,2%:%time:~3,2%:%time:~6,2%  ��������...>>%folder%\%filename%

echo %Date:~0,4%-%Date:~5,2%-%Date:~8,2% %time:~0,2%:%time:~3,2%:%time:~6,2%  ��������...

REM ������ʱ�ȴ�

%wait:SECONDS=600%

goto Begin:

:Reconnect

echo %Date:~0,4%-%Date:~5,2%-%Date:~8,2% %time:~0,2%:%time:~3,2%:%time:~6,2%  �޷����ӵ����أ�������������...>>%folder%\%filename%

echo %Date:~0,4%-%Date:~5,2%-%Date:~8,2% %time:~0,2%:%time:~3,2%:%time:~6,2%  �޷����ӵ����أ�������������...

echo %Date:~0,4%-%Date:~5,2%-%Date:~8,2% %time:~0,2%:%time:~3,2%:%time:~6,2%  �Ͽ����в�������...>>%folder%\%filename%

echo %Date:~0,4%-%Date:~5,2%-%Date:~8,2% %time:~0,2%:%time:~3,2%:%time:~6,2%  �Ͽ����в�������...

rasdial /disconnect >>%folder%\%filename%
echo.>>%folder%\%filename%

echo %Date:~0,4%-%Date:~5,2%-%Date:~8,2% %time:~0,2%:%time:~3,2%:%time:~6,2%  ��ʼ���²���...>>%folder%\%filename%

echo %Date:~0,4%-%Date:~5,2%-%Date:~8,2% %time:~0,2%:%time:~3,2%:%time:~6,2%  ��ʼ���²���...

rasdial %netname% %username% %password% >>%folder%\%filename%
echo.>>%folder%\%filename%

if errorlevel 1 goto Fail

if errorlevel 0 goto Success

:Fail

if counter 11 goto Reboot

set /a counter+=1

echo %Date:~0,4%-%Date:~5,2%-%Date:~8,2% %time:~0,2%:%time:~3,2%:%time:~6,2%  ����ʧ�ܣ�100����Ե�%counter%���ز���10���ز�ʧ�ܺ���������...>>%folder%\%filename%

echo %Date:~0,4%-%Date:~5,2%-%Date:~8,2% %time:~0,2%:%time:~3,2%:%time:~6,2%  ����ʧ�ܣ�100����Ե�%counter%���ز���10���ز�ʧ�ܺ���������...

%wait:SECONDS=100%

goto Reconnect

:Success

echo %Date:~0,4%-%Date:~5,2%-%Date:~8,2% %time:~0,2%:%time:~3,2%:%time:~6,2%  ���ųɹ���300��������һ������...>>%folder%\%filename%

echo %Date:~0,4%-%Date:~5,2%-%Date:~8,2% %time:~0,2%:%time:~3,2%:%time:~6,2%  ���ųɹ���300��������һ������...

REM ������ʱ�ȴ�

set /a counter=0

%wait:SECONDS=300%

goto Begin:

:Reboot

echo %Date:~0,4%-%Date:~5,2%-%Date:~8,2% %time:~0,2%:%time:~3,2%:%time:~6,2%  �������������...>>%folder%\%filename%

echo %Date:~0,4%-%Date:~5,2%-%Date:~8,2% %time:~0,2%:%time:~3,2%:%time:~6,2%  �������������...

shutdown -r -t 1


