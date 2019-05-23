//
//  UIViewController+KHEmptyView.m
//  KHMessageModule_Example
//
//  Created by 邓光洋 on 2019/5/23.
//  Copyright © 2019 dgyiOS. All rights reserved.
//

#import "UIViewController+KHEmptyView.h"
#import "Masonry.h"
#import "UIColor+Addition.h"
#import <objc/runtime.h>

@interface KHEmptyView : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *tipLab;
@property (nonatomic, strong) UIButton *refreshBtn;

@property (nonatomic, copy) void(^refreshActionBlock)(void);

@end

@implementation KHEmptyView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self buildSubviews];
        [self buildSubviewsConstraints];
    }
    return self;
}

- (void)buildSubviews {
    self.imageView = ({
        UIImageView *imgV = [[UIImageView alloc] init];
        imgV.contentMode = UIViewContentModeScaleAspectFill;
        imgV.layer.masksToBounds = YES;
        imgV.image = [UIImage imageNamed:@"content_noData"];
        imgV;
    });
    
    self.tipLab = ({
        UILabel *lab = [[UILabel alloc] init];
        lab.font = [UIFont boldSystemFontOfSize:14.f];
        lab.textColor = [UIColor getColor:@"333333"];
        lab.textAlignment = NSTextAlignmentCenter;
        lab;
    });
    
    self.refreshBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [btn setTitleColor:[UIColor getColor:@"218fff"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(refreshAction:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
}

- (void)buildSubviewsConstraints {
    [self addSubview:self.imageView];
    [self addSubview:self.tipLab];
    [self addSubview:self.refreshBtn];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(150, 150));
    }];
    
    [self.tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageView.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self.imageView.mas_centerX);
    }];
    
    [self.refreshBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tipLab.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self.imageView.mas_centerX);
    }];
}

- (void)refreshAction:(UIButton *)sender {
    if (self.refreshActionBlock) {
        self.refreshActionBlock();
    }
}

@end

static NSString *noDataViewKey = @"noDataViewKey";

@interface UIViewController ()

@property (nonatomic, strong) KHEmptyView *noDataView;

@end

@implementation UIViewController (KHEmptyView)

- (void)setNoDataView:(KHEmptyView *)noDataView {
    objc_setAssociatedObject(self, &noDataViewKey, noDataView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (KHEmptyView *)noDataView {
    KHEmptyView *emptyView = objc_getAssociatedObject(self, &noDataViewKey);
    if (!emptyView) {
        emptyView = [self createEmptyView];
        objc_setAssociatedObject(self, &noDataViewKey, emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return emptyView;
}

- (KHEmptyView *)createEmptyView {
    KHEmptyView *view = [[KHEmptyView alloc] init];
    view.userInteractionEnabled = NO;
    return view;
}

///图片 + 提示文字
- (void)showEmptyViewInSuperView:(UIView *)superView
                           image:(UIImage *)image
                        tipTitle:(NSString *)tipTitle {
    
    [superView addSubview:self.noDataView];
    [self.noDataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.noDataView.hidden = NO;
    self.noDataView.tipLab.text = tipTitle;
    self.noDataView.imageView.image = image;
}

///图片 + 文字 + 刷新文字
- (void)showEmptyViewInSuperView:(UIView *)superView
                           image:(UIImage *)image
                        tipTitle:(NSString *)tipTitle
                 refreshBtnTitle:(NSString *)refreshBtnTitle
                 refreshCallback:(void(^)(void))refreshCallback {
    
    [self showEmptyViewInSuperView:superView image:image tipTitle:tipTitle];
    [self.noDataView.refreshBtn setTitle:refreshBtnTitle forState:UIControlStateNormal];
    
    self.noDataView.refreshActionBlock = ^{
        if (refreshCallback) {
            refreshCallback();
        }
    };
}

- (void)hiddenEmptyView {
    self.noDataView.hidden = YES;
}


@end
