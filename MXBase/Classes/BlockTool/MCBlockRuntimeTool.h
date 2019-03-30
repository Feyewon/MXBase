//
//  MCBlockRuntimeTool.h
//  MagicCamera
//
//  Created by fzw on 2018/12/27.
//  Copyright © 2018 Mxtrip. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MCBlockArguments;


typedef NS_ENUM(NSUInteger, MCBlockRuntimeErrorCode) {
    MCBlockRuntimeErrorMissingBlockSignature = -1024,                 /// The block misses compile time signature info and can't be called.
};

@interface MCBlockRuntimeTool : NSObject

/**
 用block初始化tool
 
 @param block 泛型block
 @param error 用于保存错误
 */
+ (id)toolWithBlock:(id)block error:(NSError * __nullable __autoreleasing * __nullable)error;

/**
 保存参数，从1开始
 
 @param argumentLocation 用于传递参数
 @param idx 保存在第几位 必须从1开始
 */
- (void)setArgument:(void *)argumentLocation atIndex:(NSInteger)idx;


/**
 获取这一位的argument指针占几个字节
 
 @param idx 第几位参数 必须从1开始
 */
- (NSUInteger)argumentPtrSizeAtIndex:(NSInteger)idx;

/**
 运行block
 */
- (void)run;
@end
