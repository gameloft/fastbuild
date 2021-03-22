echo "Creating Fastbuild binary..."
cd $PWD/src/Code
../Bin/MacOSX-x64/FBuild All-x64OSX-Release -clean
cd $PWD
cp ../tmp/x64OSX-Release/Tools/FBuild/FBuildApp/FBuild ../Bin/MacOSX-x64/FBuild
cp ../tmp/x64OSX-Release/Tools/FBuild/FBuildWorker/FBuildWorker ../Bin/MacOSX-x64/FBuildWorker

mv ../tmp/x64OSX-Release/Tools/FBuild/FBuildApp/FBuild ../../bin/FBuild
mv ../tmp/x64OSX-Release/Tools/FBuild/FBuildWorker/FBuildWorker ../../bin/FBuildWorker
echo "[done]"

echo "Removing intermediary tmp..."
rm -rf ../tmp
rm fbuild.osx.fdb
echo "[done]"
