//
//  StackViewController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/9/7.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "StackViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface StackViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *topPicture;

@property (weak, nonatomic) IBOutlet UIImageView *iconPictureView;
@property (weak, nonatomic) IBOutlet UILabel *iconLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;



@end

@implementation StackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *imageUrl = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1536204835442&di=6daf59e61f13cb3ee2fed1f9b615dc6f&imgtype=0&src=http%3A%2F%2Fp3.wmpic.me%2Farticle%2F2016%2F08%2F31%2F1472612447_LlwuSeKC.jpg";
    NSString *iconUrl = @"http://t2.hddhhn.com/uploads/tu/201610/198/scx30045vxd.jpg";
    [_topPicture sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    
    [_iconPictureView sd_setImageWithURL:[NSURL URLWithString:iconUrl]];

}



@end
