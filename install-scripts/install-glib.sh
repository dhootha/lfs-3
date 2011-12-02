#!/bin/bash

#################################################################
#                                                               #
# Author:        Joe Jiang                                      #
# Lable:         install-glib.sh                                #
# Information:   installtheGlibforLFM                           #
# CreateDate:    2011-09-22                                     #
# ModifyDate:    2011-12-02                                     #
# Version:       v1.2                                           #
#                                                               #
#################################################################
app='glib'
ver='2.28.8'

# 出错代码
prepare_err_1="1"
prepare_err_2="2"
patch_err_1="10"
patch_err_2="11"
make_err="20"
install_err="21"

# 初始化变量
[ "$src" == "" ] && src='../sources'
[ "$build" == "" ] && build='../build'
[ "$1" != "" ] && ver=$1

# 准备源码
tar -xvf ${src}/${app}-${ver}.tar* -C ${build} 
cd ${build}/${app}-${ver} || \
	exit $prepare_err_1 


# 生成Makefile 
PCRE_LIBS="-L/usr/lib -lpcre" PCRE_CFLAGS="-I/usr/include" \
./configure --prefix=/usr --sysconfdir=/etc --with-pcre=system || \
	exit $prepare_err_2

# 编译
make || exit $make_err

# 安装
make install || $install_err

# 清理文件
cd ..
rm ${app}-${ver} -rf 
