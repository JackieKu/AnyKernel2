# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() {
kernel.string=Mi 5 Stock Kernel V8.2.2.0
do.devicecheck=1
do.modules=1
do.cleanup=1
do.cleanuponabort=0
device.name1=Gemini
device.name2=gemini
device.name3=MI5
device.name4=Mi5
device.name5=mi5
} # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;


## AnyKernel permissions
# set permissions for included ramdisk files
chmod -R 755 $ramdisk

## AnyKernel install
dump_boot;

# begin ramdisk changes

mount -o rw,remount -t auto /system
ln -s /system/lib/modules/qca_cld/qca_cld_wlan.ko /system/lib/modules/wlan.ko
mount -o ro,remount -t auto /system

# init.rc
backup_file init.rc
append_file init.rc "load-modules-AK" load-modules

# end ramdisk changes

write_boot;

## end install

