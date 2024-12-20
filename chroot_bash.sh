#!/bin/bash

export LFS="$1"
shift

if [ "$LFS" == "" ]; then
    exit 1
fi

cp -rf *.sh chapter* packages.csv "$LFS/sources"

chmod ugo+x preparechroot.sh
sudo ./preparechroot.sh "$LFS"

sudo chroot "$LFS" /usr/bin/env \
    HOME=/root \
    TERM="$TERM" \
    PS1="(lfs chroot) \u:\w\$" \
    PATH="/bin:/usr/bin:/sbin:/usr/sbin" \
    LFS="" \
    TESTERUID=$UID \
    /bin/bash --login +h $@

chmod ugo+x teardownchroot.sh
sudo ./teardownchroot.sh "$LFS" "$USER" "$(id -gn)"
