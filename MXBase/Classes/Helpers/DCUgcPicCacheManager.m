//
//  DCUgcPicCacheManager.m
//  梦想旅行
//
//  Created by fzw on 2017/8/7.
//  Copyright © 2017年 北京梦想智联科技有限公司. All rights reserved.
//

#import "DCUgcPicCacheManager.h"
#import "FCFileManager.h"
@implementation DCUgcPicCacheManager
+(NSString *)imgDir {
    NSString *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    path = [path stringByAppendingString:@"/dcFootprintDrafts"];
    return path;
}

+(NSArray *)saveImageDatasWith:(NSArray <NSData *>*)imageDatas error:(NSError *__autoreleasing *)error{
    NSString *path = [self imgDir];
    if(![FCFileManager existsItemAtPath:path]) {
        BOOL createDir = [FCFileManager createDirectoriesForPath:path error:error];
        if(!createDir) {
            return nil;
        }
    }
    NSMutableArray *savedFilePaths = [NSMutableArray new];
    for(NSData *imgData in imageDatas) {
        
        // 生成文件名和文件路径
        NSString *uuid = [[NSUUID UUID] UUIDString];
        NSString *filename = [path stringByAppendingFormat:@"/%@",uuid];
        
        // 保存文件
        BOOL saveFileRes = [FCFileManager writeFileAtPath:filename content:imgData error:error];
        if(!saveFileRes) {
            // 保存失败 删除保存成功的图片
            [self removeFilesWithPaths:savedFilePaths];
            return nil;
        }
        // 保存成功
        [savedFilePaths addObject:uuid];
    }
    
    return savedFilePaths;
}

+ (NSString *)saveImageDataWith:(NSData *)imageData error:(NSError *__autoreleasing *)error {
    NSString *path = [self imgDir];
    if(![FCFileManager existsItemAtPath:path]) {
        BOOL createDir = [FCFileManager createDirectoriesForPath:path error:error];
        if(!createDir) {
            return nil;
        }
    }
    
    // 生成文件名和文件路径
    NSString *uuid = [[NSUUID UUID] UUIDString];
    NSString *filename = [path stringByAppendingFormat:@"/%@",uuid];
    
    // 保存文件
    BOOL saveFileRes = [FCFileManager writeFileAtPath:filename content:imageData error:error];
    if(!saveFileRes) {
        // 保存失败 删除保存成功的图片
        return nil;
    }
    return uuid;
}

+(NSArray <NSData *>*)getImageDatasWithPaths:(NSArray *)paths error:(NSError *__autoreleasing *)error{
    NSMutableArray *datas = [NSMutableArray new];
    NSString *imgDir = [self imgDir];
    for(NSString *path in paths) {
        NSString *filename = [imgDir stringByAppendingFormat:@"/%@",path];
        if(![FCFileManager existsItemAtPath:filename]) {
            *error=[NSError errorWithDomain:@"cn.mxtrip" code:500 userInfo:[NSDictionary dictionaryWithObject:@"未找到图片" forKey:NSLocalizedDescriptionKey]];
            return nil;
        }
        NSData *data = [FCFileManager readFileAtPathAsData:filename];
        [datas addObject:data];
    }
    return datas;
}

+(NSData *)getImageDataWithPath:(NSString *)path error:(NSError *__autoreleasing *)error {
    
    NSString *imgDir = [self imgDir];
    NSString *filename = [imgDir stringByAppendingFormat:@"/%@",path];
    if(![FCFileManager existsItemAtPath:filename]) {
        if (error) {
            *error=[NSError errorWithDomain:@"cn.mxtrip" code:500 userInfo:[NSDictionary dictionaryWithObject:@"未找到图片" forKey:NSLocalizedDescriptionKey]];
        }
        return nil;
    }
    NSData *data = [FCFileManager readFileAtPathAsData:filename];
    return data;
}

+(void)removeFilesWithPaths:(NSArray *)paths {
    NSString *imgDir = [self imgDir];
    for(NSString *savedFile in paths) {
        NSString *filename = [imgDir stringByAppendingFormat:@"/%@",savedFile];
        NSError *error;
        [FCFileManager removeItemAtPath:filename error:&error];
    }
}

+(NSString *)getFullPathWithName:(NSString *)name {
    NSString *imgDir = [self imgDir];
    NSString *filename = [imgDir stringByAppendingFormat:@"/%@",name];
    return filename;
}
@end
