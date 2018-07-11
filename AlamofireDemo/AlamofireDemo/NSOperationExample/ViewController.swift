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
//        blockOPExample()
        
        
    }

    @IBAction func clickBtn(_ sender: NSButton) {
        
        if queue.operationCount == 0 {
            queue.addOperation {
                self.ui_demo()
            }
//            btn.stringValue = "Stop"
            btn.title = "Stop"
            queue.isSuspended = false
        }else if !queue.isSuspended {
            queue.isSuspended = true
//            btn.stringValue = "Start"
            btn.title = "Start"
            
        }
        
    }
    
}


extension ViewController{
   
    
    fileprivate func blockOPExample(){
        /* swift 中没有NSInvocationOperation, 仅支持BlockOperation */
        let op1 = BlockOperation {
            print("task 1 \(Thread.current)")
        }
        
        /* start 方式调用执行operation 时,不会开启新线程,需要将operation添加到queue中,才会创建新的线程执行operation*/
//        op1.start()
        
        let queue = OperationQueue()
        queue.addOperation(op1)
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
