//
//  ViewController.swift
//  ModuleDemo
//
//  Created by Alexcai on 2018/2/20.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var btn: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btn.isEnabled = false
       reduceDemo1()
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func clickBtnOne(_ sender: NSButton) {
//        sender.xc_startMarchingAnts()
        btn.isEnabled = false
    }
    
    @IBAction func clickBtnTwo(_ sender: NSButton) {
        btn.isEnabled = true
    }
    
    @IBAction func clickBtnTest(_ sender: Any) {
        print("btn....")
    }
    
}


extension ViewController{
    fileprivate func reduceDemo(){
        func combinator(accumulator: Int, current: Int) -> Int {
            print("accumulator=\(accumulator), current=\(current)")
            return accumulator + current
        }
        let result = [1,2,3].reduce(0, combinator)
        print(result)
    }
    
    fileprivate func reduceDemo1(){
        
        func rmap(elements: [Int], transform: (Int)-> Int ) -> [Int] {
    
            return elements.reduce([Int](), {( array:[Int], number: Int) -> [Int] in
                var temp = array
                temp.append(transform(number))
                return temp
            })
        }
        
    
       let result = rmap(elements: [1,2,3,4], transform: {$0 * 2})
        print(result)
        
      
    }
}
