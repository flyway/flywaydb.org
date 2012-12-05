
IF "%1"=="" GOTO error

ECHO Updating javadoc to v.%1
git pull

ECHO Removing old javadoc
DEL /Q /S documentation\javadoc
for /f %%f in ('dir /ad /b c:\share\') do rd /s /q c:\share\%f

ECHO Copying new javadoc
mkdir download
cscript.exe _download.vbs "http://search.maven.org/remotecontent?filepath=com/googlecode/flyway/flyway-core/%1/flyway-core-%1-javadoc.jar", "download/javadoc.zip"
cd documentation/javadoc
jar xf ..\..\download\javadoc.zip
cd ..\..
DEL download\javadoc.zip
RMDIR download

ECHO Committing
REM git commit -m "Updated javadoc to version %1"

ECHO Pushing
REM git push

ECHO Done !

GOTO :eof

:error
ECHO Missing newVersion !
ECHO.
ECHO Usage:
ECHO %0 newVersion
ECHO.
ECHO Example:
ECHO %0 1.4.1

