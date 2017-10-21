# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() {
kernel.string=Nexus 9 ZSWAP+NoFED
do.devicecheck=1
do.modules=0
do.cleanup=1
do.cleanuponabort=0
device.name1=flounder
device.name2=Nexus 9
device.name3=flounder_lte
device.name4=Nexus 9 LTE
device.name5=
} # end properties

# shell variables
block=/dev/block/platform/sdhci-tegra.3/by-name/LNX
is_slot_device=0;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
chmod -R 750 $ramdisk/*;
chown -R root:root $ramdisk/*;

## AnyKernel install
dump_boot;

# begin ramdisk changes

backup_file fstab.flounder
sed -i -r -e 's/forceencrypt=/encryptable=/g; s/,verify=[^, ]+//g; s/zramsize=[^, ]+/zramsize=133353300/;' fstab.flounder
cp fstab.flounder fstab.flounder64
#cp fstab.flounder /sdcard/fstab.flounder.ak2

#zswap_opts='zswap.enabled=1 zswap.compressor=lz4 zswap.max_pool_percent=60 zswap.zpool=z3fold'
patch_cmdline zswap.enabled=1
patch_cmdline zswap.compressor=lz4
patch_cmdline zswap.max_pool_percent=60
patch_cmdline zswap.zpool=z3fold
#cp "$cmdfile" /sdcard/cmdline-ak2

mount -o rw,remount -t auto /system
$bb cp -v -rLf /tmp/anykernel/system/* $root/system
mount -o ro,remount -t auto /system

# end ramdisk changes

write_boot;

## end install

