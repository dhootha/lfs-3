#!/bin/bash

#################################################################
#                                                               #
# Author:        Joe Jiang                                      #
# Lable:         install-pcre.sh                                #
# Information:   installPCREforLFM                              #
# CreateDate:    2011-09-22                                     #
# ModifyDate:    2011-12-02                                     #
# Version:       v1.2                                           #
#                                                               #
#################################################################
app='pcre'
ver='8.12'

# 出错代码
prepare_err_1="1"
prepare_err_2="2"
patch_err_1="10"
patch_err_2="11"
make_err="20"
check_err="30"
install_err="21"

# 初始化变量
[ "$src" == "" ] && src='../sources'
[ "$build" == "" ] && build='../build'
[ "$1" != "" ] && ver=$1

# 准备源码
tar -xvf ${src}/${app}-${ver}.tar* -C ${build} 
cd ${build}/${app}-${ver} || \
	exit prepare_err_1

./configure --prefix=/usr \
            --docdir=/usr/share/doc/pcre-8.12 \
            --enable-utf8 \
            --enable-unicode-properties \
            --enable-pcregrep-libz \
            --enable-pcregrep-libbz2 || \
			exit prepare_err_2

# 编译安装
make || exit $make_err
make check || exit $make_err
make install || exit $install_err

mv -v /usr/lib/libpcre.so.* /lib/
ln -v -sf ../../lib/libpcre.so.0 /usr/lib/libpcre.so

# 清理文件
cd ..
rm -rf ${app}-${ver}
