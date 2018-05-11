//
//  _1_iOS_JSTests.swift
//  01-iOS-JSTests
//
//  Created by caijinzhu on 2018/3/28.
//  Copyright © 2018年 alexiuce.github.io. All rights reserved.
//

import XCTest

import JavaScriptCore

class _1_iOS_JSTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testJsDemo()  {
        let context = JSContext(virtualMachine: JSVirtualMachine())!
        
        func sum(a: Int, b: Int) -> Int {
            return a + b
        }
        

        context.setObject(sum, forKeyedSubscript: "mySum" as NSCopying & NSObjectProtocol)
        
        let s = context.evaluateScript("mySum(1,2)")
        print(s?.toInt32() ?? "no value")
        
        
        
    }
    
}
