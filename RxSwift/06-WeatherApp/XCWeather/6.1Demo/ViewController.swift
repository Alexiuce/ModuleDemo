//
//  ViewController.swift
//  6.1Demo
//
//  Created by caijinzhu on 2018/3/20.
//  Copyright © 2018年 alexiuce.github.io. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        ApiController.share.currentWeather(city: "Beijing").subscribe(onNext: { (weather) in
            print(weather.cityName)
            print(Thread.current)
        }).disposed(by: disposeBag)
    }



}

