apt update
apt install ssh

systemctl enable sshd
systemctl start sshd

sudo apt install isc-dhcp-server
sudo systemctl disable isc-dhcp-server.service