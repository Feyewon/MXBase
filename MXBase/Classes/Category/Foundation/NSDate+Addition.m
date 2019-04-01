//
//  NSDate+Addition.m
//  梦想旅行
//
//  Created by fzw on 16/1/4.
//  Copyright © 2016年 北京梦想智联科技有限公司. All rights reserved.
//

#import "NSDate+Addition.h"

@implementation NSDate (Addition)
-(NSString *)timeToStringWithFormat:(NSString *)format{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:self];
}

-(NSString *)timeToStringWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone {
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    [dateFormatter setTimeZone:timeZone];
    return [dateFormatter stringFromDate:self];
}

+(NSString *)weekToChinese:(NSInteger)weekDay{
    switch (weekDay) {
        case 1:
            return @"日";
            break;
        case 2:
            return @"一";
            break;
        case 3:
            return @"二";
            break;
        case 4:
            return @"三";
            break;
        case 5:
            return @"四";
            break;
        case 6:
            return @"五";
            break;
        default:
            return @"六";
            break;
    }
}

+ (NSInteger)numberOfDaysWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents  * comp = [calendar components:NSCalendarUnitDay
                                             fromDate:fromDate
                                               toDate:toDate
                                              options:NSCalendarWrapComponents];
    return comp.day;
}

//获取当前时间若干年、月、日之后的时间
+ (NSDate *)dateWithFromDate:(NSDate *)date years:(NSInteger)years months:(NSInteger)months days:(NSInteger)days{
    NSDate  * latterDate;
    if (date) {
        latterDate = date;
    }else{
        latterDate = [NSDate date];
    }
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute
                                          fromDate:latterDate];
    
    [comps setYear:years];
    [comps setMonth:months];
    [comps setDay:days];
    
    return [calendar dateByAddingComponents:comps toDate:latterDate options:0];
}

- (id) getweekDay {
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]; // 指定日历的算法
    NSDateComponents *comps = [calendar components:NSCalendarUnitWeekday fromDate:self];
    return @([comps weekday]);
    
}
@end
