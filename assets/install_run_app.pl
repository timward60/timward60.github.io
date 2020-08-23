#!/usr/bin/perl

# get parameter(s)
$config{"image_location"} = shift;
$config{"app_location"} = shift;
$config{"input_location"} = shift;
$config{"output_location"} = shift;

# globals
$g_mount_location = "/mnt/vmimage";
$g_app_image_location = "/home/auto";
$g_input_image_location = "/home/auto";
$g_autorun_image_location = "/home/auto/autorun";
$g_autorun_template_location = "grid_app_template.sh";
$g_autorun_location = "./grid_app.sh";
$g_output_image_location = "/home/auto/output";

# create autorun script for vm
$config{"app_location"} =~ m/(.*)\/(.*)/;
$app = $g_app_image_location . "/" . $2;
$config{"input_location"} =~ m/(.*)\/(.*)/;
$input = $g_input_image_location . "/" . $2;
$output = $g_output_image_location;
open(INPUT, "$g_autorun_template_location") or die "Unable to locate autorun template file\n";
@file = <INPUT>;
open(OUTPUT, ">$g_autorun_location") or die "Unable to create autorun file\n";
foreach $line (@file){
	$line =~ s/{APP_LOCATION}/$app/g;
	$line =~ s/{INPUT_LOCATION}/$input/g;
	$line =~ s/{OUTPUT_LOCATION}/$output/g;
	print OUTPUT $line;
}
close(INPUT);
close(OUTPUT);

# mount image locally
if(not -d "$g_mount_location"){
	mkdir $g_mount_location;
}
$image_location = $config{"image_location"};
`mount -t ext3 -o loop,offset=32256 $image_location $g_mount_location`;

# copy application in
$app_location = $config{"app_location"};
$app_image_location = $g_mount_location . $g_app_image_location;
`cp \"$app_location\" $app_image_location`;

# copy input data in
$input_location = $config{"input_location"};
$input_image_location = $g_mount_location . $g_input_image_location;
`cp \"$input_location\" $input_image_location`;

# copy autorun
$autorun_image_location = $g_mount_location . $g_autorun_image_location;
`chmod +x $g_autorun_location`;
`mv "$g_autorun_location" $autorun_image_location`;

# unmount image
`umount $g_mount_location`;

# run qemu
$image_location = $config{"image_location"};
`qemu -hda $image_location -no-reboot`;

#remount image 
$image_location = $config{"image_location"};
`mount -t ext3 -o loop,offset=32256 $image_location $g_mount_location`;

#copy output
$output_location = $config{"output_location"};
$output_image_location = $g_mount_location . $g_output_image_location;
`cp "$output_image_location" "$output_location"`;

# unmount image
`umount $g_mount_location`;
rmdir $g_mount_location;