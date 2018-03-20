//
//  ApiController.swift
//  6.1Demo
//
//  Created by caijinzhu on 2018/3/20.
//  Copyright © 2018年 alexiuce.github.io. All rights reserved.
//

import Foundation
import RxSwift


struct Weather {
    let cityName: String
    let temperature: Int
    let humidity: Int
    let icon: String
    
    
    
}

class ApiController {
    static let share = ApiController()
    func currentWeather(city: String) -> Observable<Weather> {
        return Observable.just(Weather(cityName: city, temperature: 20, humidity: 20, icon: "01"))
    }
}
