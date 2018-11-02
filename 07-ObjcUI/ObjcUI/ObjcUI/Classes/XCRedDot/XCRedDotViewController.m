//
//  XCRedDotViewController.m
//  ObjcUI
//
//  Created by Alexcai on 2018/11/1.
//  Copyright © 2018 dongjiu. All rights reserved.
//

#import "XCRedDotViewController.h"

NS_INLINE NSString * fetchMyCustomText(){
    return [NSString stringWithFormat:@"%@",NSDate.date.description];
}


@interface XCRedDotViewController ()

@end

@implementation XCRedDotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *a = fetchMyCustomText();
    NSLog(@"%@",a);
    // Do any additional setup after loading the view.
}



@end
