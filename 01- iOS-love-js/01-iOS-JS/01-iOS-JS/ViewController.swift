//
//  ViewController.swift
//  01-iOS-JS
//
//  Created by caijinzhu on 2018/3/28.
//  Copyright © 2018年 alexiuce.github.io. All rights reserved.
//

import UIKit

import JavaScriptCore


class ViewController: UIViewController {
    
    let server = BLTServer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func scan(_ sender: UIButton) {
        server.starScan()
    }
}

