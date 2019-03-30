//
//  MXUserDefaultManager.m
//  MXBase
//
//  Created by FEI on 2019/3/28.
//

#import "MXUserDefaultManager.h"

@implementation MXUserDefaultManager
+ (NSUserDefaults *)userDefaults {
    return [NSUserDefaults standardUserDefaults];
}

+ (nullable id)objectForKey:(NSString *)defaultName {
    return [self.userDefaults objectForKey:defaultName];
}

+ (void)setObject:(nullable id)value forKey:(NSString *)defaultName {
    [self.userDefaults setObject:value forKey:defaultName];
    [self.userDefaults synchronize];
}

+ (void)removeObjectForKey:(NSString *)defaultName {
    [self.userDefaults removeObjectForKey:defaultName];
    [self.userDefaults synchronize];
}

+ (nullable NSString *)stringForKey:(NSString *)defaultName {
    return [self.userDefaults stringForKey:defaultName];
}

+ (nullable NSArray *)arrayForKey:(NSString *)defaultName {
    return [self.userDefaults arrayForKey:defaultName];
}

+ (nullable NSDictionary<NSString *, id> *)dictionaryForKey:(NSString *)defaultName {
    return [self.userDefaults dictionaryForKey:defaultName];
}

+ (nullable NSData *)dataForKey:(NSString *)defaultName {
    return [self.userDefaults dataForKey:defaultName];
}

+ (nullable NSArray<NSString *> *)stringArrayForKey:(NSString *)defaultName {
    return [self.userDefaults stringArrayForKey:defaultName];
}

+ (NSInteger)integerForKey:(NSString *)defaultName {
    return [self.userDefaults integerForKey:defaultName];
}

+ (float)floatForKey:(NSString *)defaultName {
    return [self.userDefaults floatForKey:defaultName];
}

+ (double)doubleForKey:(NSString *)defaultName {
    return [self.userDefaults doubleForKey:defaultName];
}

+ (BOOL)boolForKey:(NSString *)defaultName {
    return [self.userDefaults boolForKey:defaultName];
}

+ (nullable NSURL *)URLForKey:(NSString *)defaultName API_AVAILABLE(macos(10.6), ios(4.0), watchos(2.0), tvos(9.0)) {
    return [self.userDefaults URLForKey:defaultName];
}

+ (void)setInteger:(NSInteger)value forKey:(NSString *)defaultName {
    [self.userDefaults setInteger:value forKey:defaultName];
    [self.userDefaults synchronize];
}

+ (void)setFloat:(float)value forKey:(NSString *)defaultName {
    [self.userDefaults setFloat:value forKey:defaultName];
    [self.userDefaults synchronize];
}

+ (void)setDouble:(double)value forKey:(NSString *)defaultName {
    [self.userDefaults setDouble:value forKey:defaultName];
    [self.userDefaults synchronize];
}

+ (void)setBool:(BOOL)value forKey:(NSString *)defaultName {
    [self.userDefaults setBool:value forKey:defaultName];
    [self.userDefaults synchronize];
}

+ (void)setURL:(nullable NSURL *)url forKey:(NSString *)defaultName API_AVAILABLE(macos(10.6), ios(4.0), watchos(2.0), tvos(9.0)) {
    [self.userDefaults setURL:url forKey:defaultName];
    [self.userDefaults synchronize];
}
@end
