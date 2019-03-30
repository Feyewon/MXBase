//
//  MXErrorView.h
//  TestTopicPage
//
//  Created by 邓光洋 on 2019/3/29.
//  Copyright © 2019 cn.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MXErrorView : UIView

@property (nonatomic, strong) UIImage *notifyImage;
@property (nonatomic, strong) UIImage *overTimeImage;

@property (nonatomic, copy) void(^freshNetworkBlock)(void);

@end

