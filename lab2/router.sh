#netplan
INN_IF=enp0s3
OUT_IF=enp0s8

netplan set ethernets.${INN_IF}.addresses=[192.168.1.1/24]
netplan set ethernets.${INN_IF}.dhcp4=false
