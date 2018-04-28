//
//
// ViewController.swift
// Created by Alex on 2018/4/24
// Copyright © 2018年 alexiuce.github.com. All rights reserved.

//

import Cocoa

import PromiseKit




class ViewController: NSViewController {
    
    
    lazy var globeOperationQueue: OperationQueue = {
        return OperationQueue()
    }()
    
    lazy var photes = [String]()
    
    var t: DispatchSourceTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let op = XCOperation()
        
        globeOperationQueue.addOperation(op)
        
    }
    
    
    @IBAction func clickButton(_ sender: Any) {
        
//       opExample1()
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
        /* 效果与上一行相同 */
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

    fileprivate func gcd_example3(){
        let globle_queue = DispatchQueue.global()    // 并发全局队列
        
        globle_queue.async {
            print("\(Thread.current)")
        }
        
    }


    fileprivate func gcd_example4(){

        
        let queue = DispatchQueue(label: "concurrentQueue", attributes: .concurrent)
        
        
//        queue.async {
//            print("Login()")
//        }
//        queue.async {
//            print("CheckName()")
//        }
//        queue.async {
//            print("PayMoney()")
//        }
//        queue.async {
//            print("GetInfo()")
//        }
        
        
        
        let globle_queue = DispatchQueue(label: "conqueue", attributes: .concurrent)
        for i  in 0...10 {
            //DispatchQueue.global()    /** 全局并发队列 不支持barrier */
    
            
            
            globle_queue.async {
                print("asy \(i)")
            }
            globle_queue.sync(flags:.barrier) {
                print("syn \(i) \(Thread.current)")
            }
            
            
            globle_queue.async {
                print("after 1")
            }
            globle_queue.async {
                print("after 2")
            }
            globle_queue.async {
                print("after 3")
            }
            
            /**  没有.barrier的效果
            globle_queue.sync {
                print("syn \(i) \(Thread.current)")
            }
             */
            
            
        }
        
        
        for i in 0..<10 {
            queue.async {
                print("\(i) \(Thread.current)")
            }
            
            queue.sync(flags:.barrier , execute: {
                 self.photes.append("\(i)")
            })

            
            
        }
        
      
        
    }

    fileprivate func gcd_example5(){
      
        DispatchQueue.global().asyncAfter(deadline:.now() + 3) {
            print("after....")
        }
        
    }

    fileprivate func gcd_example6() {
        
        
        
        let queue = DispatchQueue.global()
        
        let group = DispatchGroup()
        
        queue.async(group: group, qos: .default, flags: []) {
            print("one")
        }
        queue.async(group: group, qos: .default, flags:[]) {
            print("two")
        }
        queue.async(group: group, qos: .default, flags: []) {
            print("three")
        }
        queue.async(group: group, qos: .default, flags: []) {
            print("four")
        }
        group.notify(queue: queue) {
            
            print("finished \(Thread.current)")
        }
    
    }

    fileprivate func gcd_example7(){  /** 手动计数  每个任务并不是顺序完成的..*/
        let queue = DispatchQueue.global()
        let group = DispatchGroup()
        group.enter()
        queue.async(group: group, qos: .default, flags: []) {
            print("one...")
            group.leave()
        }
        group.enter()
        queue.async(group: group, qos: .default, flags: []) {
            print("two...")
            group.leave()
        }

        group.enter()
        queue.async(group: group, qos: .default, flags: []) {
            print("three...")
            group.leave()
        }

        group.enter()
        queue.async(group: group, qos: .default, flags: []) {
            print("four...")
            group.leave()
        }
        group.notify(queue: .main) {
            print("\(Thread.current) over")
        }

        
    }


    fileprivate func gcd_example8(){
        
        let queue = DispatchQueue.global()
        let semaphore = DispatchSemaphore(value: 3)   /* 初始化信号计量 */
        
        for i in 0...10 {
            print("====\(i)")
            semaphore.wait()    /* 当前信号计量-1 ,如果为0 ,则阻塞当前线程 */
            
            queue.async {
                print("\(i)")
                sleep(3)
                semaphore.signal()  /* 信号计量+1 */
            }
            
            
        }
        
    }

    fileprivate func gcd_example9(){
        
        let queue = DispatchQueue.global()
        t = DispatchSource.makeTimerSource(flags: [], queue: queue)
    
        /* leeway : 时间误差容忍度, 例如  +100 ~ -100 */
        t.schedule(deadline:.now(), repeating:DispatchTimeInterval.seconds(1), leeway: DispatchTimeInterval.milliseconds(100))
        
        
        t.setEventHandler {
            print("tim....er....")
        }
        
        t.resume()
    }


}

// MARK : NSOperater Example
extension ViewController{
    fileprivate func opExample1(){
        // 创建操作
       let op1 = BlockOperation {
            print("downloading...")
        }
    
        let op2 = BlockOperation {
            print("unzip....")
        }
        let op3 = BlockOperation{
            print("fininshed...")
        }
        
        
        /* 设置依赖*/
        
        op3.addDependency(op2)
        op2.addDependency(op1)
        
//        globeOperationQueue.addOperation(op1)
//        globeOperationQueue.addOperation(op2)
//        globeOperationQueue.addOperation(op3)
        /* 添加操作到队列 */
        globeOperationQueue.addOperations([op1,op3,op2], waitUntilFinished: false)
        
        
    }
}

