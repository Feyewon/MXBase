//
//  NSTimer+Addition.h
//  梦想旅行
//
//  Created by fzw on 15/5/21.
//  Copyright (c) 2015年 北京梦想智联科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Addition)
- (void)pauseTimer;
- (void)resumeTimer;
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;
@end
