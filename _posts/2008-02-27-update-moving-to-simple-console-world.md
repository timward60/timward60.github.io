---
layout: post
title: 'Update: Moving to Simple Console World'
date: 2008-02-27 07:14:00.000000000 -08:00
categories:
- Virtualisation
tags:
- Gentoo
- Installation
- Operating Systems
- Virtual Machines
- Virtualisation
- VMWare
permalink: "/update-moving-to-simple-console-world/"
---
I finally used some spare time to get my console move back on track. My Gentoo installation has finally been achieved and it looks like there are no problems. However, this is not on the same machine that I attempted the installation on before, it is a virtual machine running on top of my Windows Vista operating system.  

![gentoo_vmware.jpg]({{ site.baseurl }}/assets/gentoo_vmware.jpg)  
The guest OS, Gentoo, is running on a virtual machine on the host OS, Windows Vista.  

I am running VMWare Server on top as the virtual machine monitor, running a minimum system using a single core and 256mb of memory (not-swapped). I needed to follow some [additional guides](http://gentoo-wiki.com/HOWTO_Install_Gentoo_on_VMware_in_Windows_NT/2K/XP) for compiling the required kernel for VMWare based machines and after this I was required to [follow a few steps](http://gentoovm.blogspot.com/2006/03/install-vmware-tools-in-gentoo-vm.html) to get the VMWare tools working.  

I felt it was time to return back to virtualisation and given that I will be running console applications only, virtualisation suits me perfectly given that the host machine is not very high specification (Laptop: Dual Core 1.6, 1524MB RAM, On-board GPU).  

I can now move to installing my console applications and playing around with them and I will also be planning to setup a Linux server for home use.  
