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
    @IBOutlet weak var cityLabel: UILabel!
    
    let disposeBag = DisposeBag()
    var cityName = Variable("")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        cityName.asObservable().subscribe(onNext: {[weak self] in
//            print($0)
//           self?.cityLabel.text = $0
//        }).disposed(by: disposeBag)
        
//        cityName.asObservable().bind(to: cityLabel.rx.text).disposed(by: disposeBag)
//        cityName.value = "Hangzhou"
        
       let w = ApiController.share.currentWeather(city: "hc")
        w.flatMap {
           return Observable.of($0.cityName)
        }.bind(to: cityLabel.rx.text).disposed(by: disposeBag)
    }



}

