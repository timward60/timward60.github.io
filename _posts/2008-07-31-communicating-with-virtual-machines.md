---
layout: post
title: Communicating with Virtual Machines
date: 2008-07-31 07:05:00.000000000 -07:00
categories:
- Virtualisation
tags:
- Communication
- ISO
- Virtual Machine Images
- Virtual Machines
- Virtualisation
permalink: "/communicating-with-virtual-machines/"
---
Virtual Machines are often used by directly logging into them either using a VNC or RDP protocols. However in the case of using Virtual Machines in grid computing, we need an automated way of communicating with virtual machines without requiring the user to interact manually with each machine.  

The extent to which a virtual machine can be automatically interacted with is usually dependent on the virtual machine monitor that is being used to execute the virtual machine.  

VMWare provides a [toolkit](http://www.vmware.com/support/ws55/doc/new_guest_tools_ws.html) that can be installed within the virtual machine to allow the host operating system to interact with the virtual machine. This includes providing cut and past functionality between the guest and the host, management utilities such as virtual machine status that can be used by the virtual machine monitor in scheduling, and a daemon for monitoring and launching processes.  

Functionality of such specific virtual machine monitor to virtual machine interfaces can be extremely powerful and simple, however in the case of using virtual machines on an independent host means that we can not gurantee that this functionality will be available for interaction with the virtual machine.  

Fortunately there are some more traditional methods of interacting with virtual machines. Approaches include using the cdrom autorun functionality for launching commands [1], creating your own service/daemon for the guest operating system using network connectivity, cdrom images, floppy disk images, and/or hard disk images to pass data in and out of the virtual machine.  

The approaches above may be static or dynamic in nature. That is either the virtual machine needs to be stopped to update or retrieve data, or the virtual machine can be executing while updating or retrieving data respectively.  

In the case of my project, I need some method of passing a launching script to launch the application contained within the virtual machine. I also need a method of providing parameters to each instance of the virtual machine launched. The way my virtual machine was structured is that it contained a base image of the guest operating system, another hard disk image that contained the application and input data, and finally a hard disk image used for the applications output. I wanted to avoid touching the base image as its file size is large and allowed me to avoid copying this large image for each instance of virtual machine launched.  

To launch scripts within the virtual machine I created a daemon that would poll a directory and launch any executables found within that directory. The script directory would be contained within the application virtual machine disk which was initially mounted by the daemon.  

Passing parameters for each instance was achieved by creating a ISO image that contained a text file representing the parameters. This was launched with each instance of virtual machine, and the application could just read the cd-rom for the parameters. The actual method of the application reading the parameters can be defined within the launching script for example cat'ing the parameter text file to the applications commmand-line arguments.  

Retrieving data from the application was as simple as copying out the output virtual machine disk that was created.  

This provided a static method of communicating with the virtual machines as needed by my project.  

References:
* [1] Krsul, I., et al. VMPlants: Providing and Managing Virtual Machine Execution Environments for Grid Computing. in SC '04: Proceedings of the 2004 ACM/IEEE conference on Supercomputing. 2004: IEEE Computer Society.
