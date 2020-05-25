#!/bin/bash
set -x
# wait until vult is done with its own update
sleep 15
apt-get update
apt-get install -y build-essential linux-source bc kmod cpio flex cpio libncurses5-dev binutils libelf-dev libssl-dev

mkdir /opt/linux
cd /opt/linux
curl  https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.19.124.tar.xz --output linux-4.19.124.tar.xz
tar xaf  linux-4.19.124.tar.xz
cd linux-4.19.124/
cp /boot/config-4.19.0-8-amd64 .config
yes "" | make oldconfig
sed -i 's/^CONFIG_SYSTEM_TRUSTED_KEYS.*/CONFIG_SYSTEM_TRUSTED_KEYS=""/' .config
# time make -j`nproc` bindeb-pkg
# dpkg -i ../linux-image-4.19.124_4.19.124-1_amd64.deb

