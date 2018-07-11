//
//
// ViewController.swift
// Created by Alex on 2018/7/3
// Copyright © 2018年 alexiuce.github.io. All rights reserved.

//

import Cocoa

class ViewController: NSViewController {

  
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        gcdemo1()
//        barrier()
        
//        let a = 1
//
//        if 0...10 ~= a {
//            print("yes")
//        }
        groupExample()
        
        // Do any additional setup after loading the view.
    }

   

    @IBOutlet weak var click: NSButton!
    
    @IBAction func clickBtn(_ sender: Any) {
//        gcdemo1()
        print("time = \(Date())")
        afterExample()
        
    }
    
}


extension ViewController{
    /** GCD 内部会维护一个线程池, async会将创建的新线程添加到线程池中,这是为了减少频繁创建线程,直到线程池中的线程不够用时,才会新创建线程 */
    func gcdemo1()  {
        let queue = DispatchQueue(label: "com.alex", qos: .userInitiated)  // 串行队列
        let queue1 = DispatchQueue(label: "com.alex", qos: .utility)
        /** qos 从高到低的顺序 ,优先级越高,会得到更多的被执行机会,
         userInteractive
         userInitiated
         default
         utility
         background
         unspecified
         */
//        let conqueue = DispatchQueue(label: "mmm", qos: .default, attributes:.concurrent) // 并行队列
        
        queue.async {
            for i in 0 ..< 10 {
                print("😃 \(i)")
            }
        }
        queue1.async {
            for i in 100 ..< 110{
                print("😡 \(i)")
            }
        }
    }
    // gcd barrier demo
    func barrier(){
//        let queue = DispatchQueue.global()
//        for i  in 1 ..< 100 {
//            queue.async {
//                print("i = \(i)")
//                self.array.append(i)
//            }
//        }
        
        
        let conqueue = DispatchQueue(label: "com.alexiuce",  attributes: .concurrent)
       
        let barrierItem = DispatchWorkItem(flags: .barrier) {
            print("barrier============")
        }
        
        
        conqueue.async {
            print("task 1...")
        }
        conqueue.async {
            print("task 2...")
        }
        conqueue.async {
            print("task 3...")
        }
        conqueue.async {
            print("task 4...")
        }
        // barrier 会等待前面的任务都执行完毕后,再执行开始执行后续的任务,它类似与在队列中添加了一个同步栅栏,使得之前和之后的任务有了先后顺序
        conqueue.async(execute: barrierItem)
        
        conqueue.async {
            print("task 5...")
        }
        conqueue.async {
            print("task 6...")
        }
        conqueue.async {
            print("task 7...")
        }
        
        
        
    
//        for i in 1 ..< 10 {
//            // .barrier 对全局队列没有约束效果
//            let work = DispatchWorkItem(flags:.barrier) {
//                print("current....\(i)")
//            }
//            conqueue.async(execute: work)
//        }
        
    }
    
    func afterExample()  {
        let queue = DispatchQueue(label: "com.alex")
        queue.asyncAfter(deadline: DispatchTime.now() + 2) {
            print("good")
        }
    }
    
    func groupExample()  {
        let group = DispatchGroup()
        let queue = DispatchQueue.global()
        
        group.enter()
        queue.async {
            print("task 1")
            group.leave()
        }
//        queue.async(group: group) {
//             print("task 1")
//        }
        queue.async(group: group) {
            print("task 2")
        }
        queue.async(group: group) {
            print("task 3")
        }
        queue.async(group: group) {
            print("task 4")
        }
        group.notify(queue: queue) {
            print("all done")
        }
        /* 等待组内的任务执行,如果指定时间内尚未完成,则继续执行后面的代码*/
//        group.wait(timeout: .now() + 2.0)
        
        
    }
    
    
}
