//
//  XCBaseFoundationController.swift
//  Swift-UI
//
//  Created by Alexcai on 2018/10/17.
//  Copyright © 2018 Alexcai. All rights reserved.
//

import UIKit

class XCBaseFoundationController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var a: Array<Any> = [1,3,5,2,6]
        let b = a;
    
        _ = mySort(array: &a) { (beginIndex,nextIndex) -> Bool in
            
            (b[beginIndex] as! Int) > (b[nextIndex] as! Int)
        }
        
        a.forEach {
            print($0)
        }
        
    }

}


extension XCBaseFoundationController{
   fileprivate  func stringBaseMethodDemo()  {
        let originalString = "hello world"
        print(originalString.count)
        
        /**遍历*/
        originalString.forEach {
            print($0)
        }
        
        /* 子串*/
        let starIndex = originalString.index(originalString.startIndex, offsetBy: 3)
        let subString = originalString[starIndex..<originalString.endIndex]
        print(subString)
        
        /** 追加 */
        let newString = originalString.appending("not bad")
        print(newString)
        
        /** 替换 */
        let replaceString = originalString.replacingOccurrences(of: "hel", with: "Hel")
        print(replaceString)
        
    }
    
    
    /// 自定义数组排序: 支持存储任意对象的数组
    ///
    /// - Parameters:
    ///   - array: 需要排序的数组
    ///   - sortFunc: 排序算法
    /// - Returns: 排序好的数组
    fileprivate func mySort(array: inout Array<Any>, sortFunc:(Int,Int)->Bool) -> Array<Any> {
        for indexI in array.indices{
           
            if indexI == array.count - 1 {
                break
            }
            for indexJ in 0...(array.count - 1 - indexI - 1){
                if sortFunc(indexJ,indexJ + 1){
                    
                }else{
                    array.swapAt(indexJ, indexJ + 1)
                }
            }
        }
        return array
    }
    
}
