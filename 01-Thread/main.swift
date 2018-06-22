//
//
// main.swift
// Created by Alex on 2018/6/22
// Copyright © 2018年 Alexcai. All rights reserved.

//

import Foundation

print("Hello, World!")

func pthread_demo()  {
    print("p....")
    
    var pt: pthread_t?
    var arg = "abc"
    
   let tid = pthread_create(&pt, nil, { (sp) -> UnsafeMutableRawPointer? in
        let str = sp.assumingMemoryBound(to: String.self)

        print("create == \(str.pointee) \(Thread.current)")
        return nil
    }, &arg)
    
    
    
    print("\(tid) ")

}

pthread_demo()


