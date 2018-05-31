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
    
    
    func scanExample(){
        let source = Observable.of(1,2,3)
        let obs = source.scan(0, accumulator: +)
        _ = obs.subscribe(onNext: {
            print($0)  // 1   3   6
        })
        
    }
    
    func reduceExample(){
        let source = Observable.of(1,2,3,4,5,6)
        /** reduce 只会等到observable complete时才会执行block中的代码 */
        let obs = source.reduce(0, accumulator: +)
        _ = obs.subscribe(onNext: {
            print($0)    //  21
        })
        
        
    }
    
    
    func switchLastExample(){
        let one = PublishSubject<String>()
        let two = PublishSubject<String>()
        let three = PublishSubject<String>()
        
        let source = PublishSubject<Observable<String>>()
        /**
         switchLatest():仅会获取observable最新的流
         
         与flatMapLatest():先将一个latest value转换为observable 然后subscribes
         */
        let obs = source.switchLatest()
        _ = obs.subscribe(onNext: {
            print($0)
        })
        source.onNext(one)
        one.onNext("text from one")
        two.onNext("text from two")
        
        source.onNext(two)
        two.onNext("more text from two")
        one.onNext("more text from one")
        
        source.onNext(three)
        two.onNext("why from two")
        one.onNext("why from one")
        three.onNext("why from three")
        three.onNext("i win form three")
        
        source.onNext(one)
        one.onNext("it's me ...")
        
        
        
        
    }
    
    
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
        /** sample 与withLatestFrom 作用相同,只是 sample的参数是触发者, 而withLatestFrom的参数是数据发出者
        let obs1 = textfield.sample(button)
        _ = obs1.subscribe(onNext: {
            print("------")
            print($0)
         
        })
         */
        
        textfield.onNext("a")
        textfield.onNext("b")
        textfield.onNext("c")
        button.onNext(())
        button.onNext(())
        
    }
    
}
