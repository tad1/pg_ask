# sudo ip addr add 10.0.0.1/24 dev enp0s3
cp ./server_netplan.yaml /etc/netplan/
sudo netplan apply