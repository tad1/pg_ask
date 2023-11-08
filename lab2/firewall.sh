#!/bin/bash
INT_IF=enp0s8
EXT_IF=enp0s3
HOST_IP=XXX.XXX.XXX.XXX

echo "Tadeusz Brzeski"

# flush 
iptables -F
iptables -X
# iptables -F -t nat
# iptables -X -t nat
# iptables -F -t filter
# iptables -X -t filter

iptables -P FORWARD ACCEPT
iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT

iptables -A INPUT -i ${INT_IF} -j ACCEPT
iptables -A INPUT -i ${EXT_IF} -j ACCEPT
# allow responses
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT


# NAT
iptables -A FORWARD -i ${INT_IF} -s 10.0.0.0/24 -d 0/0 -j ACCEPT
iptables -A FORWARD -i ${EXT_IF} -s 0/0 -d 10.0.0.0/24 -j ACCEPT
iptables -t nat -A POSTROUTING -s 10.0.0.0/24 -d 0/0 -j MASQUERADE


# port forwarding
iptables -A PREROUTING -t nat -i ${EXT_IF} -p tcp -d ${HOST_IP} --dport 1234 -j DNAT --to-destination 10.0.0.2:22
iptables -A PREROUTING -t nat -i ${INT_IF} -p tcp -d 10.0.0.1 --dport 1234 -j DNAT --to-destination 10.0.0.2:22

iptables -A FORWARD -i ${INT_IF} -o ${EXT_IF} -j ACCEPT
