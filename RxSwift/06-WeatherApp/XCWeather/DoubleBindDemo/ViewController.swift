//
//  ViewController.swift
//  DoubleBindDemo
//
//  Created by caijinzhu on 2018/3/19.
//  Copyright © 2018年 alexiuce.github.io. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


class ViewController: UIViewController {

    @IBOutlet weak var mySwitch: UISwitch!
    
    lazy var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mySwitch.rx.isOn.subscribe {
            print("\($0)")
        }.disposed(by: disposeBag)
 

    }


}

