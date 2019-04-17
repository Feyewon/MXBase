//
//  DCAlertBackgroundView.h
//  梦想旅行
//
//  Created by FEI on 2018/6/8.
//  Copyright © 2018年 北京梦想智联科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCAlertBackgroundView : UIView
@property (nonatomic,strong) NSString *submitButtonTitle;
@property (nonatomic,strong) UIColor *submitButtonColor;
@property (nonatomic,strong) NSString *cancelButtonTitle;
@property (nonatomic,strong) UIColor *cancelButtonColor;
@property (nonatomic,copy) void(^submitBlock)(void);
@property (nonatomic,copy) void(^cancelBlock)(void);
@property (nonatomic,copy) void(^closeBlock)(void);

-(void)setTitle:(NSString *)title;
-(void)setAttributeContent:(NSAttributedString *)attrString;
-(void)setCancelButtonTitle:(NSString *)title textColor:(UIColor *)color;
-(void)setSubmitButtonTitle:(NSString *)title textColor:(UIColor *)color;
-(void)setCloseButtonHidden:(BOOL)hidden;
@end
