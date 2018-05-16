//
//  ViewController.swift
//  AlamofireDemo
//
//  Created by caijinzhu on 2018/3/28.
//  Copyright © 2018年 alexiuce.github.io. All rights reserved.
//

import Cocoa
import WebKit
import Alamofire
import SwiftyJSON


fileprivate let WEB_URL: String = "http://192.168.0.201:3000/projects/app/issues"

fileprivate let Boundary = "postBoundary"

@_silgen_name("socket_connect") func swift_connect(host:UnsafePointer<Int8>,port:Int32) -> Int32

@_silgen_name("send") func swift_send(socket: Int32,data:UnsafePointer<Int8>,dataLength:size_t,flag:Int32) -> Int32


class ViewController: NSViewController {
    
    @IBOutlet weak var pv: XCProcessView!
    
    @IBOutlet weak var textLabel: NSTextField!
    
    
    lazy var url_session : URLSession = {
        let c = URLSessionConfiguration.default
        /** 统一设置请求头/请求缓存/最大连接数/超时 */
        c.httpAdditionalHeaders = ["ua":"hello~"]
        let s = URLSession(configuration: c, delegate: self, delegateQueue: OperationQueue.main)
        return s
    }()
    
    var myCookie = " _redmine_session=BAh7DCIKY3RpbWVsKwd%2FLLtaIg9zZXNzaW9uX2lkIiU0ZmE5ODA5M2ZjN2RhOTViZDEzMzA2MWVkZTg2M2FhYSIKcXVlcnl7CToPcHJvamVjdF9pZGkPOhFjb2x1bW5fbmFtZXMwOg1ncm91cF9ieSIAOgxmaWx0ZXJzewciE2Fzc2lnbmVkX3RvX2lkewc6C3ZhbHVlc1sGIgdtZToNb3BlcmF0b3IiBj0iDnN0YXR1c19pZHsHOwlbBiIAOwoiBm8iEF9jc3JmX3Rva2VuIjFUeGF0Umg0clFIaTNmemd2Und6VGl3VHdRb1YrQ0MzdE5GZ0FaL2hVVGlnPSIMdXNlcl9pZGk7IhZpc3N1ZXNfaW5kZXhfc29ydCIMaWQ6ZGVzYyIKYXRpbWVsKweJW7xa--11a8b0abbb6817896aca3e9b4ee5d63e6943a033"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /** array slice */
        let arr = ["a","b","c","d","c","1","3"]
        arr.prefix(3).forEach { (r) in
            print(r)
        }
        let ja = arr.joined(separator: "!")
        print(ja)
        
        let a = Locale.preferredLanguages.prefix(6)
            .enumerated().map { index, languageCode in
            let quality = 1.0 - (Double(index) * 0.1)
            return "\(languageCode);q=\(quality)"
            }.joined(separator: ", ")
       print(a)
    }

    @IBAction func clickButton(_ sender: Any) {
        
        af_example1()
        
    }
}

// MARK: - UI function
extension ViewController{
    fileprivate func showProcess(){
        
        pv.process += 10
        
    }
    
}

/** Swift 关键字
 @discardableResult  : 表示可以不使用一个方法的返回值 而不会提示警告信息
 internal(set)  : 表示set方法的访问级别是internal
 associatedtype : 在协议中用来表示一个范型 ,在协议的具体实现中才会确定数据的具体类型(相当于在协议中的一个类型的占位符)
 协议扩展的作用:  1.为协议中的方法提供一个默认的实现 , 2.添加额外的实现
 
 mutating :用来修饰协议中的方法. Swift中的协议不仅可以被class实现,也可以被struce和enmu实现,使用mutating关键字是为了能够让struc或者enum可以在被修饰的方法中修改自己的变量,这个关键字对class是透明的(因为class可以随意修改自身的属性)
 
 where : 在协议扩展中,用来限制协议仅仅能够被某个类(或其子类)遵守. 例下:
 extension YourProcotol where Self : UIViewController {    // 仅仅能够被UIViewController 实现
 func yourFunc() {
 view.backgroundColor = UIColor.red
 }
 }
 
 */
/*
 
 request("http://localhost:3333/book", method: .post, parameters: ["name":"alexiuce","level":12],encoding: JSONEncoding.default).responseString { (response) in
 print(response.description)
 }
 */

// MARK: - Session & Socket
extension ViewController{
    fileprivate func urlsessionExample(){
        
        let session1 = URLSession.shared
        
        let url = URL(string: "http://www.baidu.com")!
        
        let request = URLRequest(url: url)
        session1.dataTask(with:  request) { (body, res, err) in
            
            guard let body = body else{return}
            let str = String(data: body, encoding: .utf8)!
            print("body:\(str)")
            }.resume()
    }
    
    fileprivate func socketExample(){
    
        let socketId = swift_connect(host: "127.0.0.1", port: 12345)
        print("socket id = \(socketId)")
        if socketId != -1 {
            let sendText = "this is a test from swift"
            let sendCount = swift_send(socket: socketId, data: sendText, dataLength: strlen(sendText), flag: 0)
        
            print(sendCount)
        }
    
    }
    fileprivate func socketExample2(){
        
        let clientSocket = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)
        var server = sockaddr_in()
        server.sin_family = sa_family_t(AF_INET)
        let port : UInt16 = 12345
        server.sin_port = port.bigEndian //CFSwapInt16BigToHost(port)
        server.sin_addr.s_addr = inet_addr("127.0.0.1")
        
        withUnsafePointer(to: &server) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1, { serptr in
                let result = connect(clientSocket, UnsafePointer(serptr), socklen_t(MemoryLayout<sockaddr_in>.size))
                print(result)
                
                let text = "hello..."
                let sendCount = send(clientSocket, text, text.count, 0)
                print(sendCount)
                
                var buffer: [UInt8] = [UInt8](repeating: 0, count: 4096)
                let recvCount = recv(clientSocket, &buffer, 4096, 0)
                let data = Data(bytes: buffer, count: recvCount)
                let recvText = String(data: data, encoding: .utf8)!
                print("receive \(recvText)")
                close(clientSocket)
            })
        }
    }
    fileprivate func socketExample3(){    /* 203.107.6.88 daytime server */
        let clientSocket = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP)
        var server = sockaddr_in()
        server.sin_family = sa_family_t(AF_INET)
        server.sin_addr.s_addr = inet_addr("203.107.6.88")
        server.sin_port = UInt16(123).bigEndian
        
        withUnsafePointer(to: &server) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1, {
                let connectResult = connect(clientSocket, UnsafePointer($0), socklen_t(MemoryLayout<sockaddr>.size))
                
                print(connectResult)
//                let sendText = "Hello..."
                
                DispatchQueue.global().async(execute: {
                    print("start...")
                    var buffer: [UInt8] = [UInt8](repeating:0, count: 1024)
                    let recvCount = recv(clientSocket, &buffer, 1024, 0)
                    print("waiting.....")
                    print(recvCount)

                })
//                let sendCount = send(clientSocket, sendText, sendText.count, 0)
//                print(sendCount)
            })
        }
        
    }
    
    fileprivate func af_example1(){
        
        
        /** base url */
        let host = "https://httpbin.org/v1/test/"        /** 如果有path 则必须以 / 结尾,否则baseurl不会记录最后的path路径 */
        let baseUrl = URL(string: host)
        let url = URL(string: "get", relativeTo: baseUrl)     /** url = https://httpbin.org/v1/test/get */
        print("URL : \(url?.absoluteString ?? "")")
        let url1 = URL(string: "/get", relativeTo: baseUrl)   /** url1 = https://httpbin.org/get */
        print("URL1 : \(url1?.absoluteString ?? "")")
        let url2 = URL(string: "https://www.baidu.com/", relativeTo: baseUrl)  /** url2 = https://www.baidu.com/ */
        print("URL2 : \(url2?.absoluteString ?? "")")
        
        /** Alamofire request have five response handle */
        
        let request = Alamofire.request("https://httpbin.org/get")
        request.responseJSON { (response) in
           
            print("Thread: \(Thread.current)")
            print("request: \(String(describing: response.request))")
            print("response: \(String(describing: response.response))")
            print("result: \(response.result)")
            print("error: \(response.error?.localizedDescription ?? "no error" )")
            
            if let json = response.result.value {
                print("JSON: \(json)")
            }
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8){
                print("utf8Text: \(utf8Text)")
            }
        }
        
        /**
        request.responseJSON(queue: DispatchQueue.main, options:.mutableLeaves) { (response) in
         
        }
         */
        
        
    }
    
    fileprivate func af_used(){
       Alamofire.request(WEB_URL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: ["Cookie":myCookie])
            .responseString { (response) in
                print(response.response?.allHeaderFields ?? "")
        }
    }
    
    fileprivate func af_example(){
        request("https://httpbin.org/get", method: .get, parameters: ["id":"100"], encoding: URLEncoding.default, headers: nil).validate(statusCode: [200]).responseJSON {
            guard let value = $0.value else {return}
            let json = JSON(value)
            print(json["args"]["id"].intValue)
        }
    }
    
    fileprivate func af_upload(){
        /** upload */
        
        let uploadURL = URL(fileURLWithPath: "")
        upload(multipartFormData: { (formData) in
            formData.append(uploadURL, withName: "filem", fileName: "123.png", mimeType: "image/png")
        }, to: "uploadURL", method: .post, headers: nil) { (encodingResult) in
            switch encodingResult {
            case .success(let request, _, _):
                print("success")
                request.uploadProgress(closure: { (progress) in
                    print("\(progress.fractionCompleted)")
                })
            case .failure(_):
                print("error")
            }
        }
    }
    fileprivate func af_download(){
        /** download */
        let downloader = download("url", to: DownloadRequest.suggestedDownloadDestination())
        
        if let downloadData = downloader.resumeData {
            download(resumingWith:downloadData)
        }
    }

    fileprivate func requestExample(){
        
        let urlString = "http://www.httpbin.org/post?id=123&name=alex"
        /** 自定义url 转码字符集 : 对url中#符号进行转码 ,若为空,则仅对中文进行转码
         * 注意要取反.inverted ,否则会对字符集之外的所有字符进行转码
         标准转码
         
         所有类型的URL中,"-_.~"都不应该被转码
        let myCharacterSet = CharacterSet(charactersIn: "#").inverted
        
        let urlString = "http://www.httpbin.org/get李?id-_~=%100&name=章bb###<>[]{}".addingPercentEncoding(withAllowedCharacters:myCharacterSet)!
        
         */
        /*
         * CharacterSet.urlHostAllowed: 被转义的字符有  "#%/<>?@\^`\{\|\}
         * CharacterSet.urlPathAllowed: 被转义的字符有  "#%;<>?[\]^`\{\|\}
         * CharacterSet.urlUserAllowed: 被转义的字符有   #%/<>?@\^`\{\|\}
         * CharacterSet.urlQueryAllowed: 被转义的字符有  "#%<>[\]^`\{\|\}
         * CharacterSet.urlPasswordAllowed 被转义的字符有 "#%/:<>?@[\]^`\{\|\}
         */
        let url = URL(string: urlString)!
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 7)
        /**
        application/x-www-form-urlencoded : 提交的数据存储在服务器端的表单字段中,
        application/json  application/xml  text/xml 等... post请求是,数据都是存储在服务器端的data字段中
         */
        
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let body = "hello from outside"
        request.httpBody = body.data(using: .utf8)
        let session = URLSession.shared
        session.dataTask(with: request) { (body, res, err) in
            /*
            guard let response = res as? HTTPURLResponse else {return}
            print(response.allHeaderFields)
             */
            
            guard let data = body , let result = String(data: data, encoding: .utf8) else {return}
            
            print(result)
            
            
            /**
             .mutableLeaves  : 容器可变类型
             .mutableContainers : 对象内部可以变 iOS7 后无效
             .allowFragments :  允许不是json格式的数据
             */
            guard let json = try? JSONSerialization.jsonObject(with: data, options:.allowFragments) else {return}
            
            print( type(of: json))
            /**
             
             PropertyListSerialization  : 解析plist 文件的类
             
             */
            
            
            
        }.resume()
        
    }

}

// MARK: - Request Example
extension ViewController{
    fileprivate func request_example(){
        
        let postUrl = URL(string: WEB_URL)!
        var requet = URLRequest(url: postUrl)
        requet.httpMethod = "POST"
        requet.setValue("multipart/form-data;boundary=\(Boundary)", forHTTPHeaderField: "Content-Type")
        
        var bodyData = Data()
        var contentText = "--\(Boundary)\r\n"
        contentText += "Content-Disposition: form-data; name=\"userfile\" "
        
        bodyData.append(contentText.data(using: .utf8)!)
        
      
        
        requet.httpBody = bodyData  /* 需要根据http协议拼接 二进制的body数据*/
        URLSession.shared.dataTask(with: requet) { (data, res, err) in
            
            }.resume()
        
    }
    
    fileprivate func jsonSerizalition_example(){
        
        /** */
        let p = Person()
        p.name = "alex"
        p.age = 20
        p.work = "dev"

        let pd = p.dictionaryWithValues(forKeys: ["name","age","work"])
        print(pd)
        print(p)
       
        print(String(format: "%0x", p.hash))
        
        /** */
        let jst = ["name":"tom", "age":18, "friends":["jobs","steven","gates","philer"]] as [String : Any]
        let jsd = try? JSONSerialization.data(withJSONObject: jst, options:.init(rawValue: 0))
        guard let jd = jsd else { return  }
        let jsr = String(data: jd, encoding:.utf8)
        print(jsr ?? "")
     
        /** */
        let urlString = "http://www.httpbin.org/get"
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
//        request.httpMethod = "post"
//        request.addValue("bytes=2-10", forHTTPHeaderField: "Range")
        
        URLSession.shared.dataTask(with: request) { (data, res, err) in
            guard  let data = data, let result = String(data: data, encoding: .utf8)  else {return}
            print("=======")
            print(result)
            
        }.resume()
        
    }
    
    fileprivate func redmineTest(){
        let urlString = "http://192.168.0.201:3000/issues.json"
        
        request(urlString).responseData { (response) in
            guard let data = response.data, let result = String(data: data, encoding: .utf8) else {return}
            print(result)
        }
    }
    fileprivate func session_example(){
        
        let url = URL(string: "http://www.httpbin.org/get")!
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            guard let d = data , let result = String(data: d, encoding: .utf8) else {return}
            print(result)
        }
        dataTask.resume()
    }
    
    fileprivate func session_downloadTask(){
        
        let url = URL(string: "http://www.httpbin.org/image/png")!
        
        let session = URLSession.shared
        let downloadTask = session.downloadTask(with: url) { (location, response, error) in
            print(location ?? "no ..")
            /** 下载后会保存为临时文件 ,并自动删除, 下载未完成,文件不会被删除
             获取下载进度需要使用delegate, 可以指定delegate的执行线程
             如果设置delegate 则session 不能使用回调block方式
             session.downloadTask(with: xxx)
             */
            
            /**压缩和解压缩 : SSZipArchive 第三方库 */
            
        }
        
        downloadTask.resume()
    }
    fileprivate func session_uploadTask(){
        /** URLSession 对delegate 强引用
         调用   session.invalidateAndCancel()  取消时 session将不能再使用,否则会crash
         session.finishTasksAndInvalidate()  : 等待任务完成后使session无效
         */
        
        let url = URL(string: "https://www.httpbin.org/post")!
        var request = URLRequest(url: url)
        request.httpMethod = "post"
        request.httpBody = "Test ok".data(using: .utf8)
       /**
        let session = URLSession(configuration:.default)
       
        let uploadTask = session.uploadTask(with: request, from: up_data) { (data, response, error) in
            guard let d = data, let result = String(data: d, encoding:.utf8) else {return}
            print(result)
        }
         */
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let body = data , let result = String(data: body, encoding: .utf8) else {return}
            print(result)
        }
        task.resume()
        
    }
    
    fileprivate func session_https(){
        let url = URL(string: "https://www.httpbin.org/post")!
        var request = URLRequest(url: url)
        request.httpMethod = "post"
        request.httpBody = "Test ok".data(using: .utf8)
        
        let task = url_session.dataTask(with: request) { (body, response, error) in
            guard let d = body , let result = String(data: d, encoding: .utf8) else {return}
            print(result)
        }
        task.resume()
    }
    
}



extension ViewController: URLSessionTaskDelegate{
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            completionHandler(.useCredential,credential)
        }
        
        
    }
}





































