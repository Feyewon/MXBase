//
//  NSString+Addition.h
//  MagicCamera
//
//  Created by fzw on 2019/1/7.
//  Copyright © 2019 Mxtrip. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Addition)
- (BOOL)isPureInt;
-(BOOL)isPureDouble;


/*
 *  格式化距离
 *  10->10m
 *  10000->10.00km
 */
+(NSString *)formatDistance:(double)distance;
+(NSString *)formatDistanceCHN:(double)distance;

/*
 *  格式化时间
 *  10->10秒
 *  90->1.5分钟
 *  5400 -> 1.5小时
 *
 */
+(NSString *)formatDuration:(double)duration;


/*
 *  格式化数量
 *  10->10
 *  10000->10k
 *
 */
+(NSString *)formatNumber:(NSInteger)number;


/*
 *  format：时间格式
 *  yyyy MM dd HH mm
 *
 */
-(NSDate *)stringToTimeWithFormat:(NSString *)format;

-(NSString *)md5String;
-(NSString *)URLEncode;
-(NSString *)URLDecode;

-(CGFloat)calcHeightWithWidth:(CGFloat)width andFont:(UIFont *)font;
-(CGFloat)calcHeightWithWidth:(CGFloat)width andFont:(UIFont *)font andNumberOfLines:(NSInteger)number;
+(NSString *)formatIntegerNumberWith:(NSInteger)number;
- (NSString *)getURLDomain;
- (NSMutableDictionary *)getURLParameters;
- (BOOL)dc_containsString:(NSString *)aString;
+(BOOL)isPinyin:(NSString *)string;
+(NSString *)hidenMidStringWith:(NSString *)string;
+(BOOL)is11BitPhone:(NSString *)string;
+(BOOL)is6BitCode:(NSString *)string;
- (NSUInteger)unsignIntegerValue;
+(NSDictionary *)createTextAttributeWithFontSize:(NSUInteger)size fontColor:(NSString *)color;
+ (BOOL)isEmailAccount:(NSString *)string;
+ (NSString *)timeToString:(NSInteger)time;
- (NSString *)timeToStringV2Withformat:(NSString *)format;
- (NSString *)formatTimeStampWithFormat:(NSString *)format;

- (NSString *)getModuleImagePathWithBundleClass:(Class)bundleClass;
- (NSString *)getModuleImagePathWithBundleClass:(Class)bundleClass bundleName:(NSString *)bundleName;
@end
