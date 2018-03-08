//
//  ViewController.swift
//  RxSwiftMac02
//
//  Created by caijinzhu on 2018/3/7.
//  Copyright © 2018年 alexiuce.github.io. All rights reserved.
//

import Cocoa

import RxSwift

fileprivate enum MyError: Error{
                case anErro
            }

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        demo1()    // debug
//        demo2()    // PublishSubject
//        demo3()    // BehaviorSubject
//        demo4()    // ReplaySubject
        demo5()    // VariableSubject
        
    }
    
    fileprivate func demo1(){
        example(of: "debug") {
            let disposeBag = DisposeBag()
            
            Observable.of(1,2,3).debug("debug:", trimOutput: true).subscribe(onNext: { (value) in
                print("value = \(value)")
            }, onError: { (error) in
                print(error)
            }, onCompleted: {
                print("completed")
            }, onDisposed: {
                print("disposed...")
            }).disposed(by: disposeBag)
            
        }
    }

    fileprivate func demo2(){
        let subject = PublishSubject<String>()
        let subscriptionOne = subject.subscribe(onNext: { (text) in
            print(text)
        })
        subject.onNext("Is there anynoe listening?")
        
        subject.onNext("en....somebody here..")
        
        let subscriptionTwo = subject.subscribe { (event) in
            print("two", event.element ?? event)
        }
        subject.onNext("3")
        subscriptionOne.dispose()
        subject.onNext("4")
        
        subject.onCompleted()
        subject.onNext("5")
        subscriptionTwo.dispose()
        
        let disposeBag = DisposeBag()
        subject.subscribe{
            print("three",$0.element ?? $0)
        }.disposed(by: disposeBag)
        
        
        subject.onNext("???")
    }

    fileprivate func demo3(){
        
       
    
        
        example(of: "BehaviorSubject") {
            let subject = BehaviorSubject(value: "init")
            
            let disposeBag = DisposeBag()
            
            subject.onNext("xx")
            subject.subscribe({ (event) in
                print("label 1",event.element ?? "null")
            }).disposed(by: disposeBag)
            subject.onError(MyError.anErro)
            
            subject.subscribe({ (event) in
                print("label 2",event.element ?? "error")
            }).disposed(by: disposeBag)
        }
        
        
    }
    
    fileprivate func demo4(){
        example(of: "Replay Subject") {
            let subject = ReplaySubject<String>.create(bufferSize: 2)
            let disposeBag = DisposeBag()
            subject.onNext("1")
            subject.onNext("2")
            subject.onNext("3")
            subject.subscribe({ (event) in
                print("lable1:==",event.element ?? "null")
            }).disposed(by: disposeBag)
            
            subject.subscribe({ (event) in
                print("label2:==", event.element ?? "label2 null")
            }).disposed(by: disposeBag)
            
            
            subject.onNext("4")
            
            subject.onError(MyError.anErro)
            subject.dispose()
            subject.subscribe({ (event) in
                print("label3:==",event.element ?? "label3 null")
            }).disposed(by: disposeBag)
            
            subject.subscribe({ (event) in
                print("label4:==",event.element ?? "label4 null")
            }).disposed(by: disposeBag)
            
        }
    }

    fileprivate func demo5(){
        /* Varibale : 需要初始值 不会发送error事件,自动发送complete事件 */
        
        let variable = Variable("init value")
        let disposeBag = DisposeBag()
        variable.value = "new value"
        variable.asObservable().subscribe { (event) in
            print("1):",event.element ?? "null")
        }.disposed(by: disposeBag)
        
        
        variable.value = "1"
        variable.asObservable().subscribe { (envnt) in
            print("2):", envnt.element ?? "null")
        }.disposed(by: disposeBag)
        variable.value = "2"
        
        
        
        
    }

}


extension ViewController{
    fileprivate func example(of example: String, action: ()->Void){
        print("----Example \(example) ----")
        action()
    }
}
