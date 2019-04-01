//
//  UIButton+EnlargeTouchArea.h
//  MagicCamera
//
//  Created by 邓光洋 on 2019/1/6.
//  Copyright © 2019 Mxtrip. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (EnlargeTouchArea)

- (void)enlargeTouchAreaWithTop:(CGFloat)top
                           left:(CGFloat)left
                         bottom:(CGFloat)bottom
                          right:(CGFloat)right;

@end

