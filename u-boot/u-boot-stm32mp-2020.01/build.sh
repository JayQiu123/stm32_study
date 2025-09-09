#!/bin/bash
SCRIPT_PATH=$(cd $(dirname $0) && pwd)
IMAGE_PATH=$SCRIPT_PATH/../../image


make distclean
make stm32mp15_atk_trusted_defconfig
make DEVICE_TREE=stm32mp157d-atk all -j32

cp u-boot.stm32 $IMAGE_PATH
