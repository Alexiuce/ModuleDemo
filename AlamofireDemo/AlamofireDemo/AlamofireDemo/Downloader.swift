//
//
// Downloader.swift
// Created by Alex on 2018/5/9
// Copyright © 2018年 alexiuce.github.io. All rights reserved.

//

import Foundation


class Downloader: NSObject {
    
    
    func start() {
        let urlString = "http://www.baidu.com"
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        /** NSFileHandle   & NSOutputSteam */
       
        //let fh =  FileHandle(forWritingAtPath: "")   /**文件不存在时, 返回nil */
        var buffer = [UInt8](repeating: 0, count: 1024)
        let os = OutputStream(toBuffer: &buffer, capacity: 1024)
        
        print(os.delegate ?? "nil")
        print(os)
        
        let fos = OutputStream(toFileAtPath: "", append: true)
        fos?.open()
        
        let data = Data()
        _ = data.withUnsafeBytes { bytes in
            fos?.write(bytes, maxLength: data.count)
        }
        
        
        let configuration = URLSessionConfiguration.background(withIdentifier: "abc")
        
        configuration.isDiscretionary = true
        
        let session = URLSession(configuration:configuration, delegate: self, delegateQueue: OperationQueue.current)
        
        session.dataTask(with: request)
        
        
    }
    
}

extension Downloader: URLSessionDataDelegate{
    
    fileprivate func compareLocalFileWithRemoteFile() -> Bool{
        let filepath = ""
        let fm = FileManager.default
        if !fm.fileExists(atPath: filepath) {
            return false
        }
        
        do {
        
            let attr = try fm.attributesOfFileSystem(forPath: filepath)
            print(attr)
            
        } catch {
            print(error.localizedDescription)
        }
        
        
        return false
    }
}
