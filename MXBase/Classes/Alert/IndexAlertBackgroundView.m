//
//  IndexAlertBackgroundView.m
//  梦想旅行
//
//  Created by fzw on 16/4/13.
//  Copyright © 2016年 北京梦想智联科技有限公司. All rights reserved.
//

#import "IndexAlertBackgroundView.h"
#import "Masonry.h"
#import "UIColor+Addition.h"
#import "MXMacro.h"

@interface IndexAlertBackgroundView ()
@property (nonatomic,strong) UIView *titleBgView;
@end

@implementation IndexAlertBackgroundView

-(id)init{
    if(self=[super init]){
        [self buildSubviews];
    }
    return self;
}

-(void)buildSubviews{
    [self addSubview:self.imageView];
    [self addSubview:self.titleBgView];
    [self.titleBgView addSubview:self.titleLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.cancelButton];
    [self addSubview:self.submitButton];
    
    DEFWEAKSELF;
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(weakSelf);
        make.height.mas_equalTo(weakSelf.imageView.mas_width).with.multipliedBy(20/56.0);
    }];
    
    [self.titleBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf);
        make.top.equalTo(weakSelf.imageView.mas_bottom);
        make.height.mas_equalTo(45);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.titleBgView.mas_centerX);
        make.centerY.equalTo(weakSelf.titleBgView.mas_centerY);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.top.equalTo(weakSelf.titleBgView.mas_bottom);
    }];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(36);
        make.left.equalTo(weakSelf).with.offset(10);
        make.bottom.equalTo(weakSelf).with.offset(-10);
        make.right.equalTo(weakSelf.mas_centerX).with.offset(-5);
    }];
    
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(36);
        make.bottom.equalTo(weakSelf).with.offset(-10);
        make.left.equalTo(weakSelf.mas_centerX).with.offset(5);
        make.right.equalTo(weakSelf).with.offset(-10);
        make.top.equalTo(weakSelf.contentLabel.mas_bottom).with.offset(25).priorityHigh();
    }];
}

-(UIImageView *)imageView{
    if(!_imageView){
        _imageView=[UIImageView new];
    }
    return _imageView;
}

-(UIView *)titleBgView{
    if(!_titleBgView){
        _titleBgView=[UIView new];
    }
    return _titleBgView;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel=[UILabel new];
        _titleLabel.font=[UIFont boldSystemFontOfSize:16];
        _titleLabel.textColor=[UIColor getColor:@"333333"];
        _titleLabel.text=@"当前城市暂未开通";
    }
    return _titleLabel;
}

-(UILabel *)contentLabel{
    if(!_contentLabel){
        _contentLabel=[UILabel new];
        _contentLabel.font=[UIFont systemFontOfSize:13];
        _contentLabel.textAlignment=NSTextAlignmentCenter;
        _contentLabel.numberOfLines=0;
        _contentLabel.textColor=[UIColor getColor:@"565e6a"];
        _contentLabel.text=@"抱歉，您所在的城市尚未开通。敬请期待。\n现在您可以手动选择其它城市";
    }
    return _contentLabel;
}

-(UIButton *)cancelButton{
    if(!_cancelButton){
        _cancelButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.titleLabel.font=[UIFont systemFontOfSize:14];
        [_cancelButton setTitle:@"好的" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor getColor:@"565e6a"] forState:UIControlStateNormal];
        _cancelButton.backgroundColor=[UIColor getColor:@"dde1ea"];
        [_cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _cancelButton.clipsToBounds=YES;
        _cancelButton.layer.cornerRadius=2;
    }
    return _cancelButton;
}

-(UIButton *)submitButton{
    if(!_submitButton){
        _submitButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _submitButton.titleLabel.font=[UIFont systemFontOfSize:14];
        [_submitButton setTitle:@"选择城市" forState:UIControlStateNormal];
        [_submitButton setTitleColor:[UIColor getColor:@"ffffff"] forState:UIControlStateNormal];
        _submitButton.backgroundColor=[UIColor getColor:@"00bcb5"];
        [_submitButton addTarget:self action:@selector(submitButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _submitButton.clipsToBounds=YES;
        _submitButton.layer.cornerRadius=2;
    }
    return _submitButton;
}

-(void)cancelButtonAction{
    RUN(self.cancelBlock);
}

-(void)submitButtonAction{
    RUN(self.submitBlock);
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
