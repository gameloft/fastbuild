@echo on

set CUR_DIR=%cd%

cd "%CUR_DIR%\Code"

"%CUR_DIR%\Bin\Windows-x64\FBuild.exe" solution

cd "%CUR_DIR%"