//
//  UIColor+Addition.m
//  MagicCamera
//
//  Created by fzw on 2018/12/24.
//  Copyright © 2018 Mxtrip. All rights reserved.
//

#import "UIColor+Addition.h"

@implementation UIColor (Addition)
+ (UIColor *)getColor:(NSString *)hexColor {
    if (hexColor.length != 6){
        return [UIColor whiteColor];
    }
    unsigned int red, green, blue;
    NSRange range;
    range.length = 2 ;
    range.location = 0 ;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    range.location = 2 ;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    range.location = 4 ;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    return [UIColor colorWithRed:(float)(red/ 255.0f) green:(float)(green/ 255.0f) blue:(float)(blue/ 255.0f) alpha:1.0f];
}

+ (UIColor *)getColor:(NSString *)hexColor alpha:(CGFloat)alpha {
    if (hexColor.length != 6){
        return [UIColor whiteColor];
    }
    unsigned int red, green, blue;
    NSRange range;
    range.length = 2;
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    return [UIColor colorWithRed:(float)(red/ 255.0f) green:(float)(green/ 255.0f) blue:(float)(blue/ 255.0f) alpha:alpha];
}
@end
