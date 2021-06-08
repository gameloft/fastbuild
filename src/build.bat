@echo on

set CUR_DIR=%~dp0
echo "Creating Fastbuild binary..."
cd "%CUR_DIR%\Code"
"%CUR_DIR%\Bin\Windows-x64\FBuild.exe" All-x64-Release -summary
IF !errorlevel! NEQ 0 exit /b !errorlevel! 
cd "%CUR_DIR%"
xcopy /y %CUR_DIR%\tmp\x64-Release\Tools\FBuild\FBuild\FBuild.exe %CUR_DIR%\..\bin\FBuild.exe*
xcopy /y %CUR_DIR%tmp\x64-Release\Tools\FBuild\FBuildWorker\FBuildWorker.exe %CUR_DIR%\..\bin\FBuildWorker.exe*

xcopy /y %CUR_DIR%\tmp\x64-Release\Tools\FBuild\FBuild\FBuild.exe %CUR_DIR%\Bin\Windows-x64\FBuild.exe*
xcopy /y %CUR_DIR%\tmp\x64-Release\Tools\FBuild\FBuildWorker\FBuildWorker.exe %CUR_DIR%\Bin\Windows-x64\FBuildWorker.exe*
IF !errorlevel! NEQ 0 exit /b !errorlevel! 
echo "[done]"

echo "Removing intermediary tmp..."
rm -rf tmp
rm Code/fbuild.windows.fdb
echo "[done]"