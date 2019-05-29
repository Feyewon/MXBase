//
//  UIView+SWRefresh.h
//  仿微信朋友圈下拉刷新
//
//  Created by psw on 2017/7/19.
//  Copyright © 2017年 jwdata. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,StatusOfRefresh) {
    SWREFRESH_Default = 1,     //非刷新状态，该值不能为0
    SWREFRESH_BeginRefresh,    //刷新状态
    SWREFRESH_None             //全非状态（既不是刷新 也不是 非刷新状态）
};

@class RefreshView;

@interface UIView (SWRefresh)
// 监测范围的临界点,>0代表向上滑动多少距离,<0则是向下滑动多少距离
@property (nonatomic, assign)CGFloat threshold;

// 记录scrollView.contentInset.top
@property (nonatomic, assign)CGFloat marginTop;

//记录刷新状态
@property (nonatomic, assign)StatusOfRefresh refreshStatus;

//用于刷新回调
@property (nonatomic, copy)void(^refreshBlock)(void);

//刷新动画
@property (nonatomic, strong) CABasicAnimation *animation;

//偏移量累加
@property (nonatomic, assign) CGFloat offsetCollect;

//刷新view
@property (nonatomic, strong) RefreshView *refreshView;

//用于承接需要刷新的下拉刷新的extenScrollView
@property (nonatomic, strong) UIScrollView *extenScrollView;

/**
 * 下拉刷新
 * @param scrollView 需要添加刷新的tableview
 * @param position icon位置（默认：{10，34}navBar左上角）
 * @param block 刷新回调
 */
- (void)sw_refreshWithObject:(UIScrollView *)scrollView atPoint:(CGPoint)position downRefresh:(void(^)(void))block;

/**
 * 开始刷新动作
 */
- (void)beginRefresh;

/**
 * 结束刷新动作
 */
- (void)sw_endRefresh;

/**
 * 释放观察者
 */
- (void)sw_freeReFresh;

@end

@interface RefreshView : UIScrollView
//刷新view的icon
@property (nonatomic, strong)UIImageView *refreshIcon;

@end
