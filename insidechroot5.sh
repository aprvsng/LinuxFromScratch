
export LFS=""
cd /sources


cat > /etc/fstab << "EOF"
# Begin /etc/fstab

# file system  mount-point  type     options             dump  fsck
#                                                              order

/dev/sda2      /            ext2     defaults            1     1
/dev/sda1      boot         ext2     pri=1               0     0

# End /etc/fstab
EOF
