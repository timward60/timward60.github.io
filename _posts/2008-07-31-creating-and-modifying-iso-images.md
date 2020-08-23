---
layout: post
title: Creating and Modifying ISO Images
date: 2008-07-31 07:02:00.000000000 -07:00
categories:
- Misc
tags:
- growisofs
- ISO
- mkisofs
permalink: "/creating-and-modifying-iso-images/"
---
For my honours project I needed the ability to create ISO images on the fly and push files stored on the host OS to the ISO image. This ISO image was then passed to the virtual machine for reading files into the guest OS.  

To accomplish I wrote a PERL script in which I created a ISOVirtualMachineDisk class which inherits from my previous VirtualMachineDisk abstract class. The class contains three points of interest; the creation of empty ISO images, the copying of files to the ISO image, and mounting ISO images. If you want you can use the Linux commands manually to create the ISO image.  

# Creation of Empty ISO Images
Following the interface of my abstract class, VirtualMachineDisk, I wanted the user to be able to define and create an empty image. Unfortunately, there are no obvious methods for creating an empty ISO image. The linux command 'mkisofs' (Alias for '[genisoimage](http://linux.die.net/man/1/genisoimage)' in Ubuntu) provides functionality for creating ISO images but provides no direct option for creating empty ISO images and always expects file parametres to be passed to it. This means that I needed to find a workaround to use this command, and such used the '.' option as a parameter. To ensure that the current directory was empty I used the PERL module "FILE::Temp" to create a temporary directory.  

The syntax for using the mkisofs command for creating an empty ISO image is `mkisofs -o <image_name> .` assuming you are currently in an empty directory. E.g. `mkisofs -o test.iso .` will create an empty ISO image called test.iso.

The following PERL code segment shows how this can also be accomplished. I also use the PERL module "Cwd 'abs_path'" for determining the absolute path of a filename supplied by the user.
```perl
sub Create
{
  my $self;
  my $filename;
  my $pid;
  my $dir;

  # Get function parameters
  $self = shift;
  $filename = shift;

  # Modify image filename parameter to retrieve absolute path
  $filename = abs_path($filename);

  # Create a new process for handling the creating of the image
  $pid = fork;
  if($pid == 0){
    # Create empty temp directory
    $dir = tempdir(CLEANUP => 1);

    # Change directory to empty temp directory
    chdir $dir;

    # Use makeisofs to output empty directory to new ISO image
    exec("mkisofs -o $filename .");

    # Close child process
    exit 0;
  }
  elsif($pid > 0){
    # Block parent to wait for creation of image
    wait;
   }
   
   # Set VMD information
   $self->{"size"} = $size;
   $self->{"location_filename"} = $filename;
}
```

# Copying Files to an ISO Image
Once an image has been created you can now copy files to the image using the Linux command '[growisofs](http://www.linuxcommand.org/man_pages/growisofs1.html)'. Because you may want to copy files at a later point you make use of the merging session option of growisofs. When a file is copied to the ISO image it automatically places it into the root directory of the ISO image, however if you specify the '-graft-points' option you can specify in what directory on the ISO image the file should be contained and/or the filename it should be renamed to.  

The syntax for copying a file to an already created ISO image is `growisofs -M <image_name> -graft-points <dst>=<src>`. E.g. `growisofs -M test.iso -graft-points /folder/new.txt=old.txt` will copy the file old.txt to the test.iso ISO image and place it under the directory folder and rename it to new.txt.  

The following PERL code segment shows how this can also be accomplished.
```perl
sub CopyTo
{
  my $self;
  my $source;
  my $destination;

  # Get function parameters
  $self = shift;
  $source = shift;
  $destination = shift;

  # Get iso image location
  $location_filename = $self->{"location_filename"};

  # Determine if VMD is mounted.
  if($self->{"is_mounted"} == 0 && $self->{"is_in_use"} == 0){
    # Copy files to VMD
    system("growisofs -M $location_filename -graft-points $destination=$source");
  }
}
```

# Mounting ISO Images
Just in case necessary, the command to mount the ISO image is as follows `mount -t iso9660 -o loop <image_name> <mount_point>`. E.g. `mount -t iso9660 -o loop test.iso /mnt/cd` will mount test.iso ISO image to the directory /mnt/cd
