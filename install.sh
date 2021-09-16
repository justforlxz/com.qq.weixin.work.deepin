echo "Start installing..."

for _deb in $(ls *.deb); do
    echo "Installing $_deb"
    ar p "$_deb" data.tar.xz | tar -xJ
done

cp -a opt /

echo "Done"
