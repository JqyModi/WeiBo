//
//  OAuthViewController.swift
//  SinaWeibo
//
//  Created by mac on 2017/12/8.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit
import AFNetworking
import SVProgressHUD

private struct OConstants {
    static let SinaBaseUrl = "https://api.weibo.com/"
    //请求授权码URL
    static let codeBaseUrl = SinaBaseUrl + "oauth2/authorize"
    static let tokenBaseUrl = SinaBaseUrl + "oauth2/access_token"
    static let userInfoUrl = SinaBaseUrl + "2/users/show.json"
    
    static let ClientIDKey = "client_id"
    static let RedirectUrlKey = "redirect_uri"
    static let client_id = "4090434754"
    static let client_secret = "e05466cab537175d1ec28314154bd160"
    static let redirect_uri = "http://39.108.219.113/Music/index.html"
}
class OAuthViewController: UIViewController {
    
    
    @objc private func close() {
        dismiss(animated: true, completion: nil)
    }
    @objc private func fullAccount() {
        let jsStr = "document.getElementById('userId').value = '15676832968',document.getElementsByClassName('input_note')[0].value = '', document.getElementById('passwd').value = 'siri.com'"
        //执行js代码
        webView.stringByEvaluatingJavaScript(from: jsStr)
    }
    
    var webView = UIWebView()
    
    override func loadView() {
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //添加返回导航
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: "close")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", style: .plain, target: self, action: "fullAccount")
        webView.delegate = self
        loadOAuthPage()
    }

    func loadOAuthPage() {
        let urlStr = Constants.codeBaseUrl + "?" + Constants.ClientIDKey + "=" + Constants.client_id + "&" + Constants.RedirectUrlKey + "=" + Constants.redirect_uri
        let url = URL(string: urlStr)
        let request = URLRequest(url: url!)
        webView.loadRequest(request)
    }
}

extension OAuthViewController: UIWebViewDelegate {
    //监控WebView的请求：request
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        //过滤不需要的请求
        //定义urlStr并判断是否为空
        guard let urlStr = request.url?.absoluteString else {
            return false
        }
        if urlStr.hasPrefix(Constants.codeBaseUrl) {
            return true
        }
        //过滤掉非code请求操作
        if !urlStr.hasPrefix(Constants.redirect_uri) {
            return false
        }
        //1.截取code码：用户授权码
        //遍历URL中参数列表
        //code=4101507e6de3516af19f8708dbf780a3
        let param = request.url?.query
        //构造出要截取的位置的Index
        let codeStr = "code="
        let code = param?.substring(from: codeStr.endIndex)
        UserAccountViewModel().loadAccessToken(code: code!) { (error) in
            debugPrint("finished~~~")
            if error != nil {
                SVProgressHUD.showInfo(withStatus: "网络君正在睡觉💤请稍后再来~~·")
                return
            }
            
            self.dismiss(animated: true, completion: nil)
        }
        return true
    }

}
