make mrproper

make headers_install
find usr/include -type f ! -name '*.h' -delete
cp -rv usr/include $LFS/usr
