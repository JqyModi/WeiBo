//
//  ViewController.swift
//  Socket_QQ
//
//  Created by mac on 2017/12/27.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ipTextField: UITextField!
    @IBOutlet weak var msgTextField: UITextField!
    @IBOutlet weak var portTextField: UITextField!
    
    var client: Int32?
    var sockaddr1: sockaddr?
    var server: sockaddr_in?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSocket()
        
    }
    
    private func initSocket() {
        
        // Socket 代码!
        
        // 1.创建客户端 Socket
        
        // 2.创建服务器 Socket
        
        // 3.连接两个 Socket
        
        // 4.客户端 Socket 发送信息给服务器!(发送请求的过程)
        
        // 5.服务器响应客户端的请求,返回给客户端数据!
        
        // 6.接受服务器返回的数据!
        
        // 7.关闭Socket.
        
        /*
         参数1:socket遵循的协议
         参数2:socket通信端口类型：TCP/UDP : SOCK_STREAM/SOCK_DGRAM [流/数据报]
         参数3:选择的协议类型! 一般传0 会根据第二个参数自动选择协议类型!
         */
        client = socket(AF_INET, SOCK_STREAM, 0)
        debugPrint("客户端创建结果（client>0表示创建成功）：\(client)")
        server = sockaddr_in()
        //设置服务端遵循协议类型
        server?.sin_family = sa_family_t(AF_INET)
        //设置服务端IP地址
        server?.sin_addr.s_addr = inet_addr(ipTextField.text)
        //设置服务端端口号
        server?.sin_port = in_port_t(portTextField.text!)!
        
//        sockaddr1 = server as! sockaddr
//        server.sin_port = htons(12345)
        var returnCode = Darwin.connect(client!, &sockaddr1!, socklen_t(server?.sin_len))
        if returnCode == 0 {
            debugPrint("连接成功 ~")
        }
    }

    @IBAction func connect(_ sender: UIButton) {
//        let returnCode = Darwin.connect(client!, &sockaddr1!, socklen_t(sockaddr1?.sa_len))
//        if returnCode = 0 {
//            debugPrint("连接成功 ~")
//        }
    }
    
    @IBAction func send(_ sender: UIButton) {
        
    }

}

