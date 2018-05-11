//
//
// XCProcessView.swift
// Created by Alex on 2018/5/11
// Copyright © 2018年 alexiuce.github.io. All rights reserved.

//

import Cocoa

class XCProcessView: NSButton {

    var process: CGFloat = 0 {
        didSet{
            print("pp did set func \(process)")
            title = "\(process)"
        }
    }
    
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        NSColor.red.set()
        let path = NSBezierPath()
        path.lineCapStyle = .roundLineCapStyle

        let center = NSPoint(x: dirtyRect.size.width * 0.5, y: dirtyRect.size.height * 0.5)
        let r = min(center.x, center.y) - 5
        let end = 360.0 * process * 0.01 - 90
        path.appendArc(withCenter: center, radius: r, startAngle: -90, endAngle: end, clockwise:false)
//        path.lineWidth = 3

        path.stroke()
        // Drawing code here.
    }
    
}
