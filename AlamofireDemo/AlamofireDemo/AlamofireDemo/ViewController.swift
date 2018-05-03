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



@_silgen_name("socket_connect") func swift_connect(host:UnsafePointer<Int8>,port:Int32) -> Int32

@_silgen_name("send") func swift_send(socket: Int32,data:UnsafePointer<Int8>,dataLength:size_t,flag:Int32) -> Int32


class ViewController: NSViewController {
    


    var myCookie = " _redmine_session=BAh7DCIKY3RpbWVsKwd%2FLLtaIg9zZXNzaW9uX2lkIiU0ZmE5ODA5M2ZjN2RhOTViZDEzMzA2MWVkZTg2M2FhYSIKcXVlcnl7CToPcHJvamVjdF9pZGkPOhFjb2x1bW5fbmFtZXMwOg1ncm91cF9ieSIAOgxmaWx0ZXJzewciE2Fzc2lnbmVkX3RvX2lkewc6C3ZhbHVlc1sGIgdtZToNb3BlcmF0b3IiBj0iDnN0YXR1c19pZHsHOwlbBiIAOwoiBm8iEF9jc3JmX3Rva2VuIjFUeGF0Umg0clFIaTNmemd2Und6VGl3VHdRb1YrQ0MzdE5GZ0FaL2hVVGlnPSIMdXNlcl9pZGk7IhZpc3N1ZXNfaW5kZXhfc29ydCIMaWQ6ZGVzYyIKYXRpbWVsKweJW7xa--11a8b0abbb6817896aca3e9b4ee5d63e6943a033"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestExample()
       
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
    fileprivate func socketExample3(){
        let clientSocket = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)
        var server = sockaddr_in()
        server.sin_family = sa_family_t(AF_INET)
        server.sin_addr.s_addr = inet_addr("192.168.0.133")
        server.sin_port = UInt16(49152).bigEndian
        
        withUnsafePointer(to: &server) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1, {
                let connectResult = connect(clientSocket, UnsafePointer($0), socklen_t(MemoryLayout<sockaddr>.size))
                
                print(connectResult)
                let sendText = "Hello..."
                var buffer: [UInt8] = [UInt8](repeating:0, count: 1024)
                DispatchQueue.global().async(execute: {
                    let recvCount = recv(clientSocket, &buffer, 1024, 0)
                    print(recvCount)
                    
                })
                let sendCount = send(clientSocket, sendText, sendText.count, 0)
                print(sendCount)
            })
        }
        
    }
    
    fileprivate func af_used(){
        request(WEB_URL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: ["Cookie":myCookie])
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
        
        /** 自定义url 转码字符集 : 对url中#符号进行转码 ,若为空,则仅对中文进行转码
         * 注意要取反.inverted ,否则会对字符集之外的所有字符进行转码
         */
        let myCharacterSet = CharacterSet(charactersIn: "#").inverted
        
        let urlString = "http://www.httpbin.org/get李?id=%100&name=章bb###<>[]{}".addingPercentEncoding(withAllowedCharacters:myCharacterSet)!
        
        /*
         * CharacterSet.urlHostAllowed: 被转义的字符有  "#%/<>?@\^`\{\|\}
         * CharacterSet.urlPathAllowed: 被转义的字符有  "#%;<>?[\]^`\{\|\}
         * CharacterSet.urlUserAllowed: 被转义的字符有   #%/<>?@\^`\{\|\}
         * CharacterSet.urlQueryAllowed: 被转义的字符有  "#%<>[\]^`\{\|\}
         * CharacterSet.urlPasswordAllowed 被转义的字符有 "#%/:<>?@[\]^`\{\|\}
         */
        let url = URL(string: urlString)!
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 7)
        request.addValue("def", forHTTPHeaderField: "abc")
        
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

