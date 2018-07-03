//
//
// main.swift
// Created by Alex on 2018/7/3
// Copyright © 2018年 Alexcai. All rights reserved.

//

import Foundation


/** runloop :
 1.每个线程内部都有一个runloop消息循环
 2.只有主线程的runloop是默认开启的
 3. [[NSRunloop currentRunloop] run] 开启子线程的runloop, 但若没有事件或者输入源, runloop 会立刻退出
---作用----
   * 保证线程不会退出
   * 负责处理事件
   * 无事件处理时,进入休眠,有事件时,则响应事件处理
 */

