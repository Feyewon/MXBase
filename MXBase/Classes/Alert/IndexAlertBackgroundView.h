//
//  IndexAlertBackgroundView.h
//  梦想旅行
//
//  Created by fzw on 16/4/13.
//  Copyright © 2016年 北京梦想智联科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndexAlertBackgroundView : UIView
@property (nonatomic,copy) void(^submitBlock)(void);
@property (nonatomic,copy) void(^cancelBlock)(void);
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UIButton *cancelButton;
@property (nonatomic,strong) UIButton *submitButton;
@property (nonatomic,strong) UIImageView *imageView;
@end
