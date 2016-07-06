# INTRO:

This is a user demo environment for beginners with VPP

It walks a user through
- each of the commands,
- the expected output,
- gives a file of the commands used to try themselves

# GETTING STARTED
- clone the repo
- modify env.sh if needed and ```source ./env.sh```
- by default the VM uses 2 x CPUs and 4G RAM
- ```vagrant up```
- ... run the demo

# RUNNING DEMOs
- From the Host, where you ran ```vagrant up``` run ```./run <demoname>```

```./run demo1```

# DEMOs

## demo1 - directly connected routing
- Creates two network namespaces c1, c2
- A gateway interface for each on VPP
- Routes due to directly connected routes inserted into default FIB

## demo2 - bridging

