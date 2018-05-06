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
        
    }
    
    
    @IBAction func clickIgnore(_ sender: NSButton) {
        example(of: "ignoreElements") {
            let strikes = PublishSubject<String>()
            let bag = DisposeBag()
            /* 忽略所有onNext事件 */
            strikes.ignoreElements().subscribe {
                print($0)
                print("you're out")
                }.disposed(by: bag)
            strikes.onNext("hello")
            strikes.onNext("world")
            strikes.onNext("yep")
        }
    }
    
    
    @IBAction func clickElementAt(_ sender: Any) {
        demo1()
    }
    
    
    @IBAction func clickFilter(_ sender: NSButton) {
        demo2()
    }
    
    @IBAction func clickSkip(_ sender: NSButton) {
        demo3()
    }
    
    fileprivate func demo1() {
        
        example(of: "elementAt") {
            let strikes = PublishSubject<String>()
            let bag = DisposeBag()
            /* 仅仅响应指定位置onNext的消息*/
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
            /*过滤掉不符合条件的内容*/
            Observable.of(1,2,3,4,5,6,7,8).filter{
                $0 % 2 == 0
                }.subscribe(onNext: {
                    print("filter after \($0)")
                }).disposed(by: bag)
        }
    }
    
    
    fileprivate func demo3(){
        example(of: "Skip") {
            /* 忽略指定前面的元素*/
            Observable.of("a","b","c","d","e").skip(3).subscribe(onNext: {
                print("\($0)")
            }).disposed(by: bag)
        }
    }
    
    
    fileprivate func demo4(){
        example(of: "skitWhile") {
            /*当某个条件不满足时 开始监听后续的onNext事件*/
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
            /* 直到另个对象触发时才会响应订阅事件 */
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
    
    
    fileprivate func demo6(){
        /* take 操作与skip相反,take(3)表示取前面三个订阅; skip(3)指忽略前面3个 订阅 */
        //        Observable.of(1,2,3,4,5,6).take(3).subscribe(onNext: { (number) in
        //            print(number)
        //        }).disposed(by: bag)
        /* 与skipWhile 相反 一旦条件不满足,则不再接收后续的onNext */
        //        Observable.of(1,2,3,4,5,6).takeWhile {
        //            $0 > 4
        //        }.subscribe(onNext: {
        //            print($0)
        //        }).disposed(by: bag)
        
        //        example(of: "enumerated") {
        //            Observable.of(2,2,4,4,6,6).enumerated().takeWhile({ (index ,element) -> Bool in
        //                element % 2 == 0 && index < 3
        //            }).map{$0.element}.subscribe(onNext: {
        //                print($0)
        //            }).disposed(by: bag)
        //        }
        
        /* 与skipUntil 相反 一旦trigger触发,则不再接收*/
        //        example(of: "takeUntil") {
        //
        //            let subject = PublishSubject<String>()
        //            let trigger = PublishSubject<String>()
        //            subject.takeUntil(trigger).subscribe(onNext: {
        //                print($0)
        //            }).disposed(by: bag)
        //            subject.onNext("1")
        //            subject.onNext("2")
        //            trigger.onNext("x")
        //            subject.onNext("3")
        //        }
        
        example(of: "distinctUntilChanged") {
            //            Observable.of(1,2,2,4,4,5,6).distinctUntilChanged().subscribe(onNext: {
            //                print($0)
            //            }).disposed(by: bag)
            Observable.of(1,2,2,4,4,5,6).distinctUntilChanged({ (a, b) -> Bool in
                print("a= \(a) b = \(b)")
                return a == b
            }).subscribe(onNext: {
                print($0)
            }).disposed(by: bag)
            
            
            let formatter = NumberFormatter()
            formatter.numberStyle = .spellOut
            guard let words = formatter.string(from: 12320) else{ return }
            print("words = \(words)")
        }
    }
    
}

extension ViewController{
    fileprivate func example(of example: String, action: ()->Void){
        print("----Example \(example) ----")
        action()
    }
}

