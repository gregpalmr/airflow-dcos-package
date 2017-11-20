@if "%DEBUG%" == "" @echo off
@rem ##########################################################################
@rem
@rem  executor startup script for Windows
@rem
@rem ##########################################################################

@rem Set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" setlocal

set DIRNAME=%~dp0
if "%DIRNAME%" == "" set DIRNAME=.
set APP_BASE_NAME=%~n0
set APP_HOME=%DIRNAME%..

@rem Add default JVM options here. You can also use JAVA_OPTS and EXECUTOR_OPTS to pass JVM options to this script.
set DEFAULT_JVM_OPTS=

@rem Find java.exe
if defined JAVA_HOME goto findJavaFromJavaHome

set JAVA_EXE=java.exe
%JAVA_EXE% -version >NUL 2>&1
if "%ERRORLEVEL%" == "0" goto init

echo.
echo ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:findJavaFromJavaHome
set JAVA_HOME=%JAVA_HOME:"=%
set JAVA_EXE=%JAVA_HOME%/bin/java.exe

if exist "%JAVA_EXE%" goto init

echo.
echo ERROR: JAVA_HOME is set to an invalid directory: %JAVA_HOME%
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:init
@rem Get command-line arguments, handling Windows variants

if not "%OS%" == "Windows_NT" goto win9xME_args

:win9xME_args
@rem Slurp the command line arguments.
set CMD_LINE_ARGS=
set _SKIP=2

:win9xME_args_slurp
if "x%~1" == "x" goto execute

set CMD_LINE_ARGS=%*

:execute
@rem Setup the command line

set CLASSPATH=%APP_HOME%\lib\executor-0.31.0-SNAPSHOT.jar;%APP_HOME%\lib\mesos-1.4.0-rc1.jar;%APP_HOME%\lib\common-0.31.0-SNAPSHOT.jar;%APP_HOME%\lib\protobuf-java-format-1.4.jar;%APP_HOME%\lib\annotations-3.0.1u2.jar;%APP_HOME%\lib\commons-collections-3.2.2.jar;%APP_HOME%\lib\slf4j-api-1.7.25.jar;%APP_HOME%\lib\log4j-core-2.8.1.jar;%APP_HOME%\lib\log4j-slf4j-impl-2.8.1.jar;%APP_HOME%\lib\commons-io-2.4.jar;%APP_HOME%\lib\compiler-0.9.2.jar;%APP_HOME%\lib\commons-lang3-3.4.jar;%APP_HOME%\lib\jackson-datatype-guava-2.6.3.jar;%APP_HOME%\lib\jackson-datatype-jdk8-2.6.3.jar;%APP_HOME%\lib\jackson-datatype-jsr310-2.6.3.jar;%APP_HOME%\lib\jackson-dataformat-yaml-2.6.3.jar;%APP_HOME%\lib\jackson-databind-2.6.3.jar;%APP_HOME%\lib\commons-codec-1.10.jar;%APP_HOME%\lib\jcip-annotations-1.0.jar;%APP_HOME%\lib\jsr305-3.0.1.jar;%APP_HOME%\lib\log4j-api-2.8.1.jar;%APP_HOME%\lib\jackson-core-2.6.3.jar;%APP_HOME%\lib\guava-15.0.jar;%APP_HOME%\lib\snakeyaml-1.15.jar;%APP_HOME%\lib\jackson-annotations-2.6.0.jar;%APP_HOME%\lib\protobuf-java-3.3.1.jar

@rem Execute executor
"%JAVA_EXE%" %DEFAULT_JVM_OPTS% %JAVA_OPTS% %EXECUTOR_OPTS%  -classpath "%CLASSPATH%" com.mesosphere.sdk.executor.Main %CMD_LINE_ARGS%

:end
@rem End local scope for the variables with windows NT shell
if "%ERRORLEVEL%"=="0" goto mainEnd

:fail
rem Set variable EXECUTOR_EXIT_CONSOLE if you need the _script_ return code instead of
rem the _cmd.exe /c_ return code!
if  not "" == "%EXECUTOR_EXIT_CONSOLE%" exit 1
exit /b 1

:mainEnd
if "%OS%"=="Windows_NT" endlocal

:omega
