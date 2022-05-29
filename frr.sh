#!/bin/bash
set -eux

rid=$1

# Install FRR
apt-get install -y --no-install-recommends frr
echo -e 'zebra=yes\nospf6d=yes' > frr-daemons
sudo mv frr-daemons /etc/frr/daemons

cat << EOF | tee /etc/frr/frr.conf
frr defaults traditional
log syslog informational
service integrated-vtysh-config
username vagrant nopassword
!
ipv6 forwarding
!
router ospf6
 ospf6 router-id $rid
 log-adjacency-changes
 exit
!
interface lo
 ipv6 ospf6 area 0
 exit
!
interface eth2
 ipv6 ospf6 area 0
 ipv6 ospf6 network point-to-point
 exit
!
interface eth3
 ipv6 ospf6 area 0
 ipv6 ospf6 network point-to-point
 exit
!
EOF

chown frr:frr /etc/frr/daemons
chown frr:frr /etc/frr/frr.conf
chmod 640 /etc/frr/frr.conf
usermod -a -G frr vagrant
usermod -a -G frrvty vagrant
systemctl start frr.service
systemctl restart frr.service

cat << EOF | tee /etc/hosts
127.0.0.1 localhost
fc00::1 pmx1.example.com pmx1
fc00::2 pmx2.example.com pmx2
fc00::3 pmx3.example.com pmx3
EOF

cat << EOF | sudo tee /etc/modprobe.d/qemu-system-x86.conf
options kvm_intel nested=1
EOF

modprobe -r kvm_intel

modprobe kvm_intel nested=1

cat /sys/module/kvm_intel/parameters/nested

modinfo kvm_intel | grep -i nested
