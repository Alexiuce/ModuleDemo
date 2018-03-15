//
//  ViewModel.swift
//  XCWeather
//
//  Created by caijinzhu on 2018/3/15.
//  Copyright © 2018年 alexiuce.github.io. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources


class ViewModel: NSObject {
    
    func getPersons() -> Observable<[SectionModel<String,Person>]> {
        return Observable.create({ (observer) -> Disposable in
            let persons = [Person(name: "alex", age: 20, language: "CN"),
                          Person(name: "xiuce", age: 21, language: "EN"),
                          Person(name: "leio", age: 22, language: "CN"),
                          Person(name: "good", age: 23, language: "CN"),
                          Person(name: "job", age: 24, language: "CN"),
                          Person(name: "jack", age: 25, language: "CN"),
                          Person(name: "piple", age: 26, language: "CN")
                           ]
            let section = [SectionModel(model: "", items: persons)]
            observer.onNext(section)
            observer.onCompleted()
            return Disposables.create()
            
        })
    }
}
