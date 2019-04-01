//
//  UIColor+Addition.h
//  MagicCamera
//
//  Created by fzw on 2018/12/24.
//  Copyright © 2018 Mxtrip. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Addition)
+ (UIColor *)getColor:( NSString *)hexColor;
+ (UIColor *)getColor:( NSString *)hexColor alpha:(CGFloat)alpha;
@end
