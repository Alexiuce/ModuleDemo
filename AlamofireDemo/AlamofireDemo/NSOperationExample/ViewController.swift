//
//
// ViewController.swift
// Created by Alex on 2018/7/5
// Copyright © 2018年 alexiuce.github.io. All rights reserved.

//

import Cocoa


/** NSOperation 是一个抽象类(仅定义了方法,没有方法的具体实现)
 *
 *
 */

class ViewController: NSViewController {

    @IBOutlet weak var label1: NSTextField!
    
    @IBOutlet weak var label2: NSTextField!
    
    @IBOutlet weak var label3: NSTextField!
    
    
    @IBOutlet weak var btn: NSButton!
    
    let queue = OperationQueue()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blockOPExample()
        
        
        
        
    }

    @IBAction func clickBtn(_ sender: NSButton) {
        
        if queue.operationCount == 0 {
            queue.addOperation {
                self.ui_demo()
            }

            btn.title = "Stop"
            queue.isSuspended = false
        }else if !queue.isSuspended {
            queue.isSuspended = true
            /* OperationQueue suspended 时,不会挂起已经开始的任务 */
            btn.title = "Start"
        }
    }
    
}


extension ViewController{
   
    
    fileprivate func blockOPExample(){
        /* swift 中没有NSInvocationOperation, 仅支持BlockOperation */
        let op1 = BlockOperation {
            for i in 0 ..< 10 {
                print("op1 \(i)")
            }
        }
        
        /* start 方式调用执行operation 时,不会开启新线程,需要将operation添加到queue中,才会创建新的线程执行operation*/
//        op1.start()
         // 操作的优先级别(**不是队列的优先级):
        
        op1.qualityOfService = .userInteractive
        op1.completionBlock = {
            print("op1 finished \(Thread.current)")
        }
        
        let op2 = BlockOperation{
            
            for i in 0 ..< 10 {
                print("op2 \(i)")
            }
        }
        op2.qualityOfService = .background
//        op2.qualityOfService = .
        
        
        /* Operation 之间的依赖关系可以跨队列存在(即使多个操作在不同的队列,也可以保证依赖关系顺序的执行) */
//        op2.addDependency(op1)
    
        let queue1 = OperationQueue()
        queue1.addOperation(op1)
        queue1.addOperation(op2)
    }
    // UI responser event
    fileprivate func ui_demo(){
        while !queue.isSuspended {
            Thread.sleep(forTimeInterval: 0.05)
            let n1 = arc4random_uniform(10)
            let n2 = arc4random_uniform(10)
            let n3 = arc4random_uniform(10)
            OperationQueue.main.addOperation {
                self.label1.stringValue = "\(n1)"
                self.label2.stringValue = "\(n2)"
                self.label3.stringValue = "\(n3)"
            }
            
        }
    }
}
