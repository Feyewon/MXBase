//
//  BigTouchButton.h
//  梦想旅行
//
//  Created by fzw on 15/5/25.
//  Copyright (c) 2015年 北京梦想智联科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BigTouchButton : UIButton
@property (nonatomic) CGSize boundInsert;
-(void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state;
@end
