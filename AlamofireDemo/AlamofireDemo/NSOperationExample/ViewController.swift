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

    override func viewDidLoad() {
        super.viewDidLoad()
        blockOPExample()
        
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
}
