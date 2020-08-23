---
layout: post
title: Virtual Machines as Work Units Prototype
date: 2008-09-02 04:19:00.000000000 -07:00
categories:
- Honours Project
tags:
- QEMU
- Virtual Machines
- Work Unit
permalink: "/virtual-machines-as-work-units-prototype/"
---
About three months ago I created a quick prototype to demonstrate virtual machines as work units. It was designed with a specific virtual machine monitor and base image. Applications were reduced to a single executable file, single data file, and single output file. All this content was stored within a single virtual machine disk image including the operating system.  

Launching the application is controlled by a script generated during the creation of the virtual machine work unit. This is called then referenced directly by the virtual machine init process when the virtual machine is booted.  

The creator takes four parameters:
* The location of the virtual machine disk image.
* The location of the application.
* The location of the input.
* The location to place the output.

The creator assumes the following about the guest operating system running within the virtual machine.   

The home directory within the guest virtual machine is located at /home/auto/.
* Within the home directory is where the application, data, and output will be contained.
* That the virtual machine disk image will automatically launch the script located at /home/auto/autorun.

The creator firstly creates the launching script for the application by simply using a template that replaces application instance tokens with the specific applications requirements.  

The virtual machine disk image is then mounted locally on filesystem.
```bash
if(not -d "$g_mount_location"){
  mkdir $g_mount_location;<br />
}
$image_location = $config{"image_location"};
`mount -t ext3 -o loop,offset=32256 $image_location $g_mount_location`;
```

The application, then the data, and then finally the autorun script are copied in to the virtual machine disk image through the mount point.  

In this prototype we make use exclusively of the QEMU virtual machine emulator. This is used to launch the virtual machine. Once the application terminates within the virtual machine, the script tells the guest operating system to reboot which in turn kills the QEMU process after successfully shutting down. This is achieved by using the "-no-reboot" flag with QEMU.  

```bash
# run qemu
$image_location = $config{"image_location"};
`qemu -hda $image_location -no-reboot`;
```

The virtual machine disk image is then mounted and the output is retrieved and copied to the output destination as specified by the user.

The complete perl script can be found [here]({{ site.baseurl }}/assets/install_run_app.pl).
