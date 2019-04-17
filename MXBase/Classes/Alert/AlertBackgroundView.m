//
//  AlertBackgroundView.m
//  梦想旅行
//
//  Created by fzw on 15/8/18.
//  Copyright (c) 2015年 北京梦想智联科技有限公司. All rights reserved.
//

#import "AlertBackgroundView.h"
#import "UIColor+Addition.h"
#import "Masonry.h"
#import "MXMacro.h"
@interface AlertBackgroundView ()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UIButton *submitButton;
@property (nonatomic,strong) UIButton *cancelButton;
@end
@implementation AlertBackgroundView
-(id)init{
    if(self=[super init]){
        self.submitButtonTitle=@"确认";
        self.submitButtonColor=[UIColor getColor:@"ffd220"];
        [self buildSubview];
        [self makeMansonryConstrains];
    }
    return self;
}

-(void)setAttributeContent:(NSAttributedString *)attrString{
    self.contentLabel.attributedText=attrString;
}

-(void)buildSubview{
    self.titleLabel=[UILabel new];
    self.titleLabel.font=[UIFont systemFontOfSize:14];
    self.titleLabel.textAlignment=NSTextAlignmentCenter;
    self.titleLabel.textColor=[UIColor getColor:@"565e6a"];
    [self addSubview:self.titleLabel];
    
    self.contentLabel=[UILabel new];
    self.contentLabel.font=[UIFont systemFontOfSize:14];
    self.contentLabel.numberOfLines=0;
    self.contentLabel.textColor=[UIColor getColor:@"aaaaaa"];
    self.contentLabel.textAlignment=NSTextAlignmentCenter;
    [self addSubview:self.contentLabel];
}

-(void)makeMansonryConstrains{
    __weak __typeof(self)weakSelf=self;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(weakSelf).priorityHigh();
        make.height.mas_equalTo(weakSelf.titleLabel.text.length?45:0).priorityHigh();
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(16).priority(MASLayoutPriorityRequired);
        make.right.equalTo(weakSelf).with.offset(-16).priority(MASLayoutPriorityRequired);
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).with.offset(20).priorityHigh();
    }];
    
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(weakSelf);
        make.top.equalTo(weakSelf.contentLabel.mas_bottom).with.offset(20);
        make.height.mas_equalTo(45).priorityHigh();
        (weakSelf.cancelButton)?make.width.equalTo(weakSelf.mas_width).multipliedBy(0.5):make.width.equalTo(weakSelf.mas_width).priorityHigh();
    }];
    
    if(self.cancelButton){
        [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.equalTo(weakSelf);
            make.height.mas_equalTo(45);
            make.width.equalTo(weakSelf.mas_width).multipliedBy(0.5);
        }];
    }
}

-(void)updateConstraints{
    [self updateMansonryConstrains];
    [super updateConstraints];
}

-(void)updateMansonryConstrains{
    DEFWEAKSELF;
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel.text.length?45:0).priorityHigh();
    }];
    
    [self.submitButton mas_updateConstraints:^(MASConstraintMaker *make) {;
        (weakSelf.cancelButton)?make.width.equalTo(weakSelf.mas_width).multipliedBy(0.5):make.width.equalTo(weakSelf.mas_width).priorityHigh();
    }];
    
    if(self.cancelButton){
        [self.cancelButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.equalTo(weakSelf);
            make.height.mas_equalTo(45);
            make.width.equalTo(weakSelf.mas_width).multipliedBy(0.5);
        }];
    }

}

-(void)setTitle:(NSString *)title{
    self.titleLabel.text=title;
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [self layoutIfNeeded];
}
#pragma mark - 按钮
-(void)buildOrLayoutButtons{
    [self buildOrLayoutCancelButton];
    [self buildOrLayoutSubmitButton];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [self layoutIfNeeded];
}

-(void)buildOrLayoutSubmitButton{
    if(self.submitButtonTitle.length){
        if(!self.submitButton){
            self.submitButton=[UIButton buttonWithType:UIButtonTypeCustom];
            [self.submitButton addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:self.submitButton];
        }
    }
    
    if(self.submitButton){
        [self.submitButton setTitle:self.submitButtonTitle forState:UIControlStateNormal];
        [self.submitButton setTitleColor:self.submitButtonColor forState:UIControlStateNormal];
        self.submitButton.titleLabel.font=[UIFont systemFontOfSize:14];
    }
}

-(void)buildOrLayoutCancelButton{
    if(self.cancelButtonTitle.length){
        if(!self.cancelButton){
            self.cancelButton=[UIButton buttonWithType:UIButtonTypeCustom];
            [self.cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:self.cancelButton];
        }
    }
    
    if(self.cancelButton){
        [self.cancelButton setTitle:self.cancelButtonTitle forState:UIControlStateNormal];
        [self.cancelButton setTitleColor:self.cancelButtonColor forState:UIControlStateNormal];
        [self.cancelButton setTitleColor:[UIColor getColor:@"888888"] forState:UIControlStateNormal];
        self.cancelButton.titleLabel.font=[UIFont systemFontOfSize:14];
    }
}

-(void)submitAction{
    RUN(self.submitBlock);
}

-(void)cancelAction{
    RUN(self.cancelBlock);
}
#pragma mark - submitButtonTitle 刷新UI
-(void)setSubmitButtonTitle:(NSString *)title textColor:(UIColor *)color{
    self.submitButtonTitle=title;
    self.submitButtonColor=color;
}

-(void)setSubmitButtonColor:(UIColor *)submitButtonColor{
    if(_submitButtonColor==submitButtonColor){
        return;
    }
    _submitButtonColor=submitButtonColor;
    [self buildOrLayoutButtons];
}

-(void)setSubmitButtonTitle:(NSString *)submitButtonTitle{
    if([_submitButtonTitle isEqualToString:submitButtonTitle]){
        return;
    }
    _submitButtonTitle=submitButtonTitle;
    [self buildOrLayoutButtons];
}

#pragma mark - cancelButtonTitle 退出
-(void)setCancelButtonTitle:(NSString *)title textColor:(UIColor *)color{
    self.cancelButtonTitle=title;
    self.cancelButtonColor=color;
}

-(void)setCancelButtonColor:(UIColor *)cancelButtonColor{
    if(_cancelButtonColor==cancelButtonColor){
        return;
    }
    _cancelButtonColor=cancelButtonColor;
    [self buildOrLayoutButtons];
}

-(void)setCancelButtonTitle:(NSString *)cancelButtonTitle{
    if([_cancelButtonTitle isEqualToString:cancelButtonTitle]){
        return;
    }
    _cancelButtonTitle=cancelButtonTitle;
    [self buildOrLayoutButtons];
}


-(void)drawRect:(CGRect)rect{
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1);
    
    if(self.titleLabel.text.length){
        CGContextSetStrokeColorWithColor(context, [UIColor getColor:@"eeeeee"].CGColor);
        CGContextMoveToPoint(context, 3, 45);
        CGContextAddLineToPoint(context, rect.size.width-3, 45);
        CGContextDrawPath(context, kCGPathFillStroke);
    }
    
    if(self.cancelButtonTitle.length){
        CGContextSetStrokeColorWithColor(context, [UIColor getColor:@"eeeeee"].CGColor);
        CGContextMoveToPoint(context, rect.size.width/2, rect.size.height-45);
        CGContextAddLineToPoint(context, rect.size.width/2, rect.size.height);
        CGContextDrawPath(context, kCGPathFillStroke);
    }
    
    CGContextSetStrokeColorWithColor(context, [UIColor getColor:@"eeeeee"].CGColor);
    CGContextMoveToPoint(context, 0, rect.size.height-45);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height-45);
    
    CGContextDrawPath(context, kCGPathFillStroke);
}

-(void)dealloc{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
