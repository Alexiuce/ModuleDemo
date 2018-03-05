//
//  ViewController.swift
//  RxSwiftMac01
//
//  Created by caijinzhu on 2018/3/5.
//  Copyright © 2018年 alexiuce.github.io. All rights reserved.
//

import Cocoa
import RxSwift

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        example(of: "just,of,fromm") {
            let one = 1
            let two = 2
            let three = 3
            let observable = Observable.of(one,two,three)
            _ = observable.subscribe(onNext: { (element) in
                print(element)
            })
            
            
        }
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

