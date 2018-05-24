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
        let userContent = WKUserContentController()
        userContent.add(self, name: "HFApp")
        /** 可以add 多个 js 交互对象名称, 实现js 对象名称与原生对象之间的映射关系 */
        //userContent.add(self, name: "AAA")
        
        webConfiguration.userContentController = userContent
        
        webView = WKWebView(frame: view.bounds, configuration: webConfiguration)
//        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.backgroundColor = UIColor.darkGray
        view.insertSubview(webView, at: 0)
        
        let url = URL(string: "https://www.baidu.com")!
        let request = URLRequest(url: url)
        webView.load(request)
        print("\(#file):\(#function)")
        
    }
    
    @IBAction func execJSfunction(_ sender: Any) {
//         webView.evaluateJavaScript("console.log(123)", completionHandler: nil)
        
        webView.evaluateJavaScript("console.log('hello js')") { (result, error) in
            print("=====begin complete ======")
            if let err = error {
                print("\(err.localizedDescription)")
            }
            if let res = result  {
                print(res)
            }
        }
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


/** JS 调用原生方法时 会执行这个代理方法 */
extension HomeController: WKScriptMessageHandler{
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.name)   /** js 与 原生交互时的中间对象名称 也就是 WKUserContentController add(obj, name: String) 中的name 参数值 */
        print(message.body)   /** 通常这个js传递来的参数用来进行操作区分以及携带相关数据 */
        
    }
}


//extension HomeController: WKUIDelegate{
//
//}
