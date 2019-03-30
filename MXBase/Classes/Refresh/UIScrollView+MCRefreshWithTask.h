//
//  UIScrollView+MCRefreshWithTask.h
//  DCPackageTableView
//
//  Created by fzw on 2018/12/23.
//  Copyright © 2018 fzw. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MCRefreshTaskDelegate <NSObject>
@required;
- (BOOL)isLoadNewTaskRunning;
- (BOOL)isLoadMoreTaskRunning;
- (void)stopLoadNewTask;
- (void)stopLoadMoreTask;
- (void)startLoadNewTaskWithCompletionBlock:(void(^)(BOOL noMore, BOOL empty))completionBlock;
- (void)startLoadMoreTaskWithCompletionBlock:(void(^)(BOOL noMore, BOOL empty))completionBlock;
@end

@interface UIScrollView (MCRefreshWithTask)
@property (nonatomic,weak) id<MCRefreshTaskDelegate> taskDelegate;
- (void)addLoadNewComponent;
- (void)addLoadMoreComponent;

// head
- (void)startRefreshingAtLoadNewComponent;
- (void)forceStartRefreshingAtLoadNewComponent;

// foot
- (void)startRefreshingAtLoadMoreComponent;
@end
