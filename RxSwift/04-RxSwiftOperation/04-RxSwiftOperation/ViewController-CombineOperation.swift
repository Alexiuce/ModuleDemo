//
//
// ViewController-CombineOperation.swift
// Created by Alex on 2018/5/28
// Copyright © 2018年 alexiuce.github.io. All rights reserved.

//

import Foundation
import RxSwift

// MARK:- Combine Operation
extension ViewController{
    
    func zipExample(){
        enum Wether{
            case cloudy
            case sunny
        }
        let left: Observable<Wether> = Observable.of(.cloudy, .sunny, .cloudy, .sunny)
        let right = Observable.of("Lisbon", "Copenhagen","London", "Madrid","Vienna")
        _ = Observable.zip(left,right) { wether,city in
            return "\(wether) in \(city)"
            }.subscribe(onNext: {
                print($0)
            })
        
    }
    
}
