@echo off
set WAR_NAME=C:/Users/SENA/Documents/S4/Naina/Bibliotheque/spring-web/target/spring-web-1.0-SNAPSHOT.war
set SOURCE_DIR=
set DEST_DIR=C:/tomcat/webapps

echo Copying %WAR_NAME% to %DEST_DIR% ...
copy "%WAR_NAME%" "%DEST_DIR%\%WAR_NAME%" /Y

if %ERRORLEVEL%==0 (
    echo Deploy successful.
) else (
    echo Deploy failed.
)
pause
