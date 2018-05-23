//
//
// HomeController.swift
// Created by Alex on 2018/5/23
// Copyright © 2018年 alexiuce.github.io. All rights reserved.

//

import UIKit
import WebKit

class HomeController: UIViewController {

    
    var webView: WKWebView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: view.bounds, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.backgroundColor = UIColor.darkGray
        view.addSubview(webView)
        
        let url = URL(string: "https://www.baidu.com")!
        let request = URLRequest(url: url)
        webView.load(request)
        
    }
    

}


extension HomeController: WKUIDelegate{
    
}
