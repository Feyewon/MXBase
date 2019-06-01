//
//  PayAlertBackgroundView.m
//  梦想旅行
//
//  Created by FEI on 16/10/19.
//  Copyright © 2016年 北京梦想智联科技有限公司. All rights reserved.
//

#import "PayAlertBackgroundView.h"
#import "Masonry.h"
#import "UIColor+Addition.h"
#import "MXMacro.h"

@interface PayAlertBackgroundView()
@property(nonatomic,strong) UIImageView *logoImageView;
@property(nonatomic,strong) UILabel *titleLab;
@property(nonatomic,strong) UILabel *contentLab;
@property(nonatomic,strong) UIView *sepView;
@property(nonatomic,strong) UIView *vLineView;
@property(nonatomic,strong) UIButton *leftBtn;
@property(nonatomic,strong) UIButton *rightBtn;
@end

@implementation PayAlertBackgroundView

-(instancetype)init{
    if (self = [super init]) {
        [self buildSubviews];
        [self addMasonryConstraint];
    }
    return self;
}

-(void)buildSubviews{
    [self addSubview:self.logoImageView];
    [self addSubview:self.titleLab];
    [self addSubview:self.contentLab];
    [self addSubview:self.sepView];
    [self addSubview:self.vLineView];
    [self addSubview:self.lookOrderBtn];
    [self addSubview:self.leftBtn];
    [self addSubview:self.rightBtn];
}

-(void)addMasonryConstraint{
    DEFWEAKSELF;
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(20);
        make.top.equalTo(weakSelf).with.offset(30);
        make.size.mas_equalTo((CGSize){40,40});
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(30);
        make.left.equalTo(weakSelf.logoImageView.mas_right).with.offset(10);
    }];
    
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLab.mas_bottom).with.offset(15);
        make.left.equalTo(weakSelf.logoImageView.mas_right).with.offset(10);
        make.right.equalTo(weakSelf.mas_right).with.offset(-20);
    }];
    
    [self.sepView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf);
        make.height.mas_equalTo(1);
        make.top.equalTo(weakSelf.contentLab.mas_bottom).with.offset(30);
    }];
    
    [self.vLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.lookOrderBtn);
        make.size.mas_equalTo((CGSize){1,30});
        make.centerX.equalTo(weakSelf.lookOrderBtn);
    }];
    
    [self.lookOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.sepView.mas_bottom);
        make.left.right.equalTo(weakSelf);
        make.height.mas_equalTo(49);
        make.bottom.equalTo(weakSelf);
    }];
    
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.sepView.mas_bottom);
        make.height.mas_equalTo(49);
        make.left.mas_equalTo(weakSelf);
        make.width.equalTo(weakSelf).multipliedBy(0.5);
        make.bottom.equalTo(weakSelf);
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.sepView.mas_bottom);
        make.height.mas_equalTo(49);
        make.left.mas_equalTo(weakSelf.leftBtn.mas_right);
        make.width.equalTo(weakSelf).multipliedBy(0.5);
        make.bottom.equalTo(weakSelf);
    }];
    
    
}

-(UIImageView *)logoImageView{
    if (!_logoImageView) {
        _logoImageView = [UIImageView new];
    }
    return _logoImageView;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.textColor = [UIColor getColor:@"333333"];
        _titleLab.font = [UIFont boldSystemFontOfSize:20];
        _titleLab.text = @"支付成功";
    }
    return _titleLab;
}

-(UILabel *)contentLab{
    if (!_contentLab) {
        _contentLab = [UILabel new];
        _contentLab.text = @"请耐心等待商家确认订单";
        _contentLab.textColor = [UIColor getColor:@"333333"];
        _contentLab.font = [UIFont systemFontOfSize:15];
        _contentLab.numberOfLines = 0;
    }
    return _contentLab;
}

-(UIView *)sepView{
    if (!_sepView) {
        _sepView = [UIView new];
        _sepView.backgroundColor = [UIColor getColor:@"e6e6f0"];
    }
    return _sepView;
}

-(UIView *)vLineView{
    if (!_vLineView) {
        _vLineView = [UIView new];
        _vLineView.backgroundColor = [UIColor getColor:@"e6e6f0"];
    }
    return _vLineView;
}

-(UIButton *)lookOrderBtn{
    if (!_lookOrderBtn) {
        _lookOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_lookOrderBtn setTitle:@"查看订单" forState:UIControlStateNormal];
        _lookOrderBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [_lookOrderBtn setTitleColor:[UIColor getColor:@"00b7a8"] forState:UIControlStateNormal];
        _lookOrderBtn.clipsToBounds=YES;
        _lookOrderBtn.layer.cornerRadius=2;
        [_lookOrderBtn addTarget:self action:@selector(submitButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lookOrderBtn;
}

-(UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [_leftBtn setTitleColor:[UIColor getColor:@"a0abbb"] forState:UIControlStateNormal];
        _leftBtn.clipsToBounds=YES;
        _leftBtn.layer.cornerRadius=2;
        [_leftBtn addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

-(UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [_rightBtn setTitleColor:[UIColor getColor:@"00b7a8"] forState:UIControlStateNormal];
        _rightBtn.clipsToBounds=YES;
        _rightBtn.layer.cornerRadius=2;
        [_rightBtn addTarget:self action:@selector(submitButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

-(void)cancelButtonAction{
    RUN(self.cancelBlock);
}

-(void)submitButtonAction{
    RUN(self.submitBlock);
}

-(void)setAlertviewType:(PayAlertBackgroundViewType)alertviewType{
    switch (alertviewType) {
        case PayAlertBackgroundViewTypeSuccess:
            self.leftBtn.hidden = YES;
            self.rightBtn.hidden = YES;
            self.lookOrderBtn.hidden = NO;
            self.vLineView.hidden = YES;
            break;
        case PayAlertBackgroundViewTypeFail:
            
        case PayAlertBackgroundViewTypeAssert:
            
        case PayAlertBackgroundViewTypeCancel:
            self.leftBtn.hidden = NO;
            self.rightBtn.hidden = NO;
            self.lookOrderBtn.hidden = YES;
            self.vLineView.hidden = NO;
            break;
        default:
            break;
    }
}
@end
