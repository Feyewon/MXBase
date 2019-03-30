//
//  MXKeyChainManager.h
//  MagicCamera
//
//  Created by fzw on 2018/12/24.
//  Copyright © 2018 Mxtrip. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXKeyChainManager : NSObject
+ (NSString *)stringForKey:(NSString *)key error:(NSError * __nullable __autoreleasing * __nullable)error;
+ (BOOL)setString:(nullable NSString *)string forKey:(NSString * )key error:(NSError * __nullable __autoreleasing * __nullable)error;

+ (NSData *)dataForKey:(NSString *)key error:(NSError * __nullable __autoreleasing * __nullable)error;
+ (BOOL)setData:(nullable NSData *)data forKey:(NSString * )key error:(NSError * __nullable __autoreleasing * __nullable)error;


+ (void)removeItemForKey:(NSString *)key;
@end
