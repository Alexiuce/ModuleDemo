//
//
// ViewController.swift
// Created by Alex on 2018/4/24
// Copyright © 2018年 alexiuce.github.com. All rights reserved.

//

import Cocoa
import PromiseKit


class ViewController: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getApi().then { (s) -> Thenable in
            
            } as! (_) -> _
        
        // Do any additional setup after loading the view.
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
}


extension ViewController{
    fileprivate func getApi() -> Promise<String> {
        
        return Promise{ cb in
            cb.fulfill("result")
            }
        
    }
    
    
}
