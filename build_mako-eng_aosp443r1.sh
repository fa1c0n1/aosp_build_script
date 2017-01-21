#!/bin/bash

### get current timestamp 
start_time=`date +%s`

######## first: build kernel #####################

# import gcc for cross-compile
export PATH=~/AOSP/4.4.3_r1/prebuilts/gcc/linux-x86/arm/arm-eabi-4.6/bin:$PATH

# export settings
export ARCH=arm
export SUBARCH=arm
export CROSS_COMPILE=arm-eabi-

# cd kernel directory
cd kernel/msm/

make mako_defconfig

# starting build
make -j8

# replace
#cp -avf ~/AOSP/4.4.3_r1/kernel/msm/arch/arm/boot/zImage ~/AOSP/4.4.3_r1/device/lge/mako-kernel/kernel 
#cp -avf ~/AOSP/4.4.3_r1/kernel/msm/arch/arm/boot/zImage ~/AOSP/4.4.3_r1/device/lge/mako-kernel/kernel 
cp -avf arch/arm/boot/zImage ../../device/lge/mako-kernel/kernel

# back to android directory
cd ../../

######## second: build Android #####################

# build-setting
. build/envsetup.sh

# build eng for Nexus4
lunch full_mako-eng

# set cache
export USE_CCACHE=1
prebuilts/misc/linux-x86/ccache/ccache -M 100G
export CCACHE_DIR=~/aosp_build_cache/.ccache

# start building
make -j8

# release the firmware
#scp out/target/product/mako/android-info.txt fa1c0n@falconOS:~/Firmware/Aosp/4.4.3_r1/mako-eng/
#scp out/target/product/mako/boot.img fa1c0n@falconOS:~/Firmware/Aosp/4.4.3_r1/mako-eng/
#scp out/target/product/mako/userdata.img fa1c0n@falconOS:~/Firmware/Aosp/4.4.3_r1/mako-eng/
#scp out/target/product/mako/recovery.img fa1c0n@falconOS:~/Firmware/Aosp/4.4.3_r1/mako-eng/
#scp out/target/product/mako/system.img fa1c0n@falconOS:~/Firmware/Aosp/4.4.3_r1/mako-eng/

cp -avf out/target/product/mako/android-info.txt ~/Firmware/Aosp/4.4.3_r1/mako-eng/
cp -avf out/target/product/mako/boot.img ~/Firmware/Aosp/4.4.3_r1/mako-eng/
cp -avf out/target/product/mako/userdata.img ~/Firmware/Aosp/4.4.3_r1/mako-eng/
cp -avf out/target/product/mako/recovery.img ~/Firmware/Aosp/4.4.3_r1/mako-eng/
cp -avf out/target/product/mako/system.img ~/Firmware/Aosp/4.4.3_r1/mako-eng/

# show spend time
echo "#################### finish #############################"

### get current timestamp 
end_time=`date +%s`

time_spend=$(expr ${end_time} - ${start_time}) 

hour_spend=$(expr ${time_spend} / 3600)
hour_remain=$(expr ${time_spend} % 3600)
min_spend=$(expr ${hour_remain} / 60)
min_remain=$(expr ${hour_remain} % 60)
sec_spend=$min_remain

echo "耗时：$hour_spend小时$min_spend分$sec_spend秒"
