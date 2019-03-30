//
//  UIButton+EnlargeTouchArea.m
//  MagicCamera
//
//  Created by 邓光洋 on 2019/1/6.
//  Copyright © 2019 Mxtrip. All rights reserved.
//

#import "UIButton+EnlargeTouchArea.h"
#import <objc/runtime.h>

static char Topkey;
static char Leftkey;
static char Bottomkey;
static char Rightkey;

@implementation UIButton (EnlargeTouchArea)

- (void)enlargeTouchAreaWithTop:(CGFloat)top
                           left:(CGFloat)left
                         bottom:(CGFloat)bottom
                          right:(CGFloat)right {
    objc_setAssociatedObject(self, &Topkey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &Leftkey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &Bottomkey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &Rightkey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGRect)enlargeTouchArea {
    NSNumber *top = objc_getAssociatedObject(self, &Topkey);
    NSNumber *left = objc_getAssociatedObject(self, &Leftkey);
    NSNumber *bottom = objc_getAssociatedObject(self, &Bottomkey);
    NSNumber *right = objc_getAssociatedObject(self, &Rightkey);
    if (top && left && bottom && right) {
        return CGRectMake(self.bounds.origin.x - left.floatValue,
                          self.bounds.origin.y - top.floatValue,
                          self.bounds.size.width + left.floatValue + right.floatValue,
                          self.bounds.size.height + top.floatValue + bottom.floatValue);
    }
    return self.bounds;
}

//没效果
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    CGRect rect = [self enlargeTouchArea];
//    if (CGRectEqualToRect(rect, self.bounds)) {
//        return [super hitTest:point withEvent:event];
//    }
//    return CGRectContainsPoint(rect, point) ? self : nil;
//}

//正常
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect rect = [self enlargeTouchArea];
    return CGRectContainsPoint(rect, point);
}

@end
