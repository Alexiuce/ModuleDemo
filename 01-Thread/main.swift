//
//
// main.swift
// Created by Alex on 2018/6/22
// Copyright © 2018年 Alexcai. All rights reserved.

//

import Foundation

class Person: NSObject {
   @objc func sayHello()  {
        print("hello ....\(Thread.current)")
    }
}



func pthread_demo()  {
    
    
    var pt: pthread_t?
    var arg = "abc"
    /** tid = 0 线程创建成功 ,否则创建失败 */
   let tid = pthread_create(&pt, nil, { (sp) -> UnsafeMutableRawPointer? in
        let str = sp.assumingMemoryBound(to: String.self)

        print("create == \(str.pointee) \(Thread.current)")
        return nil
    }, &arg)
    print(tid)
}
func nsthread_demo(){
    /** 线程的状态: 新建---> 就绪 ---> 执行--->阻塞--->死亡 */
    let p = Person()
    let t = Thread(target:p, selector: #selector(p.sayHello), object: nil)
    t.name = "mythread"
    t.start()
    
}

nsthread_demo()
pthread_demo()


