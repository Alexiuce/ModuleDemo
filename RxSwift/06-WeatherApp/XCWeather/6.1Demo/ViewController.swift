//
//  ViewController.swift
//  6.1Demo
//
//  Created by caijinzhu on 2018/3/20.
//  Copyright © 2018年 alexiuce.github.io. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var cityLabel: UILabel!
    
    let disposeBag = DisposeBag()
    var cityName = Variable("")

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        cityName.asObservable().subscribe(onNext: {[weak self] in
//            guard let strongSelf = self else {return}
//            print($0)
//            strongSelf.cityLabel.text = $0
//        }).disposed(by: disposeBag)
        cityName.asObservable().bind(to: cityLabel.rx.text).disposed(by: disposeBag)
        cityName.value = "Hangzhou"
        
       
        
    }

}

extension ViewController{
    
    fileprivate func request(){
        let headers: HTTPHeaders = [
            "User-Agent" : "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/604.5.6 (KHTML, like Gecko) Version/11.0.3 Safari/604.5.6"
        ]
        Alamofire.request("http://ifconfig.me/ip",headers:headers).responseString { (response) in
            
            print(response.result.value ?? "error")
        }
    }
    
    fileprivate func driverExample(){
        ApiController.share.currentWeather(city: "hc")
            .flatMap {
                return Observable.of($0.cityName)
            }
            .asDriver(onErrorJustReturn: "hz")
            .drive(cityLabel.rx.text)
            .disposed(by: disposeBag)
    }
    fileprivate func insertExample(){
        var des = "Version"
        let startIndex = des.startIndex
        des.insert("-", at: des.index(startIndex, offsetBy: 4))
        des.insert(contentsOf: "hello", at: des.index(startIndex, offsetBy: 5))
        print(des)
    }
    
    fileprivate func progressViewExample(){
        let progressView = UIProgressView(frame: CGRect(x: 50, y: 200, width: 260, height: 40))
        progressView.trackTintColor = UIColor.red
        progressView.progress = 0.3
        view.addSubview(progressView)
    }
}



