//
//  PayAlertBackgroundView.h
//  梦想旅行
//
//  Created by FEI on 16/10/19.
//  Copyright © 2016年 北京梦想智联科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,PayAlertBackgroundViewType) {
    PayAlertBackgroundViewTypeSuccess = 0,
    PayAlertBackgroundViewTypeFail = 1,
    PayAlertBackgroundViewTypeCancel = 2,
    PayAlertBackgroundViewTypeAssert = 3,
};

@interface PayAlertBackgroundView : UIView
@property(nonatomic,readonly) UIImageView *logoImage;
@property(nonatomic,readonly) UILabel *titleLab;
@property(nonatomic,readonly) UILabel *contentLab;
@property(nonatomic,strong) UIButton *lookOrderBtn;
@property(nonatomic,readonly) UIButton *leftBtn;
@property(nonatomic,readonly) UIButton *rightBtn;
@property(nonatomic) PayAlertBackgroundViewType alertviewType;
@property (nonatomic,copy) void(^submitBlock)(void);
@property (nonatomic,copy) void(^cancelBlock)(void);
@end
