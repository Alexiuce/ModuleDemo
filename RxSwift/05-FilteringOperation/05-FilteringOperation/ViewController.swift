//
//  ViewController.swift
//  05-FilteringOperation
//
//  Created by caijinzhu on 2018/3/14.
//  Copyright © 2018年 alexiuce.github.io. All rights reserved.
//

import Cocoa
import RxSwift


class ViewController: NSViewController {

    fileprivate var start = 0
    fileprivate let bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        
//        demo1()
//        demo2()
        example(of: "map") {
            Observable.of("1","2","3","4","5").map({ ($0 as NSString).integerValue
            }).toArray().subscribe(onNext: { (el) in
                print(el)
            }).disposed(by: bag)
        }
        
        
    }

    
    fileprivate func demo1(){
        let numbers = Observable<Int>.create { [weak self] (observer) -> Disposable in
            let start = self!.getNumber()
            observer.onNext(start)
            observer.onNext(start + 1)
            observer.onNext(start + 2)
            observer.onCompleted()
            return Disposables.create()
        }
        
        numbers.subscribe(onNext: { (el) in
            print("element [\(el)]")
        },onCompleted: {
            print("----------")
        }).disposed(by: bag)
        
        numbers.share().subscribe(onNext: { (el) in
            print("element [\(el)]")
        },onCompleted: {
            print("----------")
        }).disposed(by: bag)
    }
    
    fileprivate func demo2(){
        Observable.of("1","2","3","4","5").toArray().subscribe(onNext: { (el) in
            print(el)
        }).disposed(by: bag)
    }
    
    
    fileprivate func getNumber() -> Int{
        start += 1
        return start
    }
    
    fileprivate func example(of example: String, action: ()-> Void){
        print("-------Example \(example)-----------")
        action()
    }


}

