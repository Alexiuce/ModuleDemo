//
//  XCSubViewFrameView.h
//  Objc-UI
//
//  Created by Alexcai on 2018/9/21.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCSubViewFrameView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UIButton *testButton;


+ (instancetype)xibView;

@end
