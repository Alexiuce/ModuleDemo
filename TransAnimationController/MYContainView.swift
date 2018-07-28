//
//  MYContainView.swift
//  TransAnimationController
//
//  Created by Alexcai on 2018/7/28.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

import Cocoa

class MYContainView: NSView {

    override func addSubview(_ view: NSView) {
        super.addSubview(view)
        view.frame = bounds
    }
    
}
