//
//  MXErrorView.m
//  TestTopicPage
//
//  Created by 邓光洋 on 2019/3/29.
//  Copyright © 2019 cn.com. All rights reserved.
//

#import "MXErrorView.h"
#import "Masonry.h"

@interface MXErrorView ()

@property (nonatomic,strong) UIView *topBackgroundView;
@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UIButton *freshButton;

@end

@implementation MXErrorView

- (id)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithRed:37 / 255 green:43 / 255 blue:86 / 255 alpha:1]; // #252B56
        [self buildSubviews];
        [self addMasonryConstrains];
    }
    return self;
}

- (void)buildSubviews {
    self.topBackgroundView = [UIView new];
    self.topBackgroundView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.topBackgroundView];
    
    self.iconImageView = [[UIImageView alloc] initWithImage:self.notifyImage];
    [self.topBackgroundView addSubview:self.iconImageView];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.textColor = [UIColor colorWithRed:85 / 255 green:85 / 255 blue:85 / 255 alpha:1];   // #555555
    self.titleLabel.text = @"网络请求超时";
    [self.topBackgroundView addSubview:self.titleLabel];
    
    self.contentLabel = [UILabel new];
    self.contentLabel.font = [UIFont systemFontOfSize:14];
    self.contentLabel.textColor = [UIColor colorWithRed:170 / 255 green:170 / 255 blue:170 / 255 alpha:1]; // #aaaaaa
    self.contentLabel.text = @"稍后请刷新重试";
    [self.topBackgroundView addSubview:self.contentLabel];
    
    self.freshButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.freshButton setImage:self.overTimeImage forState:UIControlStateNormal];
    [self addSubview:self.freshButton];
    [self.freshButton addTarget:self action:@selector(freshNetworkAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addMasonryConstrains {
    __weak __typeof(self)weakSelf=self;
    [self.topBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.centerY.equalTo(weakSelf.mas_centerY).with.offset(-70);
        make.width.equalTo(weakSelf.mas_width);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.topBackgroundView);
        make.centerX.equalTo(weakSelf.topBackgroundView.mas_centerX);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.iconImageView.mas_bottom).with.offset(22);
        make.centerX.equalTo(weakSelf.topBackgroundView.mas_centerX);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).with.offset(8);
        make.centerX.equalTo(weakSelf.topBackgroundView.mas_centerX);
    }];
    
    [self.freshButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentLabel.mas_bottom).with.offset(20);
        make.centerX.equalTo(weakSelf.topBackgroundView.mas_centerX);
        make.bottom.equalTo(weakSelf.topBackgroundView);
    }];
}


- (void)setTypeDefault {
    self.iconImageView.image = self.notifyImage;
    self.titleLabel.textColor = [UIColor colorWithRed:85 / 255 green:85 / 255 blue:85 / 255 alpha:1];   // #555555
    self.backgroundColor = [UIColor colorWithRed:237 / 255 green:237 / 255 blue:237 / 255 alpha:1];    // #ededed
}

- (void)setNotifyImage:(UIImage *)notifyImage {
    if (notifyImage) {
        self.iconImageView.image = notifyImage;
    }
}

- (void)setOverTimeImage:(UIImage *)overTimeImage {
    if (overTimeImage) {
        [self.freshButton setImage:overTimeImage forState:UIControlStateNormal];
    }
}

- (void)freshNetworkAction {
    if (self.freshNetworkBlock) {
        self.freshNetworkBlock();
    }
}

@end
