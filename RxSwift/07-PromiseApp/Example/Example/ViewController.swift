//
//
// ViewController.swift
// Created by Alex on 2018/4/24
// Copyright © 2018年 alexiuce.github.com. All rights reserved.

//

import Cocoa
import PromiseKit


class ViewController: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        firstly {
            getApi()
            }.then { (apiResult) -> Promise<String> in
                print(apiResult)
                return self.getWeather(latitude: 23.0, longitude: 33.5)
            }.done { (fulfill) in
                print(fulfill)
            }.catch { (e) in
                print(e.localizedDescription)
        }
        
        
        
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
    fileprivate func example1(){
        getApi()
            .then { apiResult -> Promise<String> in
                print(apiResult)
                return self.getWeather(latitude: 23.3, longitude: 33.2)
            }
            .done {
                print($0)
            }.catch { (e) in
                print(e.localizedDescription)
            
        }

    }
    
    
}


extension ViewController{
    fileprivate func getApi() -> Promise<String> {
        
        return Promise{ cb in
            cb.fulfill("result======")
            }
        
    }
    
    func getWeather(latitude: Double, longitude: Double) -> Promise<String> {
        return Promise { cb in
            let urlString = "http://httpbin.org/get?lat=\(latitude)&lon=\(longitude)"
            let url = URL(string: urlString)!
            let request = URLRequest(url: url)
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request) { data, response, error in
                if let data = data,
                    let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any]{
                    cb.fulfill(json.description)
                    
                } else if let error = error {
                    cb.reject(error)
                    
                } else {
                    let error = NSError(domain: "PromiseKitTutorial", code: 0,userInfo: [NSLocalizedDescriptionKey: "Unknown error"])
                    cb.reject(error)
                }
            }
            dataTask.resume()
        }
    }
    
    
}
