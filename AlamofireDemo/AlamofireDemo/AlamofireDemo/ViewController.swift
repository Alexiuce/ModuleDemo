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
        
        request("https://httpbin.org/get", method: .get, parameters: ["id":"100"], encoding: URLEncoding.default, headers: nil).validate(statusCode: [200]).responseJSON {
            guard let value = $0.value else {return}
            let json = JSON(value)
            print(json["args"]["id"].intValue)
        }
    
        
    }

}

extension ViewController{
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

