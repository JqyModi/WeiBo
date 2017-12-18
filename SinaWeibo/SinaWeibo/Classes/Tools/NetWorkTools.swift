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
//        application/x-www-form-urlencoded
//        multipart/form-data; boundary=********
//        text/plain
//        text/xml

        
        //默认
//        - `application/json`
//        - `text/json`
//        - `text/javascript`
        //新增
//        - `application/x-www-form-urlencoded`
//        - `multipart/form-data; boundary=********`
//        - `text/plain`
//        - `text/xml`
//        - `text/html`
        
        tool.responseSerializer.acceptableContentTypes?.insert("application/x-www-form-urlencoded")
        tool.responseSerializer.acceptableContentTypes?.insert("multipart/form-data; boundary=********")
        tool.responseSerializer.acceptableContentTypes?.insert("text/plain")
        tool.responseSerializer.acceptableContentTypes?.insert("text/xml")
        tool.responseSerializer.acceptableContentTypes?.insert("text/html")
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
    
    //上传图片方法
    func uploadImage(urlStr: String, params: [String : Any]?, imageData: Data, finished: @escaping (_ retult: [String : Any]?, _ error: Error?) -> ()) {
        
//        self.responseSerializer = AFJSONResponseSerializer()
//        self.requestSerializer.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Accept")
        //上传文件到服务器
        post(urlStr, parameters: params, constructingBodyWith: { (multipartFromData) in
            /// data: 要上传的文件数据
            /// name: 上传的服务器对应的字段
            /// fileName: 服务器上存储的名称
            /// mimeType: 上传文件格式 : image/jpeg
            multipartFromData.appendPart(withFileData: imageData, name: "pic", fileName: "OMG", mimeType: "image/jpeg")
        }, progress: nil, success: { (_, result) in
            if let rs = result as? [String : Any] {
                finished(rs, nil)
            }
        }) { (_, error) in
            debugPrint("error = \(error)")
            finished(nil, error)
        }
    }
}
