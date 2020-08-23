---
layout: post
title: Grid Virtual Appliance (GVA)
date: 2008-09-04 08:55:00.000000000 -07:00
categories:
- Honours Project
tags:
- Grid Virtual Appliance
- Grid Virtual Appliance Daemon
- GVA
- GVAD
- Honours Project
- Virtual Appliances
- Virtual Machines
permalink: "/grid-virtual-appliance-gva/"
---
As previously mentioned in my blog, I talked about virtual machines as work units. One such example is a Grid Virtual Appliance. Like virtual appliances, a GVA represents an application that is contained within a virtual machine and is distributed as an entire system rather than a separate application. The advantage of such construction is that the application is guranteed to execute within in its own tailored environment and requires little or no interaction from the user in setting up.  

In an attempt to standardise virtual appliances, major vendors such as Citrix and VMWare are pushing forward an open virtualisation [format](http://www.vmware.com/appliances/learn/ovf.html) for the storing of virtual appliances. This promotes the separation of virtual machines from the execution platform (virtual machine monitor) and allows the easy deployment and portability of virtual appliances.  

# Grid Virtual Appliance
Grid Virtual Appliances (GVA) differ from traditional Virtual Appliances as they are an non-interactive sequential execution of a virtual machine. A GVA is often instantiated multiple times in parallel across a computing grid.  

![GVA.png]({{ site.baseurl }}/assets/GVA.png)

A GVA is made up of several components. The first component is the operating system. This operating system needs to configured with the Grid Virtual Appliance Daemon (GVAD) as detailed below. The GVAD is used for launching scripts passed to the virtual machine. Other components as generated at run-time include the application, applications data, and the output of the application. Each of these components are separated into different virtual machine disk images as to help lower the requirements of copying large files. The images containing the application, application data, and application output can be combined if required.  

The GVA is packaged the same way as a Open Virtual Appliance (OVA) and contains an Open Virtualisation Format (OVF) configuration file. This ensures that a GVA can be executed in the same manner as a OVA.  

# Grid Virtual Appliance Daemon
The Grid Virtual Appliance Daemon is a daemon / service that is run in the guest operating system of the virtual appliance. It's task is to launch scripts passed to the virtual machine giving control of the virtual appliance from an external entity. In the case of GVA's this is the node of the grid executing the virtual machine monitor and virtual machine (job).  

![gvad.jpg]({{ site.baseurl }}/assets/gvad.jpg)

When the GVA first starts, the GVAD service is launched within the guest operating system. This has root access and also gives any scripts launched the same permissions. This is acceptable because the GVA is a self-contained environment and is ideally isolated from the host operating system or grid node/resource*. It should be noted this privelege level means that any scripts could accidentally or maliciosuly modify the instance of the base image, however at this stage of the project the base image is unique to that instance of the virtual appliance. Methods such as using checkpointing could protect the base image from any damage.  

Once the GVAD is launched it mounts the application virtual machine disk image to its filesystem. This application image contains the application as well as a script-bin directory where waiting scripts are contained. The GVAD then repeatably polls this script-bin directory for any executable scripts.  

A found script is then moved to a temporary directory and is then executed. Once it has finished executing it is removed. This process continues for each script found within the script-bin directory.  

The GVAD provides an easy method of communicating and controlling the virtual appliance externally. Other approaches taken with similar projects include using the auto-run functionality of CD-ROM's by storing scripts within the CD-ROM[1]. Isolation is not guaranteed and is highly dependent on the virtual machine monitor's security and implementation, [more information](http://www.symantec.com/avcenter/reference/Virtual_Machine_Threats.pdf).

References:
1. Krsul, I., et al. VMPlants: Providing and Managing Virtual Machine Execution Environments for Grid Computing. in SC '04: Proceedings of the 2004 ACM/IEEE conference on Supercomputing. 2004: IEEE Computer Society.
