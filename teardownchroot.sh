#!/bin/bash

export LFS="$1"
export DIROWNER="$2"
export DIRGROUP="$3"


if [ "$LFS" == "" ]; then
    exit 1
fi

if [ -h $LFS/dev/shn ]; then 
    rm -rf $LFS/$(readlink $LFS/dev/shn)
fi

unmount $LFS/run
unmount $LFS/sys
unmount $LFS/proc
unmount $LFS/dev/pts
unmount $LFS/dev

rm -f $LFS/dev/console
rm -f $LFS/dev/null


chown -R $DIROWNER:$DIRGROUP $LFS/tools
chown -R $DIROWNER:$DIRGROUP $LFS/boot
chown -R $DIROWNER:$DIRGROUP $LFS/etc
chown -R $DIROWNER:$DIRGROUP $LFS/bin
chown -R $DIROWNER:$DIRGROUP $LFS/lib
chown -R $DIROWNER:$DIRGROUP $LFS/sbin
chown -R $DIROWNER:$DIRGROUP $LFS/usr
chown -R $DIROWNER:$DIRGROUP $LFS/var

case $(uname -m) in
  x86_64) chown -R $DIROWNER:$DIRGROUP $LFS/lib64 ;;
esac

