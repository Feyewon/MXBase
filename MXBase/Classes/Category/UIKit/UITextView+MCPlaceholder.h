//
//  UITextView+MCPlaceholder.h
//  MagicCamera
//
//  Created by FEI on 2019/1/8.
//  Copyright © 2019年 Mxtrip. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT double UITextView_PlaceholderVersionNumber;
FOUNDATION_EXPORT const unsigned char UITextView_PlaceholderVersionString[];

/*
 内部已经使用KVO监听了，如果继承重写textView 再监听就会失效，如果需要在text 设置的时候有所操作，那么可以个实现如下方法
 -(void)textDidSet;
 
 */
@interface UITextView (MCPlaceholder)

@property (nonatomic, readonly) UILabel *placeholderLabel;

@property (nonatomic, strong) IBInspectable NSString *placeholder;
@property (nonatomic, strong) NSAttributedString *attributedPlaceholder;
@property (nonatomic, strong) IBInspectable UIColor *placeholderColor;

+ (UIColor *)defaultPlaceholderColor;

@end
