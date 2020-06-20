REM *************************************************************
REM Author:magicwenli
REM Date:2020/06/20
REM https://github.com/magicwenli/scripts
REM Description:
REM   这是一个带有日志功能的自动拨号脚本，已经在 Windows 7 x86 下测试通过。
REM   默认情况下 Ping IPV6 网关。如需在 IPV4 下使用，去除 Ping 命令尾部的 -6 即可。
REM   伪代码如下：
REM   1. Ping 网关地址，检测是否已拨号。
REM     1.1 Ping 失败，转到 3
REM     1.2 Ping 成功，转到 2
REM   2. 延时等待 600 秒，转到 1
REM   3. 断开全部连接，重新拨号并 Ping 网关检测连接状态
REM     3.1 Ping 失败，延时 100 秒后重拨，累计10次失败重启系统
REM     3.2 Ping 成功，延时 300 秒，转到 1
REM *************************************************************

@echo off

set /a counter=0

set folder=log
set filename=%Date:~0,4%-%Date:~5,2%-%Date:~8,2%.txt

REM *************************************************************
REM 填写 网关地址｜拨号连接的名称｜账号｜密码
set gate=fe80::1:2:3:cccc
set netname=宽带连接
set username=username
set password=password
REM *************************************************************

set wait=timeout /nobreak /t SECONDS 1>nul

:Begin
REM *************************************************************
REM Ping 命令
ping -n 4 %gate% -6
REM *************************************************************
if errorlevel 1 goto Reconnect

if errorlevel 0 goto Continue

:Continue

echo %Date:~0,4%-%Date:~5,2%-%Date:~8,2% %time:~0,2%:%time:~3,2%:%time:~6,2%  连接正常...>>%folder%\%filename%

echo %Date:~0,4%-%Date:~5,2%-%Date:~8,2% %time:~0,2%:%time:~3,2%:%time:~6,2%  连接正常...

REM 设置延时等待

%wait:SECONDS=600%

goto Begin:

:Reconnect

echo %Date:~0,4%-%Date:~5,2%-%Date:~8,2% %time:~0,2%:%time:~3,2%:%time:~6,2%  无法连接到网关，尝试重新连接...>>%folder%\%filename%

echo %Date:~0,4%-%Date:~5,2%-%Date:~8,2% %time:~0,2%:%time:~3,2%:%time:~6,2%  无法连接到网关，尝试重新连接...

echo %Date:~0,4%-%Date:~5,2%-%Date:~8,2% %time:~0,2%:%time:~3,2%:%time:~6,2%  断开所有拨号连接...>>%folder%\%filename%

echo %Date:~0,4%-%Date:~5,2%-%Date:~8,2% %time:~0,2%:%time:~3,2%:%time:~6,2%  断开所有拨号连接...

rasdial /disconnect >>%folder%\%filename%
echo.>>%folder%\%filename%

echo %Date:~0,4%-%Date:~5,2%-%Date:~8,2% %time:~0,2%:%time:~3,2%:%time:~6,2%  开始重新拨号...>>%folder%\%filename%

echo %Date:~0,4%-%Date:~5,2%-%Date:~8,2% %time:~0,2%:%time:~3,2%:%time:~6,2%  开始重新拨号...

rasdial %netname% %username% %password% >>%folder%\%filename%
echo.>>%folder%\%filename%

if errorlevel 1 goto Fail

if errorlevel 0 goto Success

:Fail

if counter 11 goto Reboot

set /a counter+=1

echo %Date:~0,4%-%Date:~5,2%-%Date:~8,2% %time:~0,2%:%time:~3,2%:%time:~6,2%  拨号失败，100秒后尝试第%counter%次重拨，10次重拨失败后将重启电脑...>>%folder%\%filename%

echo %Date:~0,4%-%Date:~5,2%-%Date:~8,2% %time:~0,2%:%time:~3,2%:%time:~6,2%  拨号失败，100秒后尝试第%counter%次重拨，10次重拨失败后将重启电脑...

%wait:SECONDS=100%

goto Reconnect

:Success

echo %Date:~0,4%-%Date:~5,2%-%Date:~8,2% %time:~0,2%:%time:~3,2%:%time:~6,2%  拨号成功，300秒后进行下一步操作...>>%folder%\%filename%

echo %Date:~0,4%-%Date:~5,2%-%Date:~8,2% %time:~0,2%:%time:~3,2%:%time:~6,2%  拨号成功，300秒后进行下一步操作...

REM 设置延时等待

set /a counter=0

%wait:SECONDS=300%

goto Begin:

:Reboot

echo %Date:~0,4%-%Date:~5,2%-%Date:~8,2% %time:~0,2%:%time:~3,2%:%time:~6,2%  重新启动计算机...>>%folder%\%filename%

echo %Date:~0,4%-%Date:~5,2%-%Date:~8,2% %time:~0,2%:%time:~3,2%:%time:~6,2%  重新启动计算机...

shutdown -r -t 1


