//
//  DCUgcPicCacheManager.h
//  梦想旅行
//
//  Created by fzw on 2017/8/7.
//  Copyright © 2017年 北京梦想智联科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCUgcPicCacheManager : NSObject
+(NSString *)imgDir;
+(NSArray *)saveImageDatasWith:(NSArray <NSData *>*)imageDatas error:(NSError *__autoreleasing *)error;
+(NSString *)saveImageDataWith:(NSData *)imageData error:(NSError *__autoreleasing *)error;
+(NSString *)getFullPathWithName:(NSString *)name;
+(NSArray <NSData *>*)getImageDatasWithPaths:(NSArray *)paths error:(NSError *__autoreleasing *)error;
+(NSData *)getImageDataWithPath:(NSString *)path error:(NSError *__autoreleasing *)error;
+(void)removeFilesWithPaths:(NSArray *)paths;
@end
