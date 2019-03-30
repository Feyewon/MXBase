//
//  UIViewController+Addition.h
//  MagicCamera
//
//  Created by fzw on 2019/1/3.
//  Copyright © 2019 Mxtrip. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

@interface NSObject (Hud)

- (void)showHudOnView:(UIView *)view;
- (void)hideHud;

@end


@interface UIViewController (Addition)

- (BOOL)isVisible;
+ (UIViewController *)getCurrentVC;

#pragma mark - hud
- (void)showHud;

#pragma mark - 错误页
- (void)showErrorPageWithFreshBlock:(void(^)(void))freshBlock;
- (void)hideErrorPage;
- (BOOL)isErrorPageShow;


@property (nonatomic, strong, readonly) MASViewAttribute *mc_viewControllerTop;
@property (nonatomic, strong, readonly) MASViewAttribute *mc_viewControllerBottom;

@end
