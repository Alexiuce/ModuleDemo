//
//
// HomeController.swift
// Created by Alex on 2018/5/25
// Copyright © 2018年 alexiuce.github.io. All rights reserved.

//

import Cocoa
import WebKit

class HomeController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        let webView = WKWebView()
        webView.navigationDelegate = self
    }
    
}


extension HomeController: WKNavigationDelegate{
    
}
