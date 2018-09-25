//
//  GifPlayViewController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/9/22.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "GifPlayViewController.h"
#import <ImageIO/ImageIO.h>
@interface GifPlayViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIView *textView;

@property (nonatomic, strong)CATextLayer *textLayer;

@end

@implementation GifPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 1. 获取gif 文件,并使用nsdata 加载;
    NSString *gifPath = [NSBundle.mainBundle pathForResource:@"demo.gif" ofType:nil];
    NSData *gifData = [NSData dataWithContentsOfFile:gifPath];
    NSLog(@"11111");
    // 2. 使用CGImageSource 读取图片数据;
    CGImageSourceRef imageSourceRef = CGImageSourceCreateWithData((__bridge CFDataRef)gifData, NULL);
    // 3. 获取gif 的图片总数;
    int imgCount = (int)CGImageSourceGetCount(imageSourceRef);
    NSMutableArray <UIImage *>*allImageArray = [NSMutableArray arrayWithCapacity:imgCount];
    NSTimeInterval allPlayDuration = 0;
    // 4. 根据索引获取指定位置的图片;
    for (int i = 0; i < imgCount; ++i) {
        // 4.0 获取图片引用;
        CGImageRef imgRef = CGImageSourceCreateImageAtIndex(imageSourceRef, i, NULL);
        UIImage *img = [UIImage imageWithCGImage:imgRef];
        [allImageArray addObject:img];
        // 释放cf 对象
        CFRelease(imgRef);
        // 4.1 获取gif图片相关属性;
        CFDictionaryRef dictRef = CGImageSourceCopyPropertiesAtIndex(imageSourceRef, i, NULL);
        // 4.2 获取gif 属性字典
        CFDictionaryRef gifDictRef = CFDictionaryGetValue(dictRef, kCGImagePropertyGIFDictionary);
        // 4.3 获取一帧的播放时长
        NSNumber *frameDuration = CFDictionaryGetValue(gifDictRef, kCGImagePropertyGIFDelayTime);
        allPlayDuration += frameDuration.doubleValue;
        // 释放cf 对象
        CFRelease(dictRef);
        
    }
    // 释放core foundation 对象
    CFRelease(imageSourceRef);
    // 5. 显示动画图片;
    self.imgView.animationImages = allImageArray;
    self.imgView.animationDuration = allPlayDuration;
    [self.imgView startAnimating];
    
    
    //create a text layer
    _textLayer = [CATextLayer layer];
    [_textLayer setFrame:CGRectMake(0, 0, 40, 60)];
    
    //set text attributes
    _textLayer.foregroundColor = [UIColor blackColor].CGColor;
    _textLayer.backgroundColor = UIColor.yellowColor.CGColor;
    
    
    //choose a font
    UIFont *font = [UIFont systemFontOfSize:15];
    
    //set layer font
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    _textLayer.contentsScale = UIScreen.mainScreen.scale;
    _textLayer.fontSize = font.pointSize;
    _textLayer.font =  fontRef;
    CGFontRelease(fontRef);
    
    //choose some text
    NSString *text = @"Lorem ipsum dolor sit amet";
    
    //set layer text
    _textLayer.string = text;
    
    _textLayer.position = CGPointZero;
    _textLayer.anchorPoint = CGPointZero;
    
    [self.textView.layer addSublayer:_textLayer];
    
    

}



@end
