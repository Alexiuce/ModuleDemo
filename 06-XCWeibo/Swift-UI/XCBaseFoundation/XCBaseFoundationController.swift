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

        
        
        let originalString = "hello world"
        print(originalString.count)
        /**遍历*/
        originalString.forEach {
            print($0)
        }
        /* 子串*/
        let starIndex = originalString.index(originalString.startIndex, offsetBy: 3)
        let subString = originalString[starIndex..<originalString.endIndex]
        
        print(subString)
        
        
        
    }

}
