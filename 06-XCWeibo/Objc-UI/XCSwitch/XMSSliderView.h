//
//  XMSSliderView.h
//  Objc-UI
//
//  Created by Alexcai on 2018/8/16.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import <UIKit/UIKit.h>


@class XMSSliderView;

@protocol XMSSliderViewDelegate <NSObject>

/**
 选项回调事件

 @param view 视图控件本身
 @param index 选中的索引
 */
- (void)sliderView:(XMSSliderView *)view didSelectedAtIndex:(NSUInteger)index;
@end


@interface XMSSliderView : UIView
    
+ (instancetype)sliderView UIKIT_AVAILABLE_IOS_ONLY(9.0);



@property (nonatomic, weak) id<XMSSliderViewDelegate> select_delegate;


@end
