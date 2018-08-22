//
//  NSString+MD5.m
//  Objc-UI
//
//  Created by Alexcai on 2018/8/22.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "NSString+MD5.h"

#import <CommonCrypto/CommonDigest.h> 

@implementation NSString (MD5)


- (NSString *)MD5{
    const char *str = [self UTF8String];
    
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(str, (unsigned int)strlen(str), md5Buffer);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH *2];
    for (int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x",md5Buffer[i]];
    }
    
    return output;
}


@end
