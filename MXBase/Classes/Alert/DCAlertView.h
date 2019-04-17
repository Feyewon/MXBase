//
//  DCAlertView.h
//  梦想旅行
//
//  Created by fzw on 15/10/21.
//  Copyright © 2015年 北京梦想智联科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDCAlertController;
@class SDCAlertView;
@interface DCAlertView : UIAlertView <UIAlertViewDelegate>
@property (nonatomic,copy) void(^submitBlock)(SDCAlertView *);
@property (nonatomic,copy) void(^cancelBlock)(SDCAlertView *);
-(id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle submitButtonTitle:(NSString *)submitButtonTitle;
@end
