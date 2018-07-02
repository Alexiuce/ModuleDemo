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
/**  自动释放池
 1. objective-c中没有java或C#中的垃圾回收机制
 2. MRC中,谁创建,谁回收
 3. ARC中,编译器会根据代码结构自动添加retain,release或autoRelease
 4. 标记为autorelease的对象,会被添加到最近一次创建的自动释放池中
 5. 当自动释放池销毁或耗尽时,会向池中的所有对象发送一次release消息
 ----------------- 创建和销毁  ----------------
 * 自动释放池的创建和销毁
 1. 主线程的每一个消息循环(runloop)开始的时候会创建自动释放池,每次消息循环结束时,会销毁自动释放池
 2. 使用NSThread进行多线程开发中,需要在线程调度方法中手动创建自动释放池
 
 ------------------ 消息循环 ----------------------
 1.event loop
 ------------------ 自动释放池使用情景 ------------
 1. 在一个循环中,创建了大量的临时对象
 2. 在子线程创建时
 
 */



