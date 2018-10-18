//
//  XCBaseFoundationController.swift
//  Swift-UI
//
//  Created by Alexcai on 2018/10/17.
//  Copyright © 2018 Alexcai. All rights reserved.
//

import UIKit

class XCBaseFoundationController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print("hello swift")
        
        
        let originalString = "hello world"
        
        originalString.forEach {
            print($0)
        }
    }

}
