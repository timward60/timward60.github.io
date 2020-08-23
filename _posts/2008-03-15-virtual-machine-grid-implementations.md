---
layout: post
title: Virtual Machine Grid Implementations
date: 2008-03-15 03:30:00.000000000 -07:00
categories:
- Honours Project
tags:
- Grid Computing
- Implementation
- Virtual Machines
- Virtualisation
permalink: "/virtual-machine-grid-implementations/"
---
Virtual machines are becoming popular in grid computing as they provide a way to abstract the grid resources and allow grid applications to be run without worrying about the underlying platform of the resource.  

Virtual machines in grid computing can be implemented in different ways. Depending on the purpose and intention of the grid, each implementation can have its benefits and drawbacks.  

# Virtual Machines on Grid Infrastructure
![VM+and+Grid+Implementation+-+Type+I.png]({{ site.baseurl }}/assets/VM+and+Grid+Implementation+-+Type+I.png)  
Virtual Machines run on Grid Infrastructure      

One approach to implementing virtual machines is a method of using infrastructure already implemented for supporting grid computing. This involves the virtual machine being executed using the grid middleware. Virtual machines can be processes that are executed like normal applications. Virtual machines are not only restricted to system virtual machines but can also extend to process virtual machines such as Java Virtual Machine.

# Virtual Machines as Grid Infrastructure
![VM+and+Grid+Implementation+-+Type+II.png]({{ site.baseurl }}/assets/VM+and+Grid+Implementation+-+Type+II.png)  
Virtual Machines contain Grid Infrastructure

Another method that allows Grids to be setup and deployed easily. Users can download Virtual Machine images which can then be executed using popular virtual machine monitors / emulators. Grid middleware is installed and configured within these virtual machines, and users can submit jobs within the virtual machine.  

Virtual machines are interconnected using virtual networks. Machines are added and removed from the Grid when users start and terminate there virtual machines.  

One such example of this virtual machine grid computing implementation is (Grid Appliances)[http://www.grid-appliance.org/]. Grid Appliances allows the user to download a virtual machine image for their given virtual machine monitor / emulator, and as of now it supports VMWare, though releases for KVM and QEMU are about to be released.  

Grid Appliances provides the user with a Linux(Debian) environment and uses Condor to submit and execute grid applications across the grid.  

# Virtual Machine as Grid
![VM+and+Grid+Implementation+-+Type+III.png]({{ site.baseurl }}/assets/VM+and+Grid+Implementation+-+Type+III.png)  
Virtual Machine appears to be single machine, but is executed across the Grid.

Finally another method of virtual machine grid computing is a single virtual machine is run over the grid. The user has access to this virtual machine and it's interface is like any other computer, though when applications are executed on the virtual machine they are actually executed across the grid.  
