#!/bin/sh

#  XCConfuseRun.sh
#  ObjcUI
#
#  Created by Alexcai on 2018/11/8.
#  Copyright © 2018 dongjiu. All rights reserved.
#  编译执行脚本文件  Builds Phases  -- > Run Script  -- > 添加此角本的路径信息 $PROJECT_DIR/+ 脚本在项目中的路径
#  以下角本命令会在编译时执行
echo "<<<< XCConfuseRun.sh >>>>"
path=$(pwd)
echo $path
date_01=`date`
echo $date_01
echo "=======ls -l==========="

LS1=`ls -l`
echo $LS1

echo "=======双引号变量================"
echo "$LS1"

#echo =======String==========
n=23
# 双引号中的$n会先解析变量n的值后再替换到对应位置
echo "n = $n"
# 直接输出时不能有空格,否则会被当作另外的一个字符串
echo $n
# 使用单引号的字符串中的变量引用无效,即$n不会被解析,直接原样输出
echo 'n = $n'
# 获取字符串长度 : ${#字符串名称}
str1="this is a string for shell"
echo "str1 length = ${#str1}"
#  =======字符串截取==================
# 指定位置和长度进行截取
echo ${str1:8:3}  # 从str第八个索引位置,截取长度为3的一段
# 指定字符截取  使用%截取字符串左边的内容 ;
#Xcode 不支持使用#截取字符串右边的内容,但在shell命令模式中支持#截取字符串右边的内容
echo ${str1%or*}
#echo -e "\033[32m ============================\033[0m"
#echo ${str1#*for}

#cat ./ObjcUI/Classes/XCConfuse/XCConfuseFunc.plist
#cat ${SRCROOT}/ObjcUI/Classes/XCConfuse/XCConfuseFunc.plist
#echo "=================="
#cat ./ObjcUI/SupportFiles/Info.plist
#echo "=================="

#a=100
#echo $a

#function myTest(){
# 函数内容定义的变量默认是全局变量
#b=23
# 函数内部定义局部变量 需要使用local
#local c=33
#echo $c
# $* 表示所有参数
#echo $*
# $# 表示参数个数
#echo "args count = $#"
# $0 表示当前脚本的文件名
#echo "current fun name $0"
#}
#echo "current script name = $0"
#myTest 'hello' 'good' 'alex'
#echo $b
#echo $c



##  ================ TODO FIXMI
KEYWORDS="TODO:|FIXME:|\?\?\?:|\!\!\!:"
find "${SRCROOT}" \( -name "*.h" -or -name "*.m" \) -print0 | xargs -0 egrep --with-filename --line-number --only-matching "($KEYWORDS).*\$" | perl -p -e "s/($KEYWORDS)/ warning: \$1/"

