#!/bin/bash

#################################################################
#                                                               #
# Author:        JoeJiang                                       #
# Lable:         install-mpc.sh                                 #
# Information:   installtheMPCforLFM                            #
# CreateDate:    2011-09-22                                     #
# ModifyDate:    2011-09-22                                     #
# Version:       v1.0                                           #
#                                                               #
#################################################################
app='mpc'
ver='0.9'

# 出错代码
prepare_err_1="1"
prepare_err_2="2"
make_err="20"
check_err="30"
install_err="21"

# 初始化变量
[ $src"x" == "x" ] && src='../sources'
[ $build"x" == "x" ] && build='../build'
[ $1"x" != "x" ] && ver=$1

# 准备源码
tar -xvf ${src}/${app}-${ver}.tar* -C ${build} 
cd ${build}/${app}-${ver} || exit $prepare_err_1

# 生成Makefile文件
./configure --prefix=/usr || \
		exit $prepare_err_2

make || exit $make_err
make check || exit $check_err 
make install || exit $install_err

# 清理文件
cd ..
rm ${app}-${ver} -rf