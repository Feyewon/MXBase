//
//  UIResponder+Router.m
//  KHNewsModule_Example
//
//  Created by FEI on 2019/4/7.
//  Copyright © 2019 Feyewon. All rights reserved.
//

#import "UIResponder+Router.h"

@implementation UIResponder (Router)

- (void)routerEventWithName:(nonnull NSString *)eventName userInfo:(nullable NSDictionary *)userInfo
{
    [[self nextResponder] routerEventWithName:eventName userInfo:userInfo];
}

@end
