//
//  SALViewController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/9/6.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "SALViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface SALViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;

@end

@implementation SALViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *imageUrl = @"http://t2.hddhhn.com/uploads/tu/201610/198/scx30045vxd.jpg";
    [_pictureView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];

}



@end
