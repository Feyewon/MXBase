//
//  MXEdgeInsetsButton.h
//  KHNewsModule_Example
//
//  Created by FEI on 2019/4/8.
//  Copyright © 2019 Feyewon. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, MXButtonEdgeInsetsStyle) {
    MXButtonEdgeInsetsStyleImageLeft,
    MXButtonEdgeInsetsStyleImageRight,
    MXButtonEdgeInsetsStyleImageTop,
    MXButtonEdgeInsetsStyleImageBottom
};

NS_ASSUME_NONNULL_BEGIN

@interface MXEdgeInsetsButton : UIButton
#if TARGET_INTERFACE_BUILDER
@property (nonatomic) IBInspectable NSUInteger edgeInsetsStyle;
#else
@property (nonatomic) MXButtonEdgeInsetsStyle edgeInsetsStyle;
#endif
@property (nonatomic) IBInspectable CGFloat imageTitleSpace;

@end

NS_ASSUME_NONNULL_END
