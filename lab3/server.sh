# 0. clear
ip addr del 10.0.0.1 dev enp0s3
systemctl stop sshd
apt remove sshd

# 1. copy configs
cp ~/dhcpd.conf /etc/default/isc=dhcp-server/

# 2. enable dhcp
systemctl enable isc-dhcp-server.service
systemctl start isc-dhcp-server.service
