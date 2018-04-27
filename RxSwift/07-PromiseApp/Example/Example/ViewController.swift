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

            gcd_example2()
         
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
    @IBAction func clickButton(_ sender: Any) {
        
        example5()
    }
    
    
}


// MARK: - Promise Example
extension ViewController{
    fileprivate func getApi() -> Promise<String> {
        
        return Promise{ cb in
            
            cb.fulfill("result======")
            }
        
    }
    
    fileprivate func getUserAge() -> Promise<Int>{
        return Promise{
            $0.fulfill(20)
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
    
    fileprivate func example2(){
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
    
    fileprivate func example3(){
        firstly {
            getApi()
            }.then(on: DispatchQueue.global()) { (apiResult) -> Promise<String> in
                print(Thread.current)
                return self.getWeather(latitude: 23, longitude: 333.5)
            }.done(on: DispatchQueue.global(), { (s) in
                print("\(s) : \(Thread.current)")
            }).ensure({
                print("ensure")
            })
            .catch { (e) in
                print(e.localizedDescription)
        }
    }
    
    fileprivate func example4(){
        firstly {
            //           when(fulfilled: getApi(),getWeather(latitude: 33, longitude: 23423))
            when(resolved: getWeather(latitude: 33, longitude: 23),getApi())
            }.done { (res) in
                
                res.forEach({ (item) in
                
                    if case let Result.fulfilled(s) = item {
                        print(s)
                    }
                
//                    switch item {
//                    case let .fulfilled(s):
//                        print(s)
//                    case let .rejected(e):
//                        print("\(e)")
//                    }
                })
        }
        
    }
    
    fileprivate func fetch(completion: (String?, Error?) -> Void){
        completion("ok, fetch success",nil)
    }
    fileprivate func promisFetch() -> Promise<String>{
        
//        return Promise{fetch(completion: $0.resolve)}
        
        
        return Promise{ cb in
            fetch(completion: { (res, err) in
                if err == nil{
                    cb.fulfill(res!)
                }else{
                    cb.reject(err!)
                }
            })
        }
    }
    
    fileprivate func example5() {
       
        /** get as a done that returns the value fed to get. */
        promisFetch().get{
            print("get \($0)")
        }.done { (result) in
            print(result)
        }.catch {
            print("\($0)")
        }
        
    }
    
    fileprivate func example6(){
        firstly {
            promisFetch()
            }.done { (result) in
                print(result)
            }.catch { (e) in
                print(e.localizedDescription)
        }
    }
    
    fileprivate func example7(){
        firstly {
            getApi()
            }.then { (str) -> Promise<Int> in
                print("srt == \(str)")
                return self.getUserAge()
            }.map{
                return $0 * 2
            }.compactMap({
                return $0 - 3
            })
            .done { (result) in
                print(result)
            }.catch {
                print($0.localizedDescription)
        }
    }

    
}

// MARK: - GCD Example

extension ViewController{
    fileprivate func gcd_example1(){

       let serial_queue = DispatchQueue(label: "serial_xxx")
        
        for i in 0...6 {
            
            serial_queue.async {
                print("\(i): \(Thread.current)")
            }
        }
        print("end ....")
        
    }
    
    
    fileprivate func gcd_example2(){
        /* 主线程 同步 会死锁 */
        let main_queue = DispatchQueue.main
        main_queue.sync {
            print("hello")
        }
    }
}



