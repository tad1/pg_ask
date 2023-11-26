#run this on remote
WORKING_REPO="WORKING_REPO"
TIMESTAMP=$(date "+%Y.%m.%d-%H.%M.%S")

svn checkout http://192.168.56.101/svn/191343/ $WORKING_REPO --username user1
cd $WORKING_REPO
echo "test" > test$TIMESTAMP.txt
svn add test$TIMESTAMP.txt
svn commit -m "add test file"

cd ..
rm -fr WORKING_REPO

svn checkout http://192.168.56.101/svn/REPO2/ $WORKING_REPO --username user2
cd $WORKING_REPO
echo "test" > test$TIMESTAMP.txt
svn add test$TIMESTAMP.txt
svn commit -m "add test file"

cd ..
rm -fr WORKING_REPO


# when we don't have write access
svn checkout http://192.168.56.101/svn/REPO2/ $WORKING_REPO --username user1
cd $WORKING_REPO
echo "test" > test2$TIMESTAMP.txt
svn add test2$TIMESTAMP.txt
svn commit -m "add test file"

cd ..
rm -fr WORKING_REPO

# when we don't have read access
svn checkout http://192.168.56.101/svn/191343/ $WORKING_REPO --username user2   