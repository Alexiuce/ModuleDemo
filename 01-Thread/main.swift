//
//
// main.swift
// Created by Alex on 2018/6/22
// Copyright © 2018年 Alexcai. All rights reserved.

//

import Foundation

class Person: NSObject {
   @objc func sayHello()  {
        print("hello ....")
    }
}


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
func nsthread_demo(){
    
    let p = Person()
    let t = Thread(target:p, selector: #selector(p.sayHello), object: nil)

    t.start()
    
}

nsthread_demo()
pthread_demo()


