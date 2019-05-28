//
//  MXErrorView.m
//  TestTopicPage
//
//  Created by 邓光洋 on 2019/3/29.
//  Copyright © 2019 cn.com. All rights reserved.
//

#import "MXErrorView.h"
#import "Masonry.h"
#import "NSString+Addition.h"
#import "UIColor+Addition.h"

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
        self.backgroundColor = [UIColor getColor:@"f5f6f7"]; // #252B56
        [self buildSubviews];
        [self addMasonryConstrains];
    }
    return self;
}

- (void)buildSubviews {
    self.topBackgroundView = [UIView new];
    self.topBackgroundView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.topBackgroundView];
    
    UIImage *notifyImage = [UIImage imageNamed:@"request_noNet"];
    self.iconImageView = [[UIImageView alloc] initWithImage:notifyImage];
    [self.topBackgroundView addSubview:self.iconImageView];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.textColor = [UIColor getColor:@"a1abbc"];   // #555555
    self.titleLabel.text = @"网络请求超时";
    [self.topBackgroundView addSubview:self.titleLabel];
    
    self.contentLabel = [UILabel new];
    self.contentLabel.font = [UIFont systemFontOfSize:14];
    self.contentLabel.textColor = [UIColor getColor:@"a1abbc"]; // #aaaaaa
    self.contentLabel.text = @"稍后请刷新重试";
    [self.topBackgroundView addSubview:self.contentLabel];
    
    self.freshButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.freshButton setTitle:@"刷新" forState:UIControlStateNormal];
    [self.freshButton setBackgroundColor:[UIColor getColor:@"218FFF"]];
    self.freshButton.titleLabel.font = [UIFont systemFontOfSize:15];
    self.freshButton.layer.masksToBounds = YES;
    self.freshButton.layer.cornerRadius = 20;
    [self.freshButton addTarget:self action:@selector(freshNetworkAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.freshButton];
}

- (void)addMasonryConstrains {
    __weak __typeof(self)weakSelf=self;
    [self.topBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.equalTo(weakSelf.mas_width);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.topBackgroundView);
        make.size.mas_equalTo((CGSize){200,200});
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
        make.size.mas_equalTo((CGSize){110,40});
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

