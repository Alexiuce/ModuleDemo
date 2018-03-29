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


class ViewController: NSViewController {
    
    
    @IBOutlet weak var wevView: WebView!
    

    var myCookie = " _redmine_session=BAh7DCIKY3RpbWVsKwd%2FLLtaIg9zZXNzaW9uX2lkIiU0ZmE5ODA5M2ZjN2RhOTViZDEzMzA2MWVkZTg2M2FhYSIKcXVlcnl7CToPcHJvamVjdF9pZGkPOhFjb2x1bW5fbmFtZXMwOg1ncm91cF9ieSIAOgxmaWx0ZXJzewciE2Fzc2lnbmVkX3RvX2lkewc6C3ZhbHVlc1sGIgdtZToNb3BlcmF0b3IiBj0iDnN0YXR1c19pZHsHOwlbBiIAOwoiBm8iEF9jc3JmX3Rva2VuIjFUeGF0Umg0clFIaTNmemd2Und6VGl3VHdRb1YrQ0MzdE5GZ0FaL2hVVGlnPSIMdXNlcl9pZGk7IhZpc3N1ZXNfaW5kZXhfc29ydCIMaWQ6ZGVzYyIKYXRpbWVsKweJW7xa--11a8b0abbb6817896aca3e9b4ee5d63e6943a033"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WKWebView
       
        let url =  URL(string: "http://www.163.com")!
        let request = URLRequest(url: url)
        
        
        wevView.mainFrame.load(request)
        
        /** Swift 关键字
         @discardableResult  : 表示可以不使用一个方法的返回值 而不会提示警告信息
         internal(set)  : 表示set方法的访问级别是internal
         associatedtype : 在协议中用来表示一个范型 ,在协议的具体实现中才会确定数据的具体类型(相当于在协议中的一个类型的占位符)
         协议扩展的作用:  1.为协议中的方法提供一个默认的实现 , 2.添加额外的实现
         
         mutating :用来修饰协议中的方法 Swift中的协议不仅可以被class实现,也可以被struce和enmu实现,使用mutating关键字是为了能够让struc或者enum可以在被修饰的方法中修改自己的变量,这个关键字对class是透明的(因为class可以随意修改自身的属性)
         
         where : 在协议扩展中,用来限制协议仅仅能够被某个类(或其子类)遵守. 例下:
                 extension YourProcotol where Self : UIViewController {    // 仅仅能够被UIViewController 实现
                         func yourFunc() {
                         view.backgroundColor = UIColor.red
                         }
                 }
         */
    
        
        
    }

}

extension ViewController{
    
    fileprivate func af_used(){
        request(WEB_URL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: ["Cookie":myCookie])
            .responseString { (response) in
//                response.response?.allHeaderFields
                print(response)
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
}

