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
        gcdemo1()
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBOutlet weak var click: NSButton!
    
    @IBAction func clickBtn(_ sender: Any) {
        gcdemo1()
    }
    
}


extension ViewController{
    /** GCD 内部会维护一个线程池, async会将创建的新线程添加到线程池中,这是为了减少频繁创建线程,直到线程池中的线程不够用时,才会新创建线程 */
    func gcdemo1()  {
        let queue = DispatchQueue.global()
        queue.async {
            print("thread \(Thread.current)")
        }
        
        
    }
}
