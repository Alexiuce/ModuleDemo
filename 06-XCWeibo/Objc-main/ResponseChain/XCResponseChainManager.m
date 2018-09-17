//
//  XCResponseChainManager.m
//  Objc-main
//
//  Created by Alexcai on 2018/9/17.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "XCResponseChainManager.h"

@interface XCResponseChainManager()

@property (nonatomic, strong) NSMutableArray *subResponsers;

@property (nonatomic, assign) int currentIndex;


@end


@implementation XCResponseChainManager


- (instancetype)addResponser:(id<XCResponseProtocol>)responser{
    if (responser) {
        [self.subResponsers addObject:responser];
    }
    return self;
}



- (void)doSomething:(NSString *)thing responser:(id<XCResponseProtocol>)responser{
    if (self.currentIndex == self.subResponsers.count) {return;}
    id <XCResponseProtocol> resp = self.subResponsers[self.currentIndex];
    self.currentIndex ++;
    [resp doSomething:thing responser:self];
    
}





#pragma mark - lazy getter
- (NSMutableArray *)subResponsers{
    if (_subResponsers == nil) {
        _subResponsers = [NSMutableArray arrayWithCapacity:3];
    }
    return _subResponsers;
}
@end
