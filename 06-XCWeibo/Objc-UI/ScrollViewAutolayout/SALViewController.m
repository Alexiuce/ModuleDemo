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
    
    
    NSString *imageUrl = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1536204835442&di=6daf59e61f13cb3ee2fed1f9b615dc6f&imgtype=0&src=http%3A%2F%2Fp3.wmpic.me%2Farticle%2F2016%2F08%2F31%2F1472612447_LlwuSeKC.jpg";
    //@"http://t2.hddhhn.com/uploads/tu/201610/198/scx30045vxd.jpg";
    [_pictureView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];

}



@end
