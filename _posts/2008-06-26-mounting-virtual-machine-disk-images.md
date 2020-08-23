---
layout: post
title: Mounting Virtual Machine Disk Images
date: 2008-06-26 08:44:00.000000000 -07:00
categories:
- Virtualisation
tags:
- QEMU
- RAW
- Virtual Machine Images
- Virtualisation
- VMDK
- VMWare
permalink: "/mounting-virtual-machine-disk-images/"
---
As the popularity of virtual machines increases so does the amount of data that we store in them. Often we may generate data within virtual machines environments as a result of applications running within them. Due to this many virtual machine monitor vendors provides methods for transferring data between a running virtual machine (Guest OS) and the host machine (Host OS). This is the most common method and normally the most useful for frequent virtual machine users.  

However, for scripting this may pose a problem. Most virtual machine vendors also provides methods for mounting virtual machine disk images. In this post I will address two virtual machine formats and how they can be mounted using vendor tools as if they were part of the filesystem. 

# Mounting VMD Images (RAW)
The first format, RAW, is associated with the QEMU Emulator that allows the running of virtual machine monitors. QEMU does not provide a direct tool for mounting this format, however because the format is raw (e.g the virtual disk reads exactly as a normal hard disk) it can be mounted to the host operating system using a loopback device.  

The Linux 'mount' command can be used. 'mount -t ext2 -o loop &lt;image_name&gt;&lt;mount_point&gt;'. E.g. `mount -t ext2 -o loop image.img /mnt/vmd` will mount the image image.img to the mount point /mnt/vmd. 

In PERL this can be achieved using the following code segment:
```perl
# Create mount point directory if not already created
if(not -d "$mount_point"){
  mkdir $mount_point;
}

# Mount disk
system("mount -t ext2 -o loop $location_filename $mount_point");
```

# Mounting VMD Images (VMDK)
The second format, VMDK, is a format used by VMWare in all there products. VMWare is pushing this as the standard format for all virtual machine disks, however other formats such as Microsoft's VHD are also being pushed for being standard formats. VMWare provides tools bundled with there VMWare Server GSX. The tool is in the form of a perl script that the user can run to mount a given virtual machine. Unfortunately there are some issues with this method. The first issues is that there are some issues with the script on certain kernel versions which prevent the VMD unmounting. The VMWare implementation requires a separate running process to be running while the VMD is mounted and sometimes these processes are not terminated correctly when the VMWare mounting program is exited.  

Using the script provided by VMWare we can see that virtual machine disk images are mounted by using the command `vmware-loop`. [HoneyNet](http://www.honeynet.org.cn/) in their [script](http://honeybow.mwcollect.org/wiki/MwFetcher) used for virtual machine disk malware scanning is another example of how to mount VMDK images.  

Notable sections include creating the network block device used by vmware-loop ...  

This loads the network block device module and creates a node to be used by vmware-loop.
```bash
modprobe nbd
mknod /dev/nb0 b 43 0
chmod 0600 /dev/nb0
```
... the launching of vmware-loop and mounting ...  
This then initiates the vmware-loop process for looping the virtual machine disk file through the network block device. The network block device is then mounted to the mount point.
```bash
vmware-loop "$vmk_dir/$vmdk_file" 1 /dev/nb0 2>&1 > /dev/null & echo $! > "$home_dir/PID"
sleep 2
mount -o "$option" /dev/nb0 "$mount_dir" > /dev/null
```
... and the unmounting of the VMD and the termination of vmware-loop ...  

This unmounts the virtual machine disk and then forcefully kills the vmware-loop created processes.  
```bash
umount "$mount_dir" 2&gt;&amp;1 &gt; /dev/null
kill -9 `ps -ef | grep -m 1 vmware-loop | awk '{ print $2 }'` 2>&1 > /dev/null &
rm "$home_dir/PID"</p>
```
