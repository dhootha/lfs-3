#!/bin/bash

#################################################################
#                                                               #
# Author:        Joe Jiang                                      #
# Lable:         install-readline.sh                            #
# Information:   installReadlineforLFM                          #
# CreateDate:    2011-09-22                                     #
# ModifyDate:    2011-12-02                                     #
# Version:       v1.2                                           #
#                                                               #
#################################################################
app='readline'
ver='6.2'

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
cd ${build}/${app}-${ver} || exit $prepare_err_1
sed -i '/MV.*old/d' Makefile.in
sed -i '/{OLDSUFF}/c:' support/shlib-install
patch -Np1 -i ../${src}/readline-6.2-fixes-1.patch || exit $patch_err_1

# 为编译做准备
./configure --prefix=/usr --libdir=/lib || exit $prepare_err_2

# 编译安装
make SHLIB_LIBS=-lncurses || exit $make_err
make install || exit $install_err

mv -v /lib/lib{readline,history}.a /usr/lib
rm -v /lib/lib{readline,history}.so
ln -sfv ../../lib/libreadline.so.6 /usr/lib/libreadline.so
ln -sfv ../../lib/libhistory.so.6 /usr/lib/libhistory.so

mkdir   -v       /usr/share/doc/readline-$ver
install -v -m644 doc/*.{ps,pdf,html,dvi} \
                 /usr/share/doc/readline-$ver


# 清理文件
cd ..
rm -rf ${app}-${ver}
