//
//  NetWorkTools.swift
//  SinaWeibo
//
//  Created by mac on 2017/12/14.
//  Copyright © 2017年 modi. All rights reserved.
//

import AFNetworking

private let domain = "com.modi.app.ErrorDomain"
private let hostname = "https://api.weibo.com/"

//定义网络请求方式
enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
}

class NetWorkTools: AFHTTPSessionManager {
    //定义共享单例
    static let sharedTools: NetWorkTools = {
        let url = NSURL(string: hostname)
        let tool = NetWorkTools(baseURL: url as! URL)
        //设置解析数据类型：新版不设置也可以
        tool.responseSerializer.acceptableContentTypes?.insert("taxt/pain")
        return tool
    }()
    
    //定义网络访问方法：以后所有网络访问都经过该方法：管理网络访问
    func requestJsonDict(method: HTTPMethod, urlString: String, params: [String : Any]?, finished: @escaping (_ result: [String : Any]?, _ error: NSError?) -> ()) {
        //调用AFN实现具体的GET、POST请求
        if method == .GET {
            get(urlString, parameters: params, progress: nil, success: { (_, result) in
                //判断是否是字典
                if let dict = result as? [String : Any] {
                    finished(dict, nil)
                    return
                }
                //自定义错误信息：数据格式不对 : errorCode = -1000 :自定义错误码一般取负值
                let dataError = NSError(domain: domain, code: -1000, userInfo: [NSLocalizedDescriptionKey : "数据格式不匹配"])
                finished(nil, dataError)
            }, failure: { (_, error) in
                finished(nil, error as NSError)
                debugPrint("error = \(error)")
            })
        }else {
            post(urlString, parameters: params, progress: nil, success: { (_, result) in
                //判断是否是字典
                if let dict = result as? [String : Any] {
                    finished(dict, nil)
                    return
                }
                //自定义错误信息：数据格式不对 : errorCode = -1000 :自定义错误码一般取负值
                let dataError = NSError(domain: domain, code: -1000, userInfo: [NSLocalizedDescriptionKey : "数据格式不匹配"])
                finished(nil, dataError)
            }, failure: { (_, error) in
                finished(nil, error as NSError)
                debugPrint("error = \(error)")
            })
        }
    }
}
