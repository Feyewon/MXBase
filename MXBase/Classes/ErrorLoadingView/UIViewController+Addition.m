//
//  UIViewController+Addition.m
//  MagicCamera
//
//  Created by fzw on 2019/1/3.
//  Copyright © 2019 Mxtrip. All rights reserved.
//

#import "UIViewController+Addition.h"
#import "MBProgressHUD.h"
#import <objc/runtime.h>

#import "MXErrorView.h"
#import "MXLoadingView.h"

static NSString *timeoutViewKey = @"timeoutViewABCDEFG";
static NSString *freshNetworkBlockKey = @"freshNetworkBlockKeyABCDEFG";
static NSString *hidenNaviBackgroundKey = @"hidenNaviBackgroundKeyABCDEFG";

static NSString *hudKey = @"hudKeyABCDEFG";

@implementation NSObject (Hud)

#pragma mark --  hud
- (void)setHud_:(MBProgressHUD *)hud_{
    objc_setAssociatedObject(self, &hudKey, hud_, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MBProgressHUD *)hud_ {
    return objc_getAssociatedObject(self, &hudKey);
}

- (void)showHudOnView:(UIView *)view {
    [self.hud_ hideAnimated:NO];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.backgroundView.backgroundColor= [UIColor colorWithWhite:0.f alpha:.2f];
    hud.mode = MBProgressHUDModeCustomView;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor colorWithWhite:0.f alpha:.0f];
    hud.removeFromSuperViewOnHide = YES;
    hud.customView = [[MXLoadingView alloc] init];
    self.hud_ = hud;
}

- (void)hideHud {
    [self.hud_ hideAnimated:YES];
    self.hud_ = nil;
}

@end


@implementation UIViewController (Addition)

#pragma mark - visible
- (BOOL)isVisible {
    return (self.isViewLoaded && self.view.window);
}

+ (UIViewController *)getCurrentVC {
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    NSArray *winSubviews = [window subviews];
    UIView *frontView = winSubviews.count>0?winSubviews[0]:nil;
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    return result;
}

#pragma mark -- 错误页
- (void (^)(void))freshBlock {
    return objc_getAssociatedObject(self, &freshNetworkBlockKey);
}

- (void)setFreshBlock:(void (^)(void))freshBlock {
    objc_setAssociatedObject(self, &freshNetworkBlockKey, freshBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MXErrorView *)errorView {
    
    MXErrorView *errorView = objc_getAssociatedObject(self, &timeoutViewKey);
    if (!errorView) {
        errorView = [self buildErrorView];
        objc_setAssociatedObject(self, &timeoutViewKey, errorView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return errorView;
}

- (MXErrorView *)buildErrorView {
    
    MXErrorView *errorView = [[MXErrorView alloc] init];
    [self.view addSubview:errorView];
    __weak __typeof(self)weakSelf = self;
    errorView.freshNetworkBlock = ^{
        [weakSelf hideErrorPage];
        if (weakSelf.freshBlock) {
            weakSelf.freshBlock();
        }
    };
    [errorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    errorView.hidden = YES;
    return errorView;
}

- (void)showErrorPageWithFreshBlock:(void (^)(void))freshBlock {
    [self setFreshBlock:freshBlock];
    [self showErrorPage];
}

- (void)showErrorPage {
    self.errorView.hidden = NO;
    [self.view bringSubviewToFront:self.errorView];
}

- (void)hideErrorPage {
    self.errorView.hidden = YES;
}

- (BOOL)isErrorPageShow {
    if (self.errorView.hidden == NO) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark --  hud
- (void)showHud {
    [self showHudOnView:self.view];
}

#pragma mark -- top and bottom inset
- (MASViewAttribute *)mc_viewControllerTop {
    if (@available(iOS 11.0, *)) {
        return self.view.mas_safeAreaLayoutGuideTop;
    } else {
        return self.mas_topLayoutGuide;
    }
}

- (MASViewAttribute *)mc_viewControllerBottom {
    if (@available(iOS 11.0, *)) {
        return self.view.mas_safeAreaLayoutGuideBottom;
    } else {
        return self.mas_bottomLayoutGuide;
    }
}

@end
