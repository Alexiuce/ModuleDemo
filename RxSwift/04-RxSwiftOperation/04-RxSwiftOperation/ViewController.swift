//
//  ViewController.swift
//  04-RxSwiftOperation
//
//  Created by caijinzhu on 2018/3/12.
//  Copyright © 2018年 alexiuce.github.io. All rights reserved.
//

import Cocoa
import RxSwift

class ViewController: NSViewController {

    fileprivate let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        demo1()
//        demo2()
//        demo3()
//        demo4()
        demo5()
       
    }
       fileprivate func demo1() {
        
            example(of: "ignoreElements") {
                let strikes = PublishSubject<String>()
                let bag = DisposeBag()
                strikes.ignoreElements().subscribe { (_) in
                    print("you're out")
                    }.disposed(by: bag)
                strikes.onNext("hello")
                strikes.onNext("world")
                strikes.onNext("yep")
            }
        
            example(of: "elementAt") {
                let strikes = PublishSubject<String>()
                let bag = DisposeBag()
                strikes.elementAt(2).subscribe(onNext: { (el) in
                    print("element is \(el)")
                }).disposed(by: bag)
                strikes.onNext("hello")
                strikes.onNext("world")
                strikes.onNext("yep1")
                strikes.onNext("yep2")
                strikes.onNext("yep3")
                strikes.onNext("yep4")
            }
        }
   
    fileprivate func demo2(){
        example(of: "Filter") {
            Observable.of(1,2,3,4,5,6,7,8).filter({ (number) -> Bool in
                number % 2 == 0
            }).subscribe(onNext: {
                print("filter after \($0)")
            }).disposed(by: bag)
        }
    }

    
    fileprivate func demo3(){
        example(of: "Skip") {
            Observable.of("a","b","c","d","e").skip(3).subscribe(onNext: {
                print("\($0)")
            }).disposed(by: bag)
        }
    }
    
    
    fileprivate func demo4(){
        example(of: "skitWhile") {
            Observable.of(1,2,2,3,4,4,4,4,5,4,9,8,6).skipWhile({ (number) -> Bool in
                number % 2 != 0
            }).subscribe(onNext: {
                print("\($0)")
            }).disposed(by: bag)
        }
    }
    fileprivate func demo5(){
        example(of: "SkitUntil") {
            let subject = PublishSubject<String>()
            let trigger = PublishSubject<String>()
            subject.skipUntil(trigger).subscribe(onNext: {
                print("\($0)")
            }).disposed(by:bag)
            
            subject.onNext("s ==1")
            subject.onNext("s == 2")
            trigger.onNext("begin")
            subject.onNext("s == 3")
            subject.onNext("s == 4")
        }
    }
}






extension ViewController{
    fileprivate func example(of example: String, action: ()->Void){
        print("----Example \(example) ----")
        action()
    }
}

