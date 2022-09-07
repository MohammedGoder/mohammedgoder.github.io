@echo off

set projpath=%CD%

if not exist "%projpath%\build.bat" (
	echo set buildversion=0 > "%projpath%\build.bat"
)
call "%projpath%\build.bat"
set /a buildversion=%buildversion%+1
for /f "tokens=1,2 delims==" %%G in ('wmic path win32_utctime get year^, month^, day^, hour^, minute^, second^ /value ^| find "="') do (set build%%G=%%H)
echo set buildversion=%buildversion% > "%projpath%\build.bat"
echo set buildyear=%buildYear% >> "%projpath%\build.bat"
echo set buildmonth=%buildMonth% >> "%projpath%\build.bat"
echo set buildday=%buildDay% >> "%projpath%\build.bat"
echo set buildhour=%buildHour% >> "%projpath%\build.bat"
echo set buildminute=%buildMinute% >> "%projpath%\build.bat"
echo set buildsecond=%buildSecond% >> "%projpath%\build.bat"
title Build Version: %buildversion% - %projpath%
echo Build Version: %buildversion% - %projpath%

cd "%gitpath%"
call git init
call git add "%projpath%"
call git commit -m "Build Version: %buildversion%"
call git branch -M main
call git push -u origin main

pause
exit

git init
git add motives-portal
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/AlloAppTeam/MotivesPortal.git
git push -u origin main
pause > NUL