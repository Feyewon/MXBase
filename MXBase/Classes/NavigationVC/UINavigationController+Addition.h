//
//  UINavigationController+Addition.h
//  MagicCamera
//
//  Created by fzw on 2019/1/2.
//  Copyright © 2019 Mxtrip. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Addition)
/**
 隐藏导航栏的背景色
 */
- (void)hideNavigationBar;

/**
 设置导航栏的颜色，透明度可以写进color里
 @param color 颜色
 */
- (void)showNavigationBarWithColor:(UIColor *)color;

/**
 设置导航栏的背景图
 @param image 图片
 */
- (void)showNavigationBarWithImage:(UIImage *)image;

/**
 设置导航栏的背景图
 @param barImage 导航栏背景图片
 @param shadowImage 导航栏分割线
 */
- (void)showNavigationBarWithBarImage:(UIImage *)barImage shadowImage:(UIImage *)shadowImage;
@end
