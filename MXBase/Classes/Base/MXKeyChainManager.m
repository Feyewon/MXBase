//
//  MXKeyChainManager.m
//  MagicCamera
//
//  Created by fzw on 2018/12/24.
//  Copyright © 2018 Mxtrip. All rights reserved.
//

#import "MXKeyChainManager.h"
#import <UICKeyChainStore/UICKeyChainStore.h>

// 为了共享钥匙串
static NSString *const ServiceName = @"cn.kohigh";
static NSInteger kRetryTimes = 3;
@implementation MXKeyChainManager
// 所有操作都要重试三次
+ (NSString *)stringForKey:(NSString *)key error:(NSError * __nullable __autoreleasing * __nullable)error {
    return [self stringForKey:key retryTimes:kRetryTimes error:error];
}

+ (BOOL)setString:(nullable NSString *)string forKey:(NSString * )key error:(NSError * __nullable __autoreleasing * __nullable)error {
    return [self setString:string retryTimes:kRetryTimes forKey:key error:error];
}

+ (NSData *)dataForKey:(NSString *)key error:(NSError * __nullable __autoreleasing * __nullable)error {
    return [self dataForKey:key retryTimes:kRetryTimes error:error];
}

+ (BOOL)setData:(nullable NSData *)data forKey:(NSString * )key error:(NSError * __nullable __autoreleasing * __nullable)error {
    return [self setData:data retryTimes:kRetryTimes forKey:key error:error];
}

+ (NSString *)stringForKey:(NSString *)key retryTimes:(NSInteger)retryTimes error:(NSError * __nullable __autoreleasing * __nullable)error {
    NSError *pError;
    NSString *result = [self.keyChainStore stringForKey:key error:&pError];
    // 成功了退出
    if (!pError) {
        if (error) {
            *error = nil;
        }
        return result;
    }
    // 重试完了退出
    if (retryTimes <= 1) {
        if (error) {
            *error = pError;
        }
        return result;
    }
    return [self stringForKey:key retryTimes:retryTimes-1 error:error];
}

+ (BOOL)setString:(nullable NSString *)string retryTimes:(NSInteger)retryTimes forKey:(NSString * )key error:(NSError * __nullable __autoreleasing * __nullable)error {
    NSError *pError;
    BOOL result = [self.keyChainStore setString:string forKey:key error:&pError];
    // 成功了退出
    if (!pError) {
        if (error) {
            *error = nil;
        }
        return result;
    }
    
    // 重试完了退出
    if (retryTimes <= 1) {
        if (error) {
            *error = pError;
        }
        return result;
    }
    
    return [self setString:string retryTimes:retryTimes-1 forKey:key error:error];
}

+ (NSData *)dataForKey:(NSString *)key retryTimes:(NSInteger)retryTimes error:(NSError * __nullable __autoreleasing * __nullable)error {
    NSError *pError;
    NSData *result = [self.keyChainStore dataForKey:key error:&pError];
    // 成功了退出
    if (!pError) {
        if (error) {
            *error = nil;
        }
        return result;
    }
    // 重试完了退出
    if (retryTimes <= 1) {
        if (error) {
            *error = pError;
        }
        return result;
    }
    return [self dataForKey:key retryTimes:retryTimes-1 error:error];
}

+ (BOOL)setData:(nullable NSData *)data retryTimes:(NSInteger)retryTimes forKey:(NSString * )key error:(NSError * __nullable __autoreleasing * __nullable)error {
    NSError *pError;
    BOOL result = [self.keyChainStore setData:data forKey:key error:&pError];
    // 成功了退出
    if (!pError) {
        if (error) {
            *error = nil;
        }
        return result;
    }
    
    // 重试完了退出
    if (retryTimes <= 1) {
        if (error) {
            *error = pError;
        }
        return result;
    }
    
    return [self setData:data retryTimes:retryTimes-1 forKey:key error:error];
}

+ (void)removeItemForKey:(NSString *)key {
    [self.keyChainStore removeItemForKey:key];
}

+ (UICKeyChainStore *)keyChainStore {
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:ServiceName];
    return keychain;
}
@end
