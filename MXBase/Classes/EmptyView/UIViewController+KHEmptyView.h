//
//  UIViewController+KHEmptyView.h
//  KHMessageModule_Example
//
//  Created by 邓光洋 on 2019/5/23.
//  Copyright © 2019 dgyiOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (KHEmptyView)

- (void)showEmptyViewInSuperView:(UIView *)superView
                           image:(UIImage *)image
                        tipTitle:(NSString *)tipTitle;

- (void)showEmptyViewInSuperView:(UIView *)superView
                           image:(UIImage *)image
                        tipTitle:(NSString *)tipTitle
                 refreshBtnTitle:(NSString *)refreshBtnTitle
                 refreshCallback:(void(^)(void))refreshCallback;

- (void)hiddenEmptyView;

@end

NS_ASSUME_NONNULL_END
