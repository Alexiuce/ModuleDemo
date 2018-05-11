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
//        demo1()
        shareDemo()
    }
    
    
    @IBAction func clickFilter(_ sender: NSButton) {
//        demo2()
        toArrayExample()
    }
    
    @IBAction func clickSkip(_ sender: NSButton) {
        demo3()
    }
    
    
    @IBAction func clickSkipWhile(_ sender: NSButton) {
        demo4()
    }
    
    @IBAction func clickSkitUntil(_ sender: NSButton) {
        demo5()
    }
    
    
    @IBAction func clickTake(_ sender: NSButton) {
        takeDemo()
    }
    
    @IBAction func clickTakeWhile(_ sender: NSButton){
        takeWhileDemo()
    }
    
    
    @IBAction func clickTakeUntil(_ sender: NSButton) {
//        takeUntilDemo()
        flatmapLastExample()
    }
    
    
    @IBAction func clickDistinctUntilChanged(_ sender: NSButton) {
//        demo6()
        obsFlatmapExample()
        
        
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
            /** 过滤掉不符合条件的内容*/
            Observable.of(1,2,3,4,5,6,7,8).filter{
                $0 % 2 == 0
                }.subscribe(onNext: {
                    print("filter after \($0)")
                }).disposed(by: bag)
        }
    }
    
    fileprivate func demo3(){
        example(of: "Skip") {
            /** 忽略指定前面的元素*/
            Observable.of("a","b","c","d","e").skip(3).subscribe(onNext: {
                print("\($0)")
            }).disposed(by: bag)
        }
    }
    
    
    fileprivate func demo4(){
        example(of: "skitWhile") {
            /** 当某个条件不满足时 开始监听后续所有的onNext事件*/
            Observable.of(1,2,2,3,4,4,4,4,5,4,9,8,6).skipWhile{
               $0 < 5
            }.subscribe(onNext: {
                print("\($0)")
            }).disposed(by: bag)
        }
    }
    fileprivate func demo5(){
        example(of: "SkitUntil") {
            let subject = PublishSubject<String>()
            let trigger = PublishSubject<String>()
            /** 直到另个对象触发时才会响应订阅事件 */
    
            subject.skipUntil(trigger).subscribe(onNext: {
                print("\($0)")
            }).disposed(by:bag)
            
            subject.onNext("s ==1")
            subject.onNext("s == 2")
            trigger.onNext("begin")     /** trigger开始发送时, subject 才会不skip 消息流  */
            subject.onNext("s == 3")
            subject.onNext("s == 4")
        }
    }
    
    fileprivate func takeDemo() {
        /* take 操作与skip相反,take(3)表示取前面三个订阅; skip(3)指忽略前面3个 订阅 */
                Observable.of(1,2,3,4,5,6).take(3).subscribe(onNext: { (number) in
                    print(number)
                }).disposed(by: bag)
    }
    
    fileprivate func takeWhileDemo(){
        /* 与skipWhile 相反 一旦条件不满足,则不再接收后续的onNext */
                Observable.of(1,2,3,4,5,6).takeWhile {
                    $0 < 4
                }.subscribe(onNext: {
                    print($0)
                }).disposed(by: bag)
        
                example(of: "enumerated") {
                    Observable.of(2,2,4,4,6,6).enumerated().takeWhile({ (index ,element) -> Bool in
                        element % 2 == 0 && index < 3
                    }).map{$0.element}.subscribe(onNext: {
                        print($0)
                    }).disposed(by: bag)
                }
        
    }
    
    fileprivate func takeUntilDemo(){
        /* 与skipUntil 相反 一旦trigger触发,则不再接收*/
                example(of: "takeUntil") {
        
                    let subject = PublishSubject<String>()
                    let trigger = PublishSubject<String>()
                    subject.takeUntil(trigger).subscribe(onNext: {
                        print($0)
                    }).disposed(by: bag)
                    subject.onNext("1")
                    subject.onNext("2")
                    trigger.onNext("x")
                    subject.onNext("3")
                }
        
    }
    
    fileprivate func demo6(){
        

        example(of: "distinctUntilChanged") {
            //            Observable.of(1,2,2,4,4,5,6).distinctUntilChanged().subscribe(onNext: {
            //                print($0)
            //            }).disposed(by: bag)
            Observable.of(1,2,2,4,4,5,6).distinctUntilChanged({ (a, b) -> Bool in

                return a == b
            }).subscribe(onNext: {
                print($0)
            }).disposed(by: bag)
            
            
           
        }
    }
    
}

extension ViewController{
    fileprivate func example(of example: String, action: ()->Void){
        print("----Example \(example) ----")
        action()
    }
    
    fileprivate func formatDemo(){
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        guard let words = formatter.string(from: 12320) else{ return }
        print("words = \(words)")
        
        
    }
    fileprivate func shareDemo(){
        
        var n = 0
        
        let numbers = Observable<Int>.create { (observer) -> Disposable in
            n += 1
            print("----create---\(n)")
            observer.onNext(n)
            observer.onNext(n + 1)
            observer.onNext(n + 2)
            observer.onNext(n + 3)
            
            return Disposables.create()
        }.share(replay: 2, scope: SubjectLifetimeScope.whileConnected)
        
        
    
        numbers.subscribe(onNext: {
            print($0)
        }).disposed(by: bag)
        
        numbers.subscribe(onNext: {
            print("a) \($0)")
        }).disposed(by: bag)
       
        
        numbers.subscribe(onNext: {
            print("share2 \($0)")
        }).disposed(by: bag)
        
        
        let p = PublishSubject<String>()
        
        p.share().subscribe(onNext: {
            print($0)
        }).disposed(by: bag)
        p.share().subscribe(onNext: {
            print($0)
        }).disposed(by: bag)
        p.onNext("ssss")
    }
    
    fileprivate func toArrayExample(){
        
        Observable.of("1","2","3").toArray().subscribe(onNext: {
            print($0)
        }).disposed(by: bag)
        
        
        let subject = PublishSubject<String>()
        
        subject.asObservable().toArray().subscribe(onNext: {
            print($0)
        }).disposed(by: bag)
        subject.onNext("10")
        subject.onNext("20")
        
    }
    
    fileprivate func obsFlatmapExample(){
        
        let ryan = Student(score: BehaviorSubject(value: 80))
        let charlotter = Student(score: BehaviorSubject(value: 70))
        let student = PublishSubject<Student>()
        
        
        /**
        student.map{
            $0.score
            }.subscribe(onNext: {
                let r = try? $0.value()
                print(r ?? "o")
            }).disposed(by: bag)
         */
 
        
        
        student.flatMap {
            $0.score
            }.subscribe(onNext: {
                print($0)
            }).disposed(by: bag)
        student.onNext(ryan)
        ryan.score.onNext(85)
        student.onNext(charlotter)
        charlotter.score.onNext(95)
        ryan.score.onNext(99)
        
    }
    
    fileprivate func flatmapLastExample(){
        let ryan = Student(score: BehaviorSubject(value: 80))
        let charlotter = Student(score: BehaviorSubject(value: 70))
        let student = PublishSubject<Student>()
        student.flatMapLatest {
            $0.score
            }.subscribe(onNext: {
                print($0)
            }).disposed(by: bag)
        
        student.onNext(ryan)
        ryan.score.onNext(91)
        student.onNext(charlotter)
        charlotter.score.onNext(92)
        ryan.score.onNext(93)
        charlotter.score.onNext(94)
        
    }
    
}



