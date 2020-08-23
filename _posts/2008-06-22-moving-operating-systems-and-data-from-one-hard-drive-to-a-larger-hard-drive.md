---
layout: post
title: Moving Operating Systems and Data from One Hard-Drive to a Larger Hard-Drive.
date: 2008-06-22 12:24:00.000000000 -07:00
categories:
- Misc
tags:
- BartPE
- Grub
- Hard-Drive
permalink: "/moving-operating-systems-and-data-from-one-hard-drive-to-a-larger-hard-drive/"
---
Recently I purchased a larger hard-drive for my laptop. In purchasing this I definately didn't want to have to rebuild my system from scratch and such looked into some approaches for moving my multiple operating systems and my data to the new drive without having to rebuild either operating systems from scratch. My old hard-drive contained four partitions, first partition was a recovery partition, the second partition was my main partition containing Windows Vista, the third partition was linux swap space for my fourth partition which contained Ubuntu. Grub was located on this final partition, however the boot record was contained in the first partition.  

To achieve this I removed my old hard-drive and installed the new hard-drive. I connected my old hard-drive through USB using a portable hard-drive casing. This allowed me to have both drives connected simulataneously.  

Using a live-cd boot distro known as [BartPE](http://www.nu2.nu/pebuilder/) which is cut down version of Windows XP with tools that allow the recovery of systems. Using the disk tools I copied the contents from my old hard-drive to the new hard-drive. The disk tools allowed me to resize the partitions to take into account the larger hard-drive.  

Once the copy was successful I rebooted my computer. Unfortunately Grub was no longer working and would freeze upon entry. I needed access to my window partition for other reasons, so I inserted the my Windows Vista disk and ran system utilities. This picked up that the boot record no longer pointed to the Windows Bootloader and such repaired the issue. This fixed my Windows booting up, however Grub was now bypassed and there was no way to boot in to Ubuntu.  

To restore Grub to its former glory I loaded the Ubuntu Live-CD and ran Grub from the [command line](http://ubuntuforums.org/showthread.php?t=224351). I used the command located below. This set the root of my boot loader location, and set it up to load at boot time.  

Once this was completed Grub worked as before and I now had access to my all my operating systems and data.  
```bash
% grub
> root (hd0,3)
> setup(hd0,3)
> quit
% reboot
```
