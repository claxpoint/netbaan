#!/bin/bash

:: Inspired by: https://github.com/claxpoint
MSHTA.EXE vbscript:Close(MsgBox("Welcome! Click on OK for continue.",vbOKOnly,"NetBaan - v1.0"))

@echo off
cls
color 2
echo:
echo          NetBaan DNSchnager by Claxpoint - v1.0
echo                   github.com/claxpoint
echo:
echo     Recommended DNS's :
echo --------------------------------------------------------
echo Shecan - 178.22.122.100 / 185.51.200.2
echo RadarGame - 1.202.10.10 / 10.202.10.102
echo Begzar - 185.55.226.26 / 185.55.226.26
echo Cloudflare - 1.1.1.1 / 1.0.0.1
echo Electro - 78.157.42.100 / 78.157.42.101
echo NotronConnectSafe - 199.85.126.10 / 199.85.127.10
echo:
echo:
echo 1-Change DNS
echo 2-Reset DNS to Auto
echo:

FOR /F "tokens=*" %%g IN ('powershell.exe -ExecutionPolicy Bypass -Command "Get-NetAdapter  * | Format-List -Property "Name" | findstr /R "Name""') do (SET VAR=%%g)
echo Adapter %VAR%
powershell.exe -ExecutionPolicy Bypass -Command "$A = Get-DnsClientServerAddress -AddressFamily IPv4; $A = $A.ServerAddresses; \"Currnet DNS: \" + $A[0] + \" , \" + $A[1] "
echo:

set /p "option=Choose Option : "


set /p "adaptor=Enter Netowrk Adapter Name (1 for Ethernet and 2 for Wi-Fi or write something else...): "

if %adaptor%==1 ( 
    set adaptor=Ethernet

) else if %adaptor%==2 (

    set adaptor=Wi-Fi
)

if %option%==1 (
    set /p "dns1=Enter Preferred DNS : "
    set /p "dns2=Enter Alternate DNS : "
) else if %option%==2 (
    @netsh interface ipv4 set dnsservers name="%adaptor%" source=dhcp
    echo All DNS's Removed Success.
    echo:
    set /p "p=Press Any Key To Exit..."
    Exit
)
echo:
echo =====Testing DNSConnection=====
rem powershell.exe -ExecutionPolicy Bypass -Command "test-connection %dns1%,%dns2% -Count 1 | format-table ResponseTime"
CALL:pingtest1 %dns1%
CALL:pingtest2 %dns2%
echo [ %dns1% ] = [ %ms1% ]
echo [ %dns2% ] = [ %ms2% ]
echo ===============================
netsh interface ipv4 set dnsservers "%adaptor%" static %dns1% primary
netsh interface ip add dns "%adaptor%" %dns2% index=2
ipconfig /flushdns
echo: 
echo DNS set Successfully.
echo: 
set /p "p=Press Any Key To Exit..."


:pingtest1
SET ms1= ERROR
FOR /F "tokens=4 delims==" %%i IN ('ping -n 1 %1 ^| FIND "ms"') DO SET ms1=%%i
GOTO:EOF

:pingtest2
SET ms2= ERROR
FOR /F "tokens=4 delims==" %%i IN ('ping -n 1 %1 ^| FIND "ms"') DO SET ms2=%%i
GOTO:EOF
