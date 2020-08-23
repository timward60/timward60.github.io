---
layout: post
title: Creating and Formatting Virtual Machine Images
date: 2008-07-31 07:02:00.000000000 -07:00
categories:
- Virtualisation
tags:
- mkfs
- QEMU
- qemu-img
- RAW
- Virtual Machine Images
permalink: "/creating-and-formatting-virtual-machine-images/"
---
As part of my honours project I wanted the ability to create and format virtual machine disk images as required. My honours project is using [QEMU](http://bellard.org/qemu/) RAW file format and VMWare's VMDK format as this stage but I have only implemented the RAW file format at this stage for my project.  

The whole point of this creation is to dynamically create virtual machine disk images of specified sizes, then formatted to a specified file system, allow the copying of files from the host OS to the virtual machine disk, and then finally then used by the virtual machine monitor to be mounted at run-time.  

Normally the image creation is used without formatting the image from host OS but rather the guest OS when installing an operating system. However in this case, the virtual machine disk needs to be prepared before the virtual machine is ever run.  

# Creating a Virtual Machine Disk (RAW)
Creating VMD in RAW format is made simple with QEMU as it provides a command called '[qemu-img](http://bellard.org/qemu/qemu-doc.html#SEC19)' which allows the creation of images for QEMU. 
`qemu-img create -f <file_format> <image_name> <image_size>`. E.g. `qemu-img create -f raw image.img 5G` will create a RAW virtual machine disk called image.img that is 5 gigabytes in size.  

In PERL this can be accomplished using the following code segment.  
```perl
# Create process for image creation
$pid = fork;
if($pid == 0){
  # Create VMD
  exec("qemu-img create -f raw $filename $size");
  exit 0;
}
elsif($pid > 0){
  # Block parent until creation is complete
  wait;
}
```

# Formatting the Virtual Machine Disk (RAW)
Once the VMD is created it can be formatted using one of the file system commands. The approach I use here is a bit naive and simplified, e.g. it does not actually create a VMD with partition table information.  

The command '[mkfs](http://linux.die.net/man/8/mkfs)' allows the formatting of devices and files to a certain file system. `mkfs -t <file_system_type>`. E.g. `mkfs -t ext3 image.img` will format the VMD image.img to the ext3 file system.  

In PERL this can be accomplished using the following code segment. It should be noted the command above used in the script is piped into by the 'yes' command. This is because the 'mkfs' command usually prompts the user.  
```perl
$pid = fork;
if($pid == 0){
  exec("yes | mkfs -t $filesystem $location_filename");
  exit 0;
}
elsif($pid > 0){
  wait;
}
```
