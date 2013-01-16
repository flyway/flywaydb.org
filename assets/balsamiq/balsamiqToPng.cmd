@echo off
if not [%1]==[] goto :pth
for /r %%G in (*.bmml) do (
echo %%~dpG%%~nG.png
"C:\Program Files (x86)\Balsamiq Mockups\Balsamiq Mockups.exe" export "%%~fG" "%%~dpG%%~nG.png"
)
exit /b
:pth
if exist %1 (
for /r %%G in (*.bmml) do (
echo %~f1\%%~nG.png
"C:\Program Files (x86)\Balsamiq Mockups\Balsamiq Mockups.exe" export "%%~fG" "%~f1\%%~nG.png"
)
) else (
echo Export directory "%~f1" does not exist.
)