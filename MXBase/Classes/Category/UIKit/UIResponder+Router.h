//
//  UIResponder+Router.h
//  KHNewsModule_Example
//
//  Created by FEI on 2019/4/7.
//  Copyright © 2019 Feyewon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (Router)

- (void)routerEventWithName:(nonnull NSString *)eventName userInfo:(nullable NSDictionary *)userInfo;

@end

