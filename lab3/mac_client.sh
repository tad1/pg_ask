# 0. set temporary address
sudo ip addr add 10.0.0.2/24 dev enp0s3
# 1. add own mac to config
MAC=$(cat /sys/class/net/enp0s3/address)
export MAC
echo "Your mac is: ${MAC}"
envsubst < dhcpd.conf > dhcpd.conf

# 2. scp the mac config to server
scp ./dhcpd.conf ask@10.0.0.1:~/dhcpd.conf

sudo ip addr del 10.0.0.2/24 dev enp0s3