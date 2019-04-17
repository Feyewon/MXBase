//
//  DCAlertBackgroundViewV2.h
//  梦想旅行
//
//  Created by FEI on 2018/6/9.
//  Copyright © 2018年 北京梦想智联科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCAlertBackgroundViewV2 : UIView
@property (nonatomic,strong) NSString *submitButtonTitle;
@property (nonatomic,strong) UIColor *submitButtonColor;
@property (nonatomic,copy) void(^submitBlock)(void);
@property (nonatomic,copy) void(^closeBlock)(void);
-(void)setTitle:(NSString *)title;
-(void)setAttributeContent:(NSAttributedString *)attrString;
-(void)setSubmitButtonTitle:(NSString *)title textColor:(UIColor *)color;
-(void)setCloseButtonHidden:(BOOL)hidden;
@end
