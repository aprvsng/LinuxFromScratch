
./packageinstall.sh 9 lfs-bootscripts

cd /etc/sysconfig/
cat > ifconfig.eth0 << "EOF"
ONBOOT=yes
IFACE=eth0
SERVICE=ipv4-static
IP=172.18.0.1
GATEWATY=172.18.0.1
PREFIX=24
BROADCAST=172.18.255.255
EOF

cat > /etc/resolv.conf << "EOF"
# Begin /etc/resolv.conf

#domain <Your Domain Name>
nameserver 172.18.0.1
nameserver 8.8.8.8

# End /etc/resolv.conf
EOF

echo "lfs-laptop" /etc/hostname 

cat > /etc/hosts << "EOF"
# Begin /etc/hosts

<192.168.0.2> <FQDN> [alias1] [alias2] ...
::1       ip6-localhost ip6-loopback
ff02::1   ip6-allnodes
ff02::2   ip6-allrouters

# End /etc/hosts
EOF


cat < /etc/inittab <<"EOF"
#Begin /etc/inittab
id:3:initdefault
si::sysinit:/etc/rc.d/init.d/rc S
l0:0:wait:/etc/rc.d/init.d/rc 0
l1:S1:wait:/etc/rc.d/init.d/rc 1
l2:2:wait:/etc/rc.d/init.d/rc 2
l3:3:wait:/etc/rc.d/init.d/rc 3
l4:4:wait:/etc/rc.d/init.d/rc 4
l5:5:wait:/etc/rc.d/init.d/rc 5
l6:6:wait:/etc/rc.d/init.d/rc 6
ca:12345:ctrlaltdel:/sbin/shutdown -t1 -a -r now
su:S016:once:/sbin/sulogin
1:2345:respawn:/sbin/agetty --noclear tty1 9600
2:2345:respawn:/sbin/agetty tty2 9600
3:2345:respawn:/sbin/agetty tty3 9600
4:2345:respawn:/sbin/agetty tty4 9600
5:2345:respawn:/sbin/agetty tty5 9600
6:2345:respawn:/sbin/agetty tty6 9600
#END /etc/inittab
EOF


cat > /etc/sysconfig/clock <<"EOF"
# Begin /etc/sysconfig/clock
UTC=1
# set this to any options you might need to give to howclock,
# such as machine hardware clock type for alphas
CLOCKPARAMS=

# End /etc/sysconfig/clock

EOF
