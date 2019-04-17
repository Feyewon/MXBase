//
//  DCAlertBackgroundViewV2.m
//  梦想旅行
//
//  Created by FEI on 2018/6/9.
//  Copyright © 2018年 北京梦想智联科技有限公司. All rights reserved.
//

#import "DCAlertBackgroundViewV2.h"
#import "BigTouchButton.h"
#import "Masonry.h"
#import "UIColor+Addition.h"
#import "MXMacro.h"

@interface DCAlertBackgroundViewV2()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UIButton *submitButton;
@property (nonatomic,strong) BigTouchButton *closeButton;
@end

@implementation DCAlertBackgroundViewV2
-(id)init{
    if(self=[super init]){
        self.submitButtonTitle=@"确认";
        self.submitButtonColor=[UIColor getColor:@"333333"];
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
    self.titleLabel.font=[UIFont boldSystemFontOfSize:17];
    self.titleLabel.textAlignment=NSTextAlignmentCenter;
    self.titleLabel.textColor=[UIColor getColor:@"333333"];
    [self addSubview:self.titleLabel];
    
    self.contentLabel=[UILabel new];
    self.contentLabel.font=[UIFont systemFontOfSize:15];
    self.contentLabel.numberOfLines=0;
    self.contentLabel.textColor=[UIColor getColor:@"78818f"];
    self.contentLabel.textAlignment=NSTextAlignmentCenter;
    [self addSubview:self.contentLabel];
}

-(void)makeMansonryConstrains{
    __weak __typeof(self)weakSelf=self;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf).priorityHigh();
        make.top.equalTo(weakSelf).with.offset(weakSelf.titleLabel.text.length?40:15);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(18).priority(MASLayoutPriorityRequired);
        make.right.equalTo(weakSelf).with.offset(-18).priority(MASLayoutPriorityRequired);
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).with.offset(20).priorityHigh();
    }];
    
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-18);
        make.left.equalTo(weakSelf).with.offset(18);
        make.top.equalTo(weakSelf.contentLabel.mas_bottom).with.offset(30);
        make.height.mas_equalTo(44).priorityHigh();
        make.bottom.equalTo(weakSelf).with.offset(-20).priorityHigh();
    }];
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(weakSelf);
        make.size.mas_equalTo((CGSize){32,32});
    }];
}

-(void)updateConstraints{
    [super updateConstraints];
}

-(void)setTitle:(NSString *)title{
    self.titleLabel.text=title;
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [self layoutIfNeeded];
}

#pragma mark - 按钮
-(void)buildOrLayoutButtons{
    [self buildOrLayoutSubmitButton];
    [self buildOrLayoutCloseButton];
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
        self.submitButton.layer.masksToBounds = YES;
        self.submitButton.layer.cornerRadius = 4;
        self.submitButton.titleLabel.font=[UIFont systemFontOfSize:16];
        self.submitButton.backgroundColor = [UIColor getColor:@"FFD53E"];
    }
}

-(void)buildOrLayoutCloseButton{
    if(!self.closeButton){
        self.closeButton=[BigTouchButton buttonWithType:UIButtonTypeCustom];
        self.closeButton.boundInsert = (CGSize){-100,-4};
        self.closeButton.hidden = YES;
        [self.closeButton addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.closeButton];
    }
    
    if(self.closeButton){
        [self.closeButton setBackgroundImage:[UIImage imageNamed:@"alert_close"] forState:UIControlStateNormal];
    }
}

-(void)submitAction{
    RUN(self.submitBlock);
}

-(void)closeAction{
    RUN(self.closeBlock);
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

-(void)setCloseButtonHidden:(BOOL)hidden{
    self.closeButton.hidden = hidden;
}

-(void)dealloc{
    
}


@end
