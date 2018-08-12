//
//  SDYWebTabController.h
//  Flashfish
//
//  Created by Alexcai on 2018/8/12.
//  Copyright © 2018年 杭州东九网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+ACMediaExt.h"
#import <WebKit/WebKit.h>

@interface SDYWebTabController : UIViewController


@property (nonatomic, strong) UIScrollView *scrollView;     // 主滚动视图
@property (nonatomic, strong) UIView *scrollViewContainerView;    //  添加到scrollView中的容器视图
@property (nonatomic, strong) UITableView *tableView;       // 添加到scrollViewContainerView中的列表视图
@property (nonatomic, strong) WKWebView *webView;           // 添加到scrollViewContainerView中的web视图

@property (nonatomic, strong) UIView *topView;   // 带顶部视图

@property (nonatomic, assign) CGFloat maxWebContentHeight;
@property (nonatomic, assign) CGFloat maxTabContentHeight;

@end
