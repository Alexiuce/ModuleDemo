//
//  NSView-Extension.swift
//  ModuleDemo
//
//  Created by caijinzhu on 2018/3/6.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

import Cocoa

fileprivate let NSViewMarchingAntsLayerKey = UnsafeMutablePointer<Int8>.allocate(capacity: 1)

extension NSView{
    public func xc_startMarchingAnts(){
        if let xc_marchingAntsLayer = objc_getAssociatedObject(self, NSViewMarchingAntsLayerKey) as? CAShapeLayer {
            xc_setupMarchingAntLayer(xc_marchingAntsLayer)
        }else{
            let marchingAntsLayer = CAShapeLayer()
            objc_setAssociatedObject(self, NSViewMarchingAntsLayerKey, marchingAntsLayer,.OBJC_ASSOCIATION_RETAIN)
            xc_setupMarchingAntLayer(marchingAntsLayer)
        }
    }
    
    
    fileprivate func xc_setupMarchingAntLayer(_ maLayer: CAShapeLayer){
        if  ((maLayer.animation(forKey: "line123") as? CABasicAnimation) != nil) {
            return
        }
        maLayer.path = NSBezierPath(roundedRect: bounds, xRadius: 0, yRadius: 0).cgPath
        maLayer.strokeColor = NSColor.red.cgColor
    
        maLayer.lineWidth = 4
        maLayer.fillColor = nil
        maLayer.lineDashPattern = [3,6]
        layer?.addSublayer(maLayer)
        
        let animation = CABasicAnimation(keyPath: "lineDashPhase")
        animation.fromValue = 0
        animation.toValue = maLayer.lineDashPattern?.reduce(0){$0 - $1.intValue}
        animation.duration = 1
        animation.repeatCount = .infinity
        maLayer.add(animation, forKey: "line123")
    }
}
