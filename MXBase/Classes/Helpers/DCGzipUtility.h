//
//  DCGzipUtility.h
//  梦想旅行
//
//  Created by fzw on 16/8/26.
//  Copyright © 2016年 北京梦想智联科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCGzipUtility : NSObject
// 数据压缩
+ (NSData *)compressData:(NSData*)uncompressedData;
// 数据解压缩
+ (NSData *)decompressData:(NSData *)compressedData;
@end
