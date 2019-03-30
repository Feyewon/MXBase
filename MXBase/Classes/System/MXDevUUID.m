//
//  MXDevUUID.m
//  MXBase_Example
//
//  Created by FEI on 2019/3/30.
//  Copyright © 2019 Feyewon. All rights reserved.
//

#import "MXDevUUID.h"
#import "MXUserDefaultManager.h"
#import "MXKeyChainManager.h"

NSString *const kMXKeyChainDevUUID    = @"kMXKeyChainDevUUID";
NSString *const kMXUserDefaultDevUUID = @"kMXUserDefaultDevUUID";

@implementation MXDevUUID

+ (NSString *)getDevUUID {
    
    NSString *UUID = self.UUIDAtUserDefaults;
    // userDefaults里有数据，直接返回
    if (UUID.length) {
        [self checkKeyChainUUIDIfNeeded];
        return UUID;
    }
    
    NSError *error;
    UUID = [self UUIDAtKeychainError:&error];
    // 钥匙串里有数据，保存到userDefaults后返回
    if (UUID.length) {
        [self storeUUIDIntoUserDefaults:UUID];
        return UUID;
    }
    
    // 钥匙里没数据，生成数据，保存到钥匙串和userdefault 返回
    UUID = [[NSUUID UUID] UUIDString];
    [self storeUUIDIntoUserDefaults:UUID];
    [self storeUUIDIntoKeychainUntilSuccess:UUID];
    return UUID;
}

+ (void)checkKeyChainUUIDIfNeeded {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *UUID = [self UUIDAtKeychainError:NULL];
        if (UUID.length) {
            return;
        }
        [self storeUUIDIntoKeychainUntilSuccess:self.UUIDAtUserDefaults];
    });
}

+ (void)storeUUIDIntoKeychainUntilSuccess:(NSString *)UUID {
    NSError *error;
    [self storeUUIDIntoKeychain:UUID error:&error];
    if (!error) {
        return;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self storeUUIDIntoKeychainUntilSuccess:UUID];
    });
}


+ (void)storeUUIDIntoKeychain:(NSString *)UUID error:(NSError **)error {
    [MXKeyChainManager setString:UUID forKey:kMXKeyChainDevUUID error:error];
}

+ (NSString *)UUIDAtKeychainError:(NSError **)error {
    return [MXKeyChainManager stringForKey:kMXKeyChainDevUUID error:error];
}

+ (void)storeUUIDIntoUserDefaults:(NSString *)UUID {
    [MXUserDefaultManager setObject:UUID forKey:kMXUserDefaultDevUUID];
}

+ (NSString *)UUIDAtUserDefaults {
    return [MXUserDefaultManager stringForKey:kMXUserDefaultDevUUID];
}

@end
