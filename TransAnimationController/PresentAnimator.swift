//
//  PresentAnimator.swift
//  TransAnimationController
//
//  Created by Alexcai on 2018/7/29.
//  Copyright © 2018年 Alexcai. All rights reserved.
//  PresentViewController 的自定义动画器,用来实现present自定义的动画效果

import Cocoa

class PresentAnimator: NSObject {

    // 背景视图: 用来防止事件穿透
    let backgroundView = CBackgroundView()
    
}



// MARK:  NSViewControllerPresentationAnimator
extension PresentAnimator: NSViewControllerPresentationAnimator{
    func animatePresentation(of viewController: NSViewController, from fromViewController: NSViewController) {
        // 这里实现present的动画效果
        /**viewController: 将要被present出来的视图控制器, fromViewcontroller --> presented动作 ---> viewController */
        // 1. 获取容器view
        let containerView = fromViewController.view
        backgroundView.frame = containerView.bounds
        containerView.addSubview(backgroundView)
        // 2. 计算最终显示的frame
        let finalFrame = NSInsetRect(containerView.bounds, 50, 50)
        // 3. 需要显示的view
        let modalView = viewController.view
        
        // 4. 设置将要显示视图的初始frame
        modalView.frame = finalFrame
        modalView.setFrameOrigin(NSMakePoint(finalFrame.origin.x, finalFrame.origin.y - 200))
        // 5 .添加视图到容器视图中
        containerView.addSubview(modalView)
        // 6. 执行动画效果
        NSAnimationContext.runAnimationGroup({ (animationContext) in
            animationContext.duration = 0.5
            modalView.animator().frame = finalFrame
            
        }, completionHandler: nil)
        
        
    }
    
    func animateDismissal(of viewController: NSViewController, from fromViewController: NSViewController) {
        // 这里实现dismiss时的动画效果
        // 1. 获取开始动画的frame
        let startFrame = viewController.view.frame
        // 2. 执行动画
        
        NSAnimationContext.runAnimationGroup({ (animationContext) in
            animationContext.duration = 0.5
            viewController.view.animator().setFrameOrigin(NSMakePoint(startFrame.origin.x, startFrame.origin.y - fromViewController.view.bounds.size.height - 100))
        }) {
        // 3. 动画完成后,移除子视图
            viewController.view.removeFromSuperview()
            self.backgroundView.removeFromSuperview()
           
        }
    }
    
    
}
