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
        
        
        cityName.asObservable().subscribe(onNext: {[weak self] in
            guard let strongSelf = self else {return}
            print($0)
            strongSelf.cityLabel.text = $0
        }).disposed(by: disposeBag)
        
        cityName.asObservable().bind(to: cityLabel.rx.text).disposed(by: disposeBag)
        cityName.value = "Hangzhou"
        
//       ApiController.share.currentWeather(city: "hc")
//        .flatMap {
//           return Observable.of($0.cityName)
//        }
//        .asDriver(onErrorJustReturn: "hz")
//        .drive(cityLabel.rx.text)
//        .disposed(by: disposeBag)
        
        
        
    }



}

