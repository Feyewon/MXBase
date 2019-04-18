//
//  UIViewController+DisKeyboard.m
//  KHPublishModule_Example
//
//  Created by FEI on 2019/4/17.
//  Copyright © 2019 Feyewon. All rights reserved.
//

#import "UIViewController+DisKeyboard.h"
#import <objc/runtime.h>

static NSString *panGestKey = @"panGestKey";

@interface UIViewController ()
@property (nonatomic, strong) UIPanGestureRecognizer *panGest;
@end

@implementation UIViewController (DisKeyboard)

- (void)addPanGestForDisKeyboard {
    self.panGest=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)];
    [self.navigationController.view addGestureRecognizer:self.panGest];
}

- (void)removePanGestForDisKeyboard {
    self.panGest.enabled = NO;
    self.panGest = nil;
}

- (void)setPanGest:(UIPanGestureRecognizer *)panGest {
    objc_setAssociatedObject(self, &panGestKey, panGest, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIPanGestureRecognizer *)panGest {
    return objc_getAssociatedObject(self, &panGestKey);
}

- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender {
    // Dismiss keyboard (optional)
    [self.navigationController.view endEditing:YES];
}

@end
