
touch /var/log/{btmp,lastlog,faillog,wtmp}
chgrp -v utmp /var/log/lastlog
chmod -v 664 /var/log/lastlog
chmod -v 600 /var/log/btmp


export LFS=""
cd /sources


# CHAPTER 7
for package in libstdc++ gettext bison perl python texinfo util-linux; do

	echo -n ""
	source packageinstall.sh 7 $package

done

