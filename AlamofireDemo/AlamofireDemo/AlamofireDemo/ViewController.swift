//
//  ViewController.swift
//  AlamofireDemo
//
//  Created by caijinzhu on 2018/3/28.
//  Copyright © 2018年 alexiuce.github.io. All rights reserved.
//

import Cocoa
import Alamofire
import SwiftyJSON


fileprivate let WEB_URL: String = "http://192.168.0.201:3000/projects/app/issues"


class ViewController: NSViewController {
    
    
    

    var myCookie = " _redmine_session=BAh7DCIKY3RpbWVsKwd%2FLLtaIg9zZXNzaW9uX2lkIiU0ZmE5ODA5M2ZjN2RhOTViZDEzMzA2MWVkZTg2M2FhYSIKcXVlcnl7CToPcHJvamVjdF9pZGkPOhFjb2x1bW5fbmFtZXMwOg1ncm91cF9ieSIAOgxmaWx0ZXJzewciE2Fzc2lnbmVkX3RvX2lkewc6C3ZhbHVlc1sGIgdtZToNb3BlcmF0b3IiBj0iDnN0YXR1c19pZHsHOwlbBiIAOwoiBm8iEF9jc3JmX3Rva2VuIjFUeGF0Umg0clFIaTNmemd2Und6VGl3VHdRb1YrQ0MzdE5GZ0FaL2hVVGlnPSIMdXNlcl9pZGk7IhZpc3N1ZXNfaW5kZXhfc29ydCIMaWQ6ZGVzYyIKYXRpbWVsKweJW7xa--11a8b0abbb6817896aca3e9b4ee5d63e6943a033"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        request(WEB_URL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: ["Cookie":myCookie])
            .responseString { (response) in
                response.response?.allHeaderFields
            print(response)
        }
        
    
        
    }

}

extension ViewController{
    
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

