//
//  UINavigationController+Addition.m
//  MagicCamera
//
//  Created by fzw on 2019/1/2.
//  Copyright © 2019 Mxtrip. All rights reserved.
//

#import "UINavigationController+Addition.h"
#import "UIImage+Addition.h"

@implementation UINavigationController (Addition)
- (void)hideNavigationBar {
    [self showNavigationBarWithColor:[UIColor clearColor]];
    self.navigationBar.shadowImage = [UIImage new];
}

- (void)showNavigationBarWithColor:(UIColor *)color {
    [self showNavigationBarWithImage:[UIImage imageWithColor:color]];
    self.navigationBar.shadowImage = nil;
}

- (void)showNavigationBarWithImage:(UIImage *)image {
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.shadowImage = nil;
}

- (void)showNavigationBarWithBarImage:(UIImage *)barImage shadowImage:(UIImage *)shadowImage {
    [self.navigationBar setBackgroundImage:barImage forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.shadowImage = shadowImage;
}
@end
