#!/usr/bin/env bash

if [ $USER != "root" ] ; then
    #echo "Restarting script with sudo..."
    sudo $0 ${*}
    exit
fi

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

function pause {
    echo ""; echo ""
    read -n1 -r -p "Press space to continue..." key
    printf "\033c"
}

function instruction {

    echo ""
    echo -e "${RED}********************************************************************************${NC} \n"
    echo -e " ${RED}$1${NC}"
    echo -e " ${GREEN}$2${NC} \n"
    echo -e "${RED}********************************************************************************${NC} \n"
}

#Clear and set netns and veths
/vagrant/netns.sh

instruction "Welcome to demo1. This will show you some simple commands to connect two
linux netnamespaces to VPP and ping between them."
pause

instruction "To show interfaces" " sudo vppctl show inter"
vppctl show inter

pause

instruction "Lets examine our workloads c1 and c2" " sudo ip netns exec c1 ip -o a"
ip netns exec c1 ip -o a
instruction "" " sudo ip netns exec c2 ip -o a"
ip netns exec c2 ip -o a

pause

instruction "To add interfaces, we add the host-side of the veth link pair." " ip link"
ip link | grep link


instruction "The links we need to add are link1 and link2 so lets add them with" " sudo vppctl create host-interface name link1 \n sudo vppctl create host-interface name link2"
vppctl create host-interface name link1
vppctl create host-interface name link2
vppctl show inter

pause


instruction "Change the links state to up" " sudo vppctl set interface state host-link1 up \n sudo vppctl set interface state host-link2 up"
vppctl set interface state host-link1 up
vppctl set interface state host-link2 up
vppctl show inter

pause

instruction "Add IP addresses for the other end of each veth link" " sudo vppctl set interface ip address host-link1 172.16.1.1/24 \n sudo vppctl set interface ip address host-link2 172.16.2.1/24 \n show interface address"

vppctl set interface ip address host-link1 172.16.1.1/24
vppctl set interface ip address host-link2 172.16.2.1/24

pause

instruction "You can also see the L3 table, or FIB by doing" " sudo vppctl show ip fib"
vppctl show ip fib

pause

instruction "At long last you probably want to see some pings" " sudo ip netns exec c1 ping -c3 172.16.2.2"


ip netns exec c1 ping -c3 172.16.2.2

pause

instruction "" " sudo ip netns exec c2 ping -c3 172.16.1.2"
ip netns exec c2 ping -c3 172.16.1.2

pause

instruction "Thanks for doing demo1. To restart this demo and type these commands yourself" " vagrant ssh \n sudo /vagrant/netns.sh \n cat /vagrant/demo1.cmd"



