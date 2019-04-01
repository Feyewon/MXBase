//
//  UIView+MXFrame.m
//  AFNetworking
//
//  Created by FEI on 2019/4/1.
//

#import "UIView+MXFrame.h"

@implementation UIView (MXFrame)
- (CGFloat)mx_top
{
    return self.frame.origin.y;
}

- (void)setMx_top:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)mx_right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setMx_right:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - self.frame.size.width;
    self.frame = frame;
}

- (CGFloat)mx_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setMx_bottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - self.frame.size.height;
    self.frame = frame;
}

- (CGFloat)mx_left
{
    return self.frame.origin.x;
}

- (void)setMx_left:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)mx_width
{
    return self.frame.size.width;
}

- (void)setMx_width:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)mx_height
{
    return self.frame.size.height;
}

- (void)setMx_height:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

#pragma mark - Shortcuts for frame properties

- (CGPoint)mx_origin {
    return self.frame.origin;
}

- (void)setMx_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)mx_size {
    return self.frame.size;
}

- (void)setMx_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
#pragma mark - Shortcuts for positions

- (CGFloat)mx_centerX {
    return self.center.x;
}

- (void)setMx_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)mx_centerY {
    return self.center.y;
}

- (void)setMx_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

@end
