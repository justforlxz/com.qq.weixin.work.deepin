echo "Start installing..."

for _deb in $(ls *.deb); do
    echo "Installing $_deb"
    ar p "$_deb" data.tar.xz | tar -xJ
done

cp -a opt/apps/com.qq.weixin.work.deepin/* /app/

mkdir /app/bin
cp run.sh /app/bin
chmod a+x /app/bin/run.sh

echo "Done"
