#!/bin/bash
set -x
# wait until vult is done with its own update
sleep 15
apt-get update
apt-get install -y build-essential linux-source bc kmod cpio flex cpio libncurses5-dev \
    binutils libelf-dev libssl-dev cgroup-tools libseccomp-dev gettext gdb apt-file strace \
    libtool pkg-config autoconf autopoint git valgrind linux-perf auditd attr acl

echo 'deb http://deb.debian.org/debian/ sid main' > /etc/apt/sources.list.d/sid.list

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

# 5.6
cd /opt/linux
curl  https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.6.15.tar.xz --output linux-5.6.15.tar.xz
tar xaf linux-5.6.15.tar.xz
git clone git://git.kernel.org/pub/scm/utils/util-linux/util-linux.git
cd util-linux
# ./autogen.sh && ./configure && make
