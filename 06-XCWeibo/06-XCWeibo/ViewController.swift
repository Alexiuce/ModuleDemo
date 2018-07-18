//
//  ViewController.swift
//  06-XCWeibo
//
//  Created by Alexcai on 2018/7/16.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let v = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        
        v.backgroundColor = #colorLiteral(red: 0.8331019746, green: 0.6142278148, blue: 0.09803921729, alpha: 1)
        view.addSubview(v)
        
        let btn = UIButton(type: .contactAdd)
        
        v.addSubview(btn)
        btn.addTarget(self, action: #selector(clickMe), for: .touchUpInside)
        
    }

    
   @objc func clickMe()  {
        print(#function)
        print(#file)

}
    
}

