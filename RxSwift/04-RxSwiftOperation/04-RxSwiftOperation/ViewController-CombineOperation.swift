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
    
    
    func ambExample(){
        /** amb(): 两者取其一, 一旦收到某个obs的流之后,就会忽略另一个, 仅接收最先开始的那个observable */
        let left = PublishSubject<String>()
        let right = PublishSubject<String>()
        let obs = left.amb(right)
        _ = obs.subscribe(onNext: {
            print($0)
        })
        
        right.onNext("Parise")
        left.onNext("Lisbon")
        right.onNext("Copenhagen")
        left.onNext("London")
        left.onNext("Madrid")
        right.onNext("Vienna")
    }
    
    
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
    
    
    func lastFromExample(){
        let button = PublishSubject<Void>()
        let textfield = PublishSubject<String>()
        
        let obs = button.withLatestFrom(textfield)
        _ = obs.subscribe(onNext: {
            print("========")
            print($0)
        })
        
        let obs1 = textfield.sample(button)
        _ = obs1.subscribe(onNext: {
            print("------")
            print($0)
            
        })
        
        textfield.onNext("a")
        textfield.onNext("b")
        textfield.onNext("c")
        button.onNext(())
        button.onNext(())
        
    }
    
}
