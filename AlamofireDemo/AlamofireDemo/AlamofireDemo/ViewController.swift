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

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request("https://httpbin.org/get", method: .get, parameters: ["id":"100"], encoding: URLEncoding.default, headers: nil).validate(statusCode: [200]).responseJSON {
            guard let value = $0.value else {return}
            let json = JSON(value)
            print(json["args"]["id"].intValue)
        }
        
        
        let uploadURL = URL(fileURLWithPath: "")
        upload(multipartFormData: { (formData) in
            
            formData.append(uploadURL, withName: "filem", fileName: "123.png", mimeType: "image/png")
        }, usingThreshold: <#T##UInt64#>, to: "uploadURL", method: .post, headers: nil) { (encodingResult) in
            switch encodingResult {
            case .success(let request, let streamingFromDisk, let streamFileURL):
                print("success")
            
                request.uploadProgress(closure: { (progress) in
                    print("\(progress.fractionCompleted)")
                })
            case .failure(_):
                print("error")
            }
        }
        
    }



}

