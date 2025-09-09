#!/bin/bash

SCRIPT_PATH=$(cd $(dirname $0) && pwd)
BUILD_PATH=$SCRIPT_PATH/../build
IMAGE_PATH=$SCRIPT_PATH/../../image
echo $SCRIPT_PATH
echo $BUILD_PATH
echo $IMAGE_PATH
# 清除编译文件
if [ -e "../build" ]; then
    rm ../build -rf
fi

make -f ../Makefile.sdk clean
make -f ../Makefile.sdk -j32 TFA_DEVICETREE=stm32mp157d-atk TF_A_CONFIG=trusted ELF_DEBUG_ENABLE='1' all
# make -f ../Makefile.sdk -j32 all

cd ${BUILD_PATH}/trusted

cp tf-a-stm32mp157d-atk-trusted.stm32 ${IMAGE_PATH}

cd $SCRIPT_PATH

make -f ../Makefile.sdk clean

make -j32 -f ../Makefile.sdk TFA_DEVICETREE=stm32mp157d-atk TF_A_CONFIG=serialboot ELF_DEBUG_ENABLE='1' all

cd ${BUILD_PATH}/serialboot

cp tf-a-stm32mp157d-atk-serialboot.stm32 ${IMAGE_PATH}