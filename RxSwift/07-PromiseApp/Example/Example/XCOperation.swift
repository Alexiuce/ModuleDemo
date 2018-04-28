//
//
// XCOperation.swift
// Created by Alex on 2018/4/28
// Copyright © 2018年 alexiuce.github.com. All rights reserved.

//

import Cocoa
import PromiseKit


class XCOperation: Operation {

    
    override func main() {
        
        autoreleasepool {
            print("long time ... after")
            
            
            assert(true, "error....test")   /* 条件不成立,提示错误信息*/
        }
        
    }
}



