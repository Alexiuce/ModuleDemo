//
//  ViewController.swift
//  ModuleDemo
//
//  Created by Alexcai on 2018/2/20.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func clickBtnOne(_ sender: NSButton) {
        sender.xc_startMarchingAnts()
    }
    
    @IBAction func clickBtnTwo(_ sender: NSButton) {
    }
}

