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
        
    }


}


extension ViewController{
   
    
    fileprivate func blockOPExample(){
        /* swift 中没有NSInvocationOperation, 仅支持BlockOperation */
    }
}
