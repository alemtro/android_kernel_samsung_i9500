#!/bin/bash
# kernel build script by somadsul

KERNEL_DIR=/home/ishanpatel_96/Downloads/GT-I9500/kernel
BUILD_USER="$USER"
TOOLCHAIN_DIR=/opt

# Toolchains

#Sabermod
#BUILD_CROSS_COMPILE=$TOOLCHAIN_DIR/sm-arm-eabi-5.0/bin/arm-eabi-
#BUILD_CROSS_COMPILE=$TOOLCHAIN_DIR/sm-arm-eabi-4.10-hrt/bin/arm-eabi-
#BUILD_CROSS_COMPILE=$TOOLCHAIN_DIR/arm-eabi-4.10-sm/bin/arm-eabi-
#BUILD_CROSS_COMPILE=$TOOLCHAIN_DIR/arm-eabi-4.9.1-sm/bin/arm-eabi-

#Linaro
BUILD_CROSS_COMPILE=$TOOLCHAIN_DIR/uber-4.9/bin/arm-eabi-
#BUILD_CROSS_COMPILE=$TOOLCHAIN_DIR/arm-eabi-4.9.1/bin/arm-gnueabi-
#BUILD_CROSS_COMPILE=$TOOLCHAIN_DIR/arm-eabi-4.8.3/bin/arm-gnueabi-

#Stock
#BUILD_CROSS_COMPILE=$TOOLCHAIN_DIR/arm-eabi-4.7/bin/arm-eabi-


BUILD_JOB_NUMBER=`grep processor /proc/cpuinfo|wc -l`
KERNEL_DEFCONFIG=ja3g_00_defconfig

BUILD_KERNEL()
{	
	echo ""
	echo "=============================================="
	echo "START: MAKE CLEAN"
	echo "=============================================="
	echo ""
	

	make clean


	echo ""
	echo "=============================================="
	echo "END: MAKE CLEAN"
	echo "=============================================="
	echo ""

	echo "CPU"
	echo "$BUILD_JOB_NUMBER"
	echo "BUILD USER"
	echo "$BUILD_USER"
	echo "TOOLCHAIN"
	echo "$BUILD_CROSS_COMPILE"
	
	
	echo ""
	echo "=============================================="
	echo "START: BUILD_KERNEL"
	echo "=============================================="
	echo ""
	
	export ARCH=arm
	export CROSS_COMPILE=$BUILD_CROSS_COMPILE
	export ENABLE_GRAPHITE=true 
	make $KERNEL_DEFCONFIG
	make -j$BUILD_JOB_NUMBER
	

	echo ""
	echo "================================="
	echo "END: BUILD_KERNEL"
	echo "================================="
	echo ""
}





# MAIN FUNCTION
rm -rf ./build.log
(
	START_TIME=`date +%s`
	BUILD_DATE=`date +%m-%d-%Y`
	BUILD_KERNEL


	END_TIME=`date +%s`

	let "ELAPSED_TIME=$END_TIME-$START_TIME"
	echo "Total compile time is $ELAPSED_TIME seconds"
) 2>&1	 | tee -a ./build.log

# Credits:
# Samsung
# google
# osm0sis
# cyanogenmod
# kylon 
