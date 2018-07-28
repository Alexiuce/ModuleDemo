//
//  ViewController.swift
//  TransAnimationController
//
//  Created by Alexcai on 2018/7/28.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var containView: MYContainView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildViewController(RedController())
        addChildViewController(BlueController())
        containView.addSubview(childViewControllers[0].view)
        containView.layer?.backgroundColor = NSColor.orange.cgColor
    
    }

    @IBAction func clickBtn(_ sender: Any) {
        transition(from: childViewControllers[0], to: childViewControllers[1], options: .allowUserInteraction, completionHandler: nil)
    }
    
    @IBAction func clickUpButton(_ sender: Any) {
        transition(from: childViewControllers[1], to: childViewControllers[0], options: .allowUserInteraction, completionHandler: nil)
    }
    
}

