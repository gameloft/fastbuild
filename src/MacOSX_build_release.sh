echo "Creating Fastbuild binary..."
cd $PWD/src/Code
../Bin/MacOSX-x64/FBuild All-x64OSX-Release -clean
if [ $? -ne 0 ]
then 
	exit 1
else
	echo "Build Done"
fi
cd $PWD
cp ../tmp/x64OSX-Release/Tools/FBuild/FBuild/FBuild ../Bin/MacOSX-x64/FBuild
cp ../tmp/x64OSX-Release/Tools/FBuild/FBuildWorker/FBuildWorker ../Bin/MacOSX-x64/FBuildWorker

mv ../tmp/x64OSX-Release/Tools/FBuild/FBuild/FBuild ../../bin/FBuild
mv ../tmp/x64OSX-Release/Tools/FBuild/FBuildWorker/FBuildWorker ../../bin/FBuildWorker
if [ $? -ne 0 ]
then 
	exit 1
else
	echo "Copy Done"
fi

echo "Removing intermediary tmp..."
rm -rf ../tmp
rm fbuild.osx.fdb
echo "[done]"
