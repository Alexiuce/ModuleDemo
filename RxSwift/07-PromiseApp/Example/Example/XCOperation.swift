//
//
// XCOperation.swift
// Created by Alex on 2018/4/28
// Copyright © 2018年 alexiuce.github.com. All rights reserved.

//

import Cocoa
import PromiseKit


class XCOperation: Operation {

    

    var resultPromise: Promise<String>?
    
    
    override func main() {
        
        
        autoreleasepool {
            print("long time ... after")
            resultPromise = Promise{
                $0.fulfill("good ...answer..")
            }
            
        }
        
    }
}



