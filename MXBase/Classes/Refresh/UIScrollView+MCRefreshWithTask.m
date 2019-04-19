//
//  UIScrollView+MCRefreshWithTask.m
//  DCPackageTableView
//
//  Created by fzw on 2018/12/23.
//  Copyright © 2018 fzw. All rights reserved.
//

#import "UIScrollView+MCRefreshWithTask.h"
#import "MJRefresh.h"
#import "NSObject+YYAdd.h"
#import "UIColor+Addition.h"

@implementation UIScrollView (MCRefreshWithTask)
static NSString *propertyKey = @"propertyKey";
- (void)setTaskDelegate:(id<MCRefreshTaskDelegate>)taskDelegate {
    [self setAssociateWeakValue:taskDelegate withKey:&propertyKey];
}

- (id<MCRefreshTaskDelegate>)taskDelegate {
    return [self getAssociatedValueForKey:&propertyKey];
}

#pragma mark - init
- (void)addLoadNewComponent {
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    NSArray *loadingImageArray = [self loadingImageArray];
    [header setImages:loadingImageArray duration:loadingImageArray.count * 0.03 forState:MJRefreshStateIdle];
    [header setImages:loadingImageArray duration:loadingImageArray.count * 0.03 forState:MJRefreshStatePulling];
    [header setImages:loadingImageArray duration:loadingImageArray.count * 0.03 forState:MJRefreshStateRefreshing];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.mj_header = header;
}

- (void)addLoadMoreComponent {
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    footer.stateLabel.font = [UIFont systemFontOfSize:13];
    footer.stateLabel.textColor = [UIColor getColor:@"a1abbc"];
    self.mj_footer = footer;
}

#pragma mark - event
- (void)loadNewData {
    // 如果加载更多正在执行，结束UI和任务
    if ([self isRefreshingAtLoadMoreComponent]) {
        [self endRefreshingAtLoadMoreComponentAndStopTask];
    }
    
    if ([self isLoadMoreTaskRunning]) {
        [self stopLoadMoreTask];
    }
    
    // 取消上一次的任务
    if ([self isLoadNewTaskRunning]) {
        [self stopLoadNewTask];
    }
    
    // 开始执行任务
    [self startLoadNewTaskWithCompletionBlock:^(BOOL noMore, BOOL empty) {
        [self changeFooterStateWhenLoadNewTaskFinishedWithNoMore:noMore empty:empty];
        [self endRefreshingAtLoadNewComponent];
    }];
}


- (void)loadMoreData {
    // 如果loadNew正在刷新 返回
    // 如果loadNew任务正在执行 返回
    if ([self isRefreshingAtLoadNewComponent] || [self isLoadNewTaskRunning]) {
        [self endRefreshingAtLoadMoreComponentAndStopTask];
        return;
    }
    
    // 如果loadMore没有处于刷新状态 结束loadMoreTask并返回 (可能是因为执行动画中被打断了)
    if (![self isRefreshingAtLoadMoreComponent]) {
        [self stopLoadMoreTask];
    }
    
    // 如果这时候loadMore还在执行，继续让他执行，return即可
    if ([self isLoadMoreTaskRunning]) {
        return;
    }
    
    // 开始执行任务
    [self startLoadMoreTaskWithCompletionBlock:^(BOOL noMore, BOOL empty) {
        [self changeFooterStateWhenAddMoreTaskFinishedWithNoMore:noMore empty:empty];
    }];
}

#pragma mark - task
- (BOOL)isLoadNewTaskRunning {
    return [self.taskDelegate isLoadNewTaskRunning];
}

- (BOOL)isLoadMoreTaskRunning {
    return [self.taskDelegate isLoadMoreTaskRunning];
}

- (void)stopLoadNewTask {
    [self.taskDelegate stopLoadNewTask];
}

- (void)stopLoadMoreTask {
    [self.taskDelegate stopLoadMoreTask];
}

- (void)startLoadNewTaskWithCompletionBlock:(void(^)(BOOL noMore, BOOL empty))completionBlock {
    [self.taskDelegate startLoadNewTaskWithCompletionBlock:completionBlock];
}

- (void)startLoadMoreTaskWithCompletionBlock:(void(^)(BOOL noMore, BOOL empty))completionBlock {
    [self.taskDelegate startLoadMoreTaskWithCompletionBlock:completionBlock];
}

#pragma mark - loadNewcontrol
- (BOOL)isRefreshingAtLoadNewComponent {
    return self.mj_header.isRefreshing;
}

- (void)startRefreshingAtLoadNewComponent {
    [self startRefreshingAtLoadNewComponentIfPossibly];
}

- (void)forceStartRefreshingAtLoadNewComponent {
    // 取消之前的
    [self endRefreshingAtLoadNewComponent];
    // 中止任务
    if ([self isLoadNewTaskRunning]) {
        [self stopLoadNewTask];
    }
    [self startRefreshingAtLoadNewComponentIfPossibly];
}

- (void)endRefreshingAtLoadNewComponent {
    [self.mj_header endRefreshing];
}

// 因为MJRefresh机制，这里不一定会执行
- (void)startRefreshingAtLoadNewComponentIfPossibly {
    [self.mj_header beginRefreshing];
}

#pragma mark - loadMoreControl
- (BOOL)isRefreshingAtLoadMoreComponent {
    return self.mj_footer.isRefreshing;
}
- (void)startRefreshingAtLoadMoreComponent {
    [self.mj_footer beginRefreshing];
}

- (void)endRefreshingAtLoadMoreComponentAndStopTask {
    [self endRefreshingAtLoadMoreComponent];
    [self stopLoadMoreTask];
}

- (void)endRefreshingAtLoadMoreComponent {
    [self.mj_footer endRefreshing];
}

- (void)resetNoMoreDataAtLoadMoreComponent {
    [self.mj_footer resetNoMoreData];
}

- (void)endRefreshingAtLoadMoreComponentWithNoMoreData {
    [self.mj_footer endRefreshingWithNoMoreData];
}

- (void)setTitleAtLoadMoreComponentWhenNoMoreData:(NSString *)title {
    MJRefreshAutoNormalFooter *footer = (MJRefreshAutoNormalFooter *)self.mj_footer;
    [footer setTitle:title forState:MJRefreshStateNoMoreData];
}

-(void)changeFooterStateWhenLoadNewTaskFinishedWithNoMore:(BOOL)noMore empty:(BOOL)empty{
    if(noMore==NO && empty==NO) {
        [self.mj_footer resetNoMoreData];
        return;
    }
    [self changeFooterStateToNoMoreWithEmpty:empty];
}

-(void)changeFooterStateWhenAddMoreTaskFinishedWithNoMore:(BOOL)noMore empty:(BOOL)empty{
    if(noMore || empty) {
        [self changeFooterStateToNoMoreWithEmpty:empty];
        return;
    }
    [self resetNoMoreDataAtLoadMoreComponent];
    [self endRefreshingAtLoadMoreComponent];
}

-(void)changeFooterStateToNoMoreWithEmpty:(BOOL)empty {
    if(empty) {
        [self setTitleAtLoadMoreComponentWhenNoMoreData:@""];
    }else {
        [self setTitleAtLoadMoreComponentWhenNoMoreData:@"暂无更多数据了"];
    }
    [self endRefreshingAtLoadMoreComponentWithNoMoreData];
}

#pragma mark -
- (NSMutableArray *)loadingImageArray {
    NSMutableArray *_loadingImageArray = [NSMutableArray array];
    for (int i = 0; i < 50; i++) {
        [_loadingImageArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"Comp 5_000%d",i+44]]];
    }
    return _loadingImageArray;
}
@end
