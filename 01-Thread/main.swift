//
//
// main.swift
// Created by Alex on 2018/6/22
// Copyright © 2018年 Alexcai. All rights reserved.

//

import Foundation

class Person: NSObject {
    var count = 0
    
   @objc func sayHello()  {
    print("ddd")
    
        for _ in 0 ..< 10 {
            
            /** swift 同步锁
                 objc_sync_enter(self)
                 objc_sync_exit(self)
                */
//            count += 1
            print("count \(count)....\(Thread.current.name ?? "")")
        }
    
    }
}
/** 互斥锁 & 自旋锁
 
 互斥锁:如果发现其他线程正在执行锁住的代码,线程会进入休眠状态(就绪状态),等待开锁后,线程会被唤醒,进入执行
 自旋锁:如果发现其他线程正在执行锁住的代码,线程使用死循环方式一直等待开锁后,执行线程工作.
 
 */

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
let p = Person()
p.sayHello()
func nsthread_demo(){
    /** 线程的状态: 新建---> 就绪 ---> 执行--->阻塞--->死亡 */
    let t = Thread(target:p, selector: #selector(p.sayHello), object: nil)
    t.name = "mythread"
    t.start()
    
//    let t1 = Thread(target:p, selector: #selector(p.sayHello), object: nil)
//    t1.name = "t1"
//    t1.start()
    
    
}

func getImage(url: String)  {
    guard let imgUrl = URL(string: url) else {return}
    guard let imgData = try? Data(contentsOf: imgUrl) else {return}
    print(imgData)
    
    
    /** sizeToFit
     设置控件大小匹配需要展示的内容
     */
    
}
//nsthread_demo()




