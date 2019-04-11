//
//  MXLoadingView.m
//  TestTopicPage
//
//  Created by 邓光洋 on 2019/3/29.
//  Copyright © 2019 cn.com. All rights reserved.
//

#import "MXLoadingView.h"
#import "FBShimmeringView.h"
#import "Masonry.h"

@implementation MXLoadingView {
    UIImageView *_icon;
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(80, 80);
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.layer.masksToBounds = YES;
        {
            // 底色 由深变浅
            FBShimmeringView *shimmeringView           = [[FBShimmeringView alloc] initWithFrame:self.bounds];
            shimmeringView.shimmeringOpacity           = 1;
            shimmeringView.shimmeringAnimationOpacity  = 0.9;
            [self configShimmering:shimmeringView];
            shimmeringView.shimmering                  = YES;
            UIView *contentView                        = [[UIView alloc] init];
            contentView.backgroundColor                = [UIColor colorWithRed:16 / 255 green:19 / 255 blue:43 / 255 alpha:1];    // #10132B
            shimmeringView.contentView                 = contentView;
            
            [self addSubview:shimmeringView];
            [shimmeringView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self);
            }];
        }
        
        {
            // icon 由浅变深
            FBShimmeringView *shimmeringView           = [[FBShimmeringView alloc] initWithFrame:self.bounds];
            shimmeringView.shimmeringOpacity           = 0.5;
            shimmeringView.shimmeringAnimationOpacity  = 1;
            [self configShimmering:shimmeringView];
            shimmeringView.shimmering                  = YES;
            UIView *view                               = [UIView new];
            view.backgroundColor                       = [UIColor clearColor];
            _icon                                      = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LOADING_ICON"]];
            _icon.backgroundColor                      = [UIColor clearColor];
            shimmeringView.contentView                 = view;
            
            [view addSubview:_icon];
            [self addSubview:shimmeringView];
            
            [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(view);
                make.size.mas_equalTo(CGSizeMake(80, 80));
            }];
            
            [shimmeringView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self);
            }];
        }
    }
    return self;
}

- (void)configShimmering:(FBShimmeringView *)shimmeringView {
    shimmeringView.shimmeringSpeed             = 60;
    shimmeringView.shimmeringHighlightLength   = 0.8;
    shimmeringView.shimmeringEndFadeDuration   = 0.0;
    shimmeringView.shimmeringBeginFadeDuration = 0.0;
    shimmeringView.shimmeringPauseDuration     = 0.0;
}

- (void)setLoadingImage:(UIImage *)loadingImage {
    if (loadingImage) {
        _icon.image = loadingImage;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.layer.cornerRadius = self.bounds.size.width / 2;
}

@end
