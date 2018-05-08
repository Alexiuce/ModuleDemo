#  文件上传


* post body 格式


Content-Type : multipart/form-data   boudary: ---xxxx

* 多个文件上传方式
1. 开启多条线程,在每个线程中进行单文件上传 : (不推荐) ,这种方式每条线程都会和服务器进行TCP的三次握手
2. 开启一条线程,在线程中进行多文件拼接上传: 一次TCP握手连接,


* 多文件上传body格式

----boudary 
Content-Type....
上传文件1的二进制
\r\n

----boudary 
Content-Type....
上传文件2的二进制
\r\n
...
...
...

----boudary 
Content-Type....
上传文件n的二进制
\r\n

----boudary 
文件名信息

----boudary 
结束标志


# 自定义对象转字典

* 默认情况下,Swift自定义对象不支持kvc和kvo

* 如果需要使用kvc将对象转为字典,需要在属性的字段中,使用@objc





