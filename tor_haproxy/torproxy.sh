#!/bin/ash
num_servers=4
cat <<EOF > /tmp/haproxy.conf
defaults
    mode tcp
    timeout connect 5000
    timeout client 50000
    timeout server 50000
listen socks5
    bind :9050
    mode tcp
    balance roundrobin
EOF

for i in $(seq 0 $num_servers);
do

tor --RunasDaemon 1 --SOCKSPort 127.0.0.1:$((9100+$i)) --DataDirectory /tmp/tor$i
echo "server server$i 127.0.0.1:$((9100+$i))" >> /tmp/haproxy.conf
done

haproxy -D -f /tmp/haproxy.conf
