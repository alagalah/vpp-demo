#To show interfaces:
sudo vppctl show inter

#Lets examine our workloads c1 and c2: 
sudo ip netns exec c1 ip -o a
sudo ip netns exec c2 ip -o a

#add interfaces, we add the host-side of the veth link pair.
sudo ip link
sudo vppctl create host-interface name link1
sudo vppctl create host-interface name link2



#Change the links state to up, and add ip addresses using the following:
sudo vppctl set interface state host-link1 up
sudo vppctl set interface state host-link2 up

#Add IP addresses for the other end of each veth link:
sudo vppctl set interface ip address host-link1 172.16.1.1/24
sudo vppctl set interface ip address host-link2 172.16.2.1/24

#see the L3 table, or FIB by doing:
sudo vppctl show ip fib

#see some pings:
sudo ip netns exec c1 ping -c3 172.16.2.2
sudo ip netns exec c2 ping -c3 172.16.1.2

#restart this demo
sudo /vagrant/netns.sh




