//
//  ViewController.swift
//  RxSwiftMac01
//
//  Created by caijinzhu on 2018/3/5.
//  Copyright © 2018年 alexiuce.github.io. All rights reserved.
//

import Cocoa
import RxSwift

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        example(of: "never") {
            let disposeBag = DisposeBag()
            Observable<String>.never().do(onNext: { (text) in
                
            }, onError: { (error) in
                print("error")
            }, onCompleted: {
                print("complete")
            }, onSubscribe: {
                print("subscribe")
            }, onSubscribed: {
                print("subscribed ....")
            }, onDispose: {
                print("dispose....")
            }).subscribe({ (event) in
                print(event)
            }).disposed(by: disposeBag)
        }
        
        
        example(of: "just,of,from") {
            let one = 1
            let two = 2
            let three = 3
            /** observable method : just, of, from
             *  observable subscribe
             */
            let observable = Observable.of(one,two,three)
            _ = observable.subscribe(onNext: { (element) in
                print(element)
            })
        }
        /** empty observable */
        
        example(of: "Empty") {
            let emptyObservable = Observable<Void>.empty()
            _ =  emptyObservable.subscribe(onNext: { (element) in
                print("on next \(element)")
            }, onError: { (error) in
                print("\(error.localizedDescription)")
            }, onCompleted: {
                print("compeleted....")
            }, onDisposed: nil)
        }
        
        
        
        example(of: "Range") {
            let observable = Observable<Int>.range(start: 1, count: 10)
             _ = observable.subscribe(onNext: { (element) in
                let n = Double(element)
                let fibonacci = Int(((pow(1.61803, n) - pow(0.61803, n)) / 2.23606 ).rounded())
                print(fibonacci)
            })
        }
        
        example(of: "dispose") {
            let observable = Observable.of("a","b","c")
            let subscription = observable.subscribe({ (event) in
                print(event)
            })
            subscription.dispose()
        }
        
        example(of: "disposeBag") {
            let disposeBag = DisposeBag()
            Observable.of("a","b","c","d").subscribe{
                print($0)
            }.disposed(by: disposeBag)
        }
        
        example(of: "create") {
            let disposeBag = DisposeBag()
            
            enum MyError: Error {
                case myError
            }
            
            Observable<String>.create({ (observer) -> Disposable in
                observer.onNext("01")
                observer.onError(MyError.myError)
                observer.onCompleted()
                return Disposables.create()
            }).subscribe(onNext: { (value) in
                print(value)
            }, onError: { (error) in
                print("error ~~~")
            }, onCompleted: {
                print("complete")
            },onDisposed: {
                print("disposed")
            }).disposed(by: disposeBag)
            
        }
        
        example(of: "deferred") {
            let disposeBag = DisposeBag()
            var flip = false
            let factory: Observable<Int> = Observable.deferred{
                flip = !flip
                if flip {
                    return Observable.of(1,2,3)
                }else{
                    return Observable.of(4,5,6)
                }
            }
            
            for _ in 0...3 {
                factory.subscribe(onNext: { (value) in
                    print(value, terminator: "")
                }).disposed(by: disposeBag)
                print()
            }
        }
        
        example(of: "Single") {
            let disposeBag = DisposeBag()
            enum FileReadError: Error {
                case fileNotFound,unreadable,encodingFailed
            }
            
            func loadText(from name: String) ->Single<String> {
                return Single.create { single in
                    let disposable = Disposables.create()
                    guard let path = Bundle.main.path(forResource: name, ofType: "txt") else{
                        single(.error(FileReadError.fileNotFound))
                        return disposable
                    }
                    guard let data = FileManager.default.contents(atPath: path) else{
                        single(.error(FileReadError.unreadable))
                        return disposable
                    }
                    guard let contents = String(data: data, encoding: String.Encoding.utf8) else{
                        single(.error(FileReadError.encodingFailed))
                        return disposable
                    }
                    
                    single(.success(contents))
                    return disposable
                }
            }
            
            
            loadText(from: "Copyright").subscribe{
                switch $0 {
                case .success(let text):
                    print(text)
                case .error(let error):
                    print(error)
                }
            }.disposed(by: disposeBag)
        }
        
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

