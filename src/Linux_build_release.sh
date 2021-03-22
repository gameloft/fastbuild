echo "Creating Fastbuild binary..."
cd $PWD/src/Code
../Bin/Linux-x64/fbuild All-x64Linux-Release -clean
if [ $? -ne 0 ]
then 
	exit 1
else
	echo "Build Done"
fi
cd $PWD
cp ../tmp/x64Linux-Release/Tools/FBuild/FBuildApp/fbuild ../Bin/Linux-x64/fbuild
cp ../tmp/x64Linux-Release/Tools/FBuild/FBuildWorker/fbuildworker ../Bin/Linux-x64/fbuildworker

if [ $? -ne 0 ]
then 
	exit 1
else
	echo "Copy Done"
fi


echo "Removing intermediary tmp..."
rm -rf ../tmp
rm fbuild.linux.fdb
echo "[done]"