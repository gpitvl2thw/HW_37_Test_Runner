@ECHO OFF

::==================================================
SET GITHUB_ACCOUNT=%1
SET REPO_NAME=%2
SET APP_VERSION=%3
SET MAIN_CLASS=%4
SET ARGS_01=%5
::==================================================

IF "%JAVA_HOME%" == "" GOTO EXIT_JAVA
ECHO Java installed
IF "%M2%" == "" GOTO EXIT_MVN
ECHO Maven installed
CALL git --version > nul 2>&1
IF NOT %ERRORLEVEL% == 0 GOTO EXIT_GIT
ECHO Git installed

GOTO NEXT
:NEXT
::rmdir /s /q %REPO_NAME%
::DEL /S /Q %REPO_NAME%.txt
IF EXIST %REPO_NAME% RMDIR /S /Q %REPO_NAME%
IF EXIST %REPO_NAME%.txt DEL /S /Q %REPO_NAME%.txt

git clone https://github.com/%GITHUB_ACCOUNT%/%REPO_NAME%.git
CD %REPO_NAME%

SLEEP 2
CALL mvn clean package -Dversion=%APP_VERSION%

ECHO.
ECHO Executing Java programm ...
::java -cp .\target\%REPO_NAME%-%APP_VERSION%-jar-with-dependencies.jar %MAIN_CLASS% >> ..\%REPO_NAME%.txt
java -jar .\target\%REPO_NAME%-%APP_VERSION%-jar-with-dependencies.jar >> ..\%REPO_NAME%.txt

cd ..
IF EXIST %REPO_NAME% RMDIR /S /Q %REPO_NAME%
GOTO END

:EXIT_JAVA
ECHO No Java installed
GOTO END
:EXIT_MVN
ECHO No Maven installed
GOTO END
:EXIT_GIT
ECHO No Git installed
GOTO END
:NO_WORKSPACE
ECHO %WS_DIR% is not exists

GOTO END
:END

