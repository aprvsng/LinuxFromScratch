#!/bin/bash


export LFS=/mnt/lfs
export LFS_TGT=x86_64-lfs-linux-gnu
export LFS_DISK=/dev/sda

if ! grep -q "$LFS" /proc/mounts; then
    source setupdisk.sh "$LFS_DISK"
    sudo mount "${LFS_DISK}2" "$LFS"
    sudo chown -v $USER "$LFS"
fi


mkdir -pv $LFS/sources
mkdir -pv $LFS/tools

mkdir -pv $LFS/boot
mkdir -pv $LFS/etc
mkdir -pv $LFS/bin
mkdir -pv $LFS/lib
mkdir -pv $LFS/sbin
mkdir -pv $LFS/usr
mkdir -pv $LFS/var

case $(uname -m) in
  x86_64) mkdir -pv $LFS/lib64 ;;
esac


cp -rf *.sh chapter*  packages.csv "$LFS/sources"
cd "$LFS/sources"
export PATH="$LFS/tools/bin:$PATH"


source download.sh

#chapter 5
for package in binutils gcc linux glibc libstdc++; do
    source packageinstall.sh 5 $package
done

#chapter 6
for package in m4 ncurses bash coreutils diffutils file findutils gawk grep gzip make patch sed tar xz binutils gcc; do
    source packageinstall.sh 5 $package
done


chmod ugo+x preparechroot.sh
chmod ugo+x insidechroot.sh
chmod ugo+x insidechroot2.sh
chmod ugo+x insidechroot3.sh
chmod ugo+x teardownchroot.sh

# ./chroot_bash.sh "$LFS" -c insidechroot.sh
# ./chroot_bash.sh "$LFS" -c insidechroot2.sh


sudo ./preparechroot.sh "$LFS"
for script in "/sources/insideroot.sh" "/sources/insideroot2.sh" "/sources/insideroot3.sh"; do
	echo "RUNNING $script IN CHROOT ENVIRONMENT...."
	sleep 3
	sudo chroot "$LFS" /usr/bin/env  \
		HOME=/root 	\
	    	TERM="$TERM" \
	    	PS1="(lfs chroot)  \u:\w\$" \
	    	PATH="/bin:/usr/bin:/sbin:/usr/sbin" \
		TESTERUID=$UID \
	    	/bin/bash --login +h -c "$script"
done


sudo ./teardownchroot.sh "$LFS" "$USER" "$(id -gn)"
