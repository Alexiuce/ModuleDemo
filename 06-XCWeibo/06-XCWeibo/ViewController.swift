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

        
        /// 对于可选类型, let 没有可选默认值; var的可选默认值为nil;
        let y :Int?
        y = 10
        print(y ?? 0)
        /// swift 中 三目运算符如果需要忽略某一个执行情况,可以使用()表示忽略执行
        /* demo: y > 4 ? print("bigger") : ()  */
        
        
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

