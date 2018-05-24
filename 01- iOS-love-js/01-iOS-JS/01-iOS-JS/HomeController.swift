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
//        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.backgroundColor = UIColor.darkGray
        view.addSubview(webView)
        
        let url = URL(string: "https://www.baidu.com")!
        let request = URLRequest(url: url)
        webView.load(request)
        print("\(#file):\(#function)")
        
    }
    

}

extension HomeController: WKNavigationDelegate{
    /** 每次加载一个url页面时, 会调用这个代理方法询问是否可以加载: 相当于UIWebView 的 shouldStartLoadWithRequest:
      如果这个方法返回.allow 则开始调用 didStartProvisionalNavigation 代理方法,通知代理现在webView已经开始请求加载页面
     */
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        print(navigationAction.request.description)
        print("actin ========")
        decisionHandler(.allow)
    }
    /** 每次请求url获得响应后, 会调用这个代理方法进行询问是否加载响应页面: 这里可以获得响应的相关信息
     * 这个方法返回.allow后,会调用 didCommit 这个代理方法,通知代理现在webView已经获取到了页面内容
     */
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        print(navigationResponse.response.description)
        print("response:--------")
        decisionHandler(.allow)
    }
    /** webView 开始向服务器请求获取需要加载页面内容 */
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("did start provision navigation")
    }
    /** webView 已经获得服务器返回的数据内容 */
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("did commit")
    }
    /** webView 已经完成数据内容的加载 */
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("did finish")
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("did fail provision " + error.localizedDescription)
        
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("didFail" + error.localizedDescription)
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print("did receive server redirect" + navigation.description)
    }
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        print("did content process did terminate")
        
    }
    
    /** 使用https时,会调用这个代理方法,处理关于证书校验的工作,这个方法是在didStartProvisionalNavigation被调用后执行 */
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        var credential: URLCredential? = nil
        if let trust = challenge.protectionSpace.serverTrust {
            credential = URLCredential(trust: trust)
        }
        
        print("did receive challenge" + challenge.protectionSpace.authenticationMethod)
       
        completionHandler(.useCredential, credential)
    }
    
}


//extension HomeController: WKUIDelegate{
//
//}
