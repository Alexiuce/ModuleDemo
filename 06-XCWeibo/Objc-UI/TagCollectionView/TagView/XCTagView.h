//
//  XCTagView.h
//  Objc-UI
//
//  Created by Alexcai on 2018/9/13.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface XCTagView : UIView

@property (nonatomic, strong) NSArray <NSString *>*tagTitles;  // tag标签数组;
@property (nonatomic, assign) CGFloat rowHeight;   // 行高;
@property (nonatomic, assign) CGFloat fontSize;   // 字体大小;
@property (nonatomic, assign) CGFloat rowMargin;  // 行间距;
@property (nonatomic, assign) CGFloat tagMargin;  // 标签的间距;

@property (nonatomic, assign) CGFloat maxRowWidth;  // 最大行宽度;默认为屏幕宽度;


@end
