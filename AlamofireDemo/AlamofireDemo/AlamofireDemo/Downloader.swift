//
//
// Downloader.swift
// Created by Alex on 2018/5/9
// Copyright © 2018年 alexiuce.github.io. All rights reserved.

//

import Foundation


class Downloader: NSObject {
    
    
    func start() {
        let urlString = ""
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        /** NSFileHandle   & NSOutputSteam */
       
        //let fh =  FileHandle(forWritingAtPath: "")   /**文件不存在时, 返回nil */
        //var buffer = [UInt8](repeating: 0, count: 1024)
        //let os = OutputStream(toBuffer: &buffer, capacity: 1024)
        let fos = OutputStream(toFileAtPath: "", append: true)
        fos?.open()
        
        let data = Data()
        _ = data.withUnsafeBytes { bytes in
            fos?.write(bytes, maxLength: data.count)
        }
        
        
        
        let session = URLSession(configuration: URLSessionConfiguration.background(withIdentifier: "bgk"), delegate: self, delegateQueue: OperationQueue.current)
        session.dataTask(with: request)
        
    }
    
}

extension Downloader: URLSessionDataDelegate{
    
    
}
