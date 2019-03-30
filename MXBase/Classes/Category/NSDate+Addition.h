//
//  NSDate+Addition.h
//  梦想旅行
//
//  Created by fzw on 16/1/4.
//  Copyright © 2016年 北京梦想智联科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Addition)
/*
 *  format：时间格式
 *  yyyy MM dd HH mm
 *
 */
-(NSString *)timeToStringWithFormat:(NSString *)format;
-(NSString *)timeToStringWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone;
+(NSString *)weekToChinese:(NSInteger)weekDay;

+ (NSInteger)numberOfDaysWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;
+ (NSDate *)dateWithFromDate:(NSDate *)date years:(NSInteger)years months:(NSInteger)months days:(NSInteger)days;
- (id) getweekDay;
@end
