REM --add the following to the top of your bat file--


@echo off

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------

copy /-y "%~dp0\PatchMyPC.exe" "C:\" 


wmic printer where name='\\\\pb-wappapercut1.ad.utrgv.edu\\[Find-Me-Printer] - Brownsville' call setdefaultprinter



"C:\\Program Files (x86)\\Google\Chrome\\Application\\chrome.exe" --make-default-browser


::rundll32 printui.dll,PrintUIEntry /dl /n "BUBLB Printer Pool" /c \\pb-wappapercut1
RUNDLL32 printui.dll,PrintUIEntry /n "\\pb-wappapercut1.ad.utrgv.edu\BUBLB Printer Pool" /dn