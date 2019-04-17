//
//  BigTouchButton.m
//  梦想旅行
//
//  Created by fzw on 15/5/25.
//  Copyright (c) 2015年 北京梦想智联科技有限公司. All rights reserved.
//

#import "BigTouchButton.h"
@interface BigTouchButton ()
@property (nonatomic,strong) UIColor *colorNormal;
@property (nonatomic,strong) UIColor *colorSelected;
@end
@implementation BigTouchButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    CGRect bounds = self.bounds;
    bounds = CGRectInset(bounds, self.boundInsert.width, self.boundInsert.height);	//注意这里是负数，扩大了之前的bounds的范围
    return CGRectContainsPoint(bounds, point);
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if(self.colorNormal && !selected){
        self.backgroundColor=self.colorNormal;
    }else if (self.colorSelected && selected){
        self.backgroundColor=self.colorSelected;
    }
}

-(void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state{
    if(state==UIControlStateNormal){
        self.colorNormal=color;
        if(self.state==UIControlStateNormal){
            self.backgroundColor=self.colorNormal;
        }
    }else if(state==UIControlStateSelected){
        self.colorSelected=color;
        if(self.state==UIControlStateSelected){
            self.backgroundColor=self.colorSelected;
        }
    }
}
@end
