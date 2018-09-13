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


@end
