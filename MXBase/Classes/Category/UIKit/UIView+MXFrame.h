//
//  UIView+MXFrame.h
//  AFNetworking
//
//  Created by FEI on 2019/4/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (MXFrame)

@property (nonatomic, assign) CGPoint mx_origin;
@property (nonatomic, assign) CGSize mx_size;

// shortcuts for positions
@property (nonatomic) CGFloat mx_centerX;
@property (nonatomic) CGFloat mx_centerY;


@property (nonatomic) CGFloat mx_top;
@property (nonatomic) CGFloat mx_bottom;
@property (nonatomic) CGFloat mx_right;
@property (nonatomic) CGFloat mx_left;

@property (nonatomic) CGFloat mx_width;
@property (nonatomic) CGFloat mx_height;

@end

NS_ASSUME_NONNULL_END
