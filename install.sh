echo "Start installing..."

unzip com.qq.weixin.work.deepin.zip -d tmp
mkdir /app/bin
mv tmp/com.qq.weixin.work.deepin/run.sh /app/bin
#chmod a+x /app/bin/run.sh
cp -r tmp/com.qq.weixin.work.deepin/* /app/

echo "Done"
