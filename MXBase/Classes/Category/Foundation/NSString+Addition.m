//
//  NSString+Addition.m
//  MagicCamera
//
//  Created by fzw on 2019/1/7.
//  Copyright © 2019 Mxtrip. All rights reserved.
//

#import "NSString+Addition.h"
#import "NSData+Addition.h"
#import "UIColor+Addition.h"

@implementation NSString (Addition)
- (BOOL)isPureInt{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

-(BOOL)isPureDouble{
    NSScanner* scan = [NSScanner scannerWithString:self];
    double val;
    return[scan scanDouble:&val] && [scan isAtEnd];
}

+ (NSString *)formatDistance:(double)distance {
    if (distance < 1000) {
        return [NSString stringWithFormat:@"%.0fm",distance];
    } else {
        return [NSString stringWithFormat:@"%.2fkm",distance / 1000];
    }
}

+ (NSString *)formatDistanceCHN:(double)distance{
    if (distance < 1000) {
        return [NSString stringWithFormat:@"%.0f米",distance];
    } else {
        return [NSString stringWithFormat:@"%.2f公里",distance / 1000];
    }
}

+(NSString *)formatDuration:(double)duration{
    if(duration<60){
        return [NSString stringWithFormat:@"%.0f秒",duration];
    }else if(duration<3600){
        return [NSString stringWithFormat:@"%.1f分钟",duration/60];
    }else{
        return [NSString stringWithFormat:@"%.1f小时",duration/3600];
    }
}

+(NSString *)formatNumber:(NSInteger)number{
    if(number<1000){
        return [NSString stringWithFormat:@"%ld",(long)number];
    }else if(number<10000){
        return [NSString stringWithFormat:@"%.1fk",number/1000.0];
    }else{
        return [NSString stringWithFormat:@"%.0fk",number/1000.0];
    }
}

-(NSDate *)stringToTimeWithFormat:(NSString *)format{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter dateFromString:self];
}

- (NSString *)md5String{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data getMD5];
}

#pragma mark - urlEncode urlDecode
-(NSString *)URLEncode{
    return [self URLEncodeUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)URLEncodeUsingEncoding:(NSStringEncoding)encoding{
    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                 (__bridge CFStringRef)self,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                 CFStringConvertNSStringEncodingToEncoding(encoding));
}

-(NSString *)URLDecode{
    return [self URLDecodeUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)URLDecodeUsingEncoding:(NSStringEncoding)encoding{
    return (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                 (__bridge CFStringRef)self,
                                                                                                 CFSTR(""),
                                                                                                 CFStringConvertNSStringEncodingToEncoding(encoding));
}

-(CGFloat)calcHeightWithWidth:(CGFloat)width andFont:(UIFont *)font{
    CGSize mainTextSizeOnlyWidth=CGSizeMake(width-10, MAXFLOAT);
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
    NSDictionary *attributes = @{ NSFontAttributeName: font, NSParagraphStyleAttributeName : paragraphStyle };
    
    CGSize size = [self boundingRectWithSize:mainTextSizeOnlyWidth options:
                   NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    return size.height;
}

-(CGFloat)calcHeightWithWidth:(CGFloat)width andFont:(UIFont *)font andNumberOfLines:(NSInteger)number{
    CGSize mainTextSizeOnlyWidth=CGSizeMake(width-10, MAXFLOAT);
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
    NSDictionary *attributes = @{ NSFontAttributeName: font, NSParagraphStyleAttributeName : paragraphStyle };
    
    CGSize size = [self boundingRectWithSize:mainTextSizeOnlyWidth options:
                   NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    return size.height*number;
}

+(NSString *)formatIntegerNumberWith:(NSInteger)number{
    int count = 0;
    long a = number;
    while (a != 0){
        count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithFormat:@"%ld",(long)number];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    return newstring;
}

- (BOOL)dc_containsString:(NSString *)aString{
    if ([self respondsToSelector:@selector(containsString:)]) {
        return [self containsString:aString];
    }
    if (!aString.length) {
        return NO;
    }
    if ([self rangeOfString:aString].location != NSNotFound) {
        return YES;
    }
    return NO;
}

-(NSString *)getURLDomain{
    // 查找参数
    NSRange range = [self rangeOfString:@"?"];
    
    NSString *urlDomain = (range.location == NSNotFound)? self:[self substringToIndex:range.location];
    
    return urlDomain;
}

- (NSMutableDictionary *)getURLParameters {
    
    // 查找参数
    NSRange range = [self rangeOfString:@"?"];
    if (range.location == NSNotFound) {
        return nil;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    // 截取参数
    NSString *parametersString = [self substringFromIndex:range.location + 1];
    
    // 判断参数是单个参数还是多个参数
    if ([parametersString containsString:@"&"]) {
        
        // 多个参数，分割参数
        NSArray *urlComponents = [parametersString componentsSeparatedByString:@"&"];
        
        for (NSString *keyValuePair in urlComponents) {
            // 生成Key/Value
            NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
            NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
            NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
            
            // Key不能为nil
            if (key == nil || value == nil) {
                continue;
            }
            
            id existValue = [params valueForKey:key];
            
            if (existValue != nil) {
                
                // 已存在的值，生成数组
                if ([existValue isKindOfClass:[NSArray class]]) {
                    // 已存在的值生成数组
                    NSMutableArray *items = [NSMutableArray arrayWithArray:existValue];
                    [items addObject:value];
                    
                    [params setValue:items forKey:key];
                } else {
                    
                    // 非数组
                    [params setValue:@[existValue, value] forKey:key];
                }
                
            } else {
                
                // 设置值
                [params setValue:value forKey:key];
            }
        }
    } else {
        // 单个参数
        
        // 生成Key/Value
        NSArray *pairComponents = [parametersString componentsSeparatedByString:@"="];
        
        // 只有一个参数，没有值
        if (pairComponents.count == 1) {
            return nil;
        }
        
        // 分隔值
        NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
        NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
        
        // Key不能为nil
        if (key == nil || value == nil) {
            return nil;
        }
        
        // 设置值
        [params setValue:value forKey:key];
    }
    
    return params;
}

+(BOOL)isPinyin:(NSString *)string {
    for(NSInteger index=0;index<string.length;index++) {
        char commitChar = [string characterAtIndex:index];
        NSString *temp = [string substringWithRange:NSMakeRange(index,1)];
        const char *u8Temp = [temp UTF8String];
        if(u8Temp == NULL) {
            return NO;
        }
        if (3==strlen(u8Temp)){
            // 中文
            return NO;
        }else if((commitChar>64)&&(commitChar<91)){
            // 大写英文
            continue;
        }else if((commitChar>96)&&(commitChar<123)){
            // 小写英文
            continue;
        }else if((commitChar>47)&&(commitChar<58)){
            // 数字
            return NO;
        }else{
            // 非法字符
            return NO;
        }
    }
    return YES;
}

+(NSString *)hidenMidStringWith:(NSString *)string {
    if(string.length <= 1) {
        return string;
    }
    if(string.length <= 3) {
        return [string stringByReplacingCharactersInRange:NSMakeRange(1, 1) withString:@"*"];
    }
    if(string.length <= 5) {
        return [string stringByReplacingCharactersInRange:NSMakeRange(1, 2) withString:@"**"];
    }
    if(string.length <= 7) {
        return [string stringByReplacingCharactersInRange:NSMakeRange(2, 3) withString:@"**"];
    }else if (string.length<=10) {
        NSInteger midIndex = string.length/2-2;
        return [string stringByReplacingCharactersInRange:NSMakeRange(midIndex, 4) withString:@"****"];
    }else{
        return [string stringByReplacingCharactersInRange:NSMakeRange(3, string.length-7) withString:@"****"];
    }
}
+(BOOL)is11BitPhone:(NSString *)string {
    NSString *telRegex = @"[0-9]{11,11}";
    NSPredicate *telTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", telRegex];
    BOOL isTelValid=[telTest evaluateWithObject:string];
    return isTelValid;
}

+(BOOL)is6BitCode:(NSString *)string {
    NSString *telRegex = @"[0-9]{6,6}";
    NSPredicate *telTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", telRegex];
    BOOL isTelValid=[telTest evaluateWithObject:string];
    return isTelValid;
}

+ (BOOL)isEmailAccount:(NSString *)string {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL isEmailValid = [emailTest evaluateWithObject:string];
    return isEmailValid;
}

- (NSUInteger)unsignIntegerValue {
    NSScanner *scanner = [NSScanner scannerWithString:self];
    unsigned long long ull;
    if (![scanner scanUnsignedLongLong:&ull]) {
        ull = 0;  // Or handle failure some other way
    }
    return (NSUInteger)ull;
}

+ (NSString *)timeToString:(NSInteger)time {
    long nowTime = [[NSDate date] timeIntervalSince1970];
    long before = nowTime - time;
    if (before <= 0) {
        return @"现在";
    } else {
        if (before < 60 && before > 0) {
            return [NSString stringWithFormat:@"%ld秒之前", before];
        } else if (before < 60 * 60 && before >= 60) {
            return [NSString stringWithFormat:@"%ld分钟之前", before / 60];
        } else if (before < 60 * 60 * 24 && before >= 60 * 60) {
            return [NSString stringWithFormat:@"%ld小时之前", before / 3600];
        } else if (before < 60 * 60 * 24 * 30 && before >= 60 * 60 * 24) {
            return [NSString stringWithFormat:@"%ld天之前", before / (3600 * 24)];
        } else if (before < 60 * 60 * 24 * 365 && before >= 60 * 60 * 24 * 30) {
            return [NSString stringWithFormat:@"%ld个月之前", before / (3600 * 24 * 30)];
        } else {
            return [NSString stringWithFormat:@"%ld年之前", before / (3600 * 24 * 365)];
        }
    }
}

+(NSDictionary *)createTextAttributeWithFontSize:(NSUInteger)size fontColor:(NSString *)color {
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSTextAlignmentCenter;
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:size], NSParagraphStyleAttributeName:style, NSForegroundColorAttributeName:[UIColor getColor:color]};
    return dict;
}

- (NSString *)timeToStringV2Withformat:(NSString *)format {
    NSTimeInterval time    = [self doubleValue];
    long nowTime = [[NSDate date] timeIntervalSince1970];
    long before = nowTime - time;
    if (before <= 0) {
        return @"现在";
    } else {
        if (before < 60 * 60 * 24) {
            return [self formatTimeStampWithFormat:format];
        } else if (before < 60 * 60 * 24 * 30 && before >= 60 * 60 * 24) {
            return [NSString stringWithFormat:@"%ld天之前", before / (3600 * 24)];
        } else if (before < 60 * 60 * 24 * 365 && before >= 60 * 60 * 24 * 30) {
            return [NSString stringWithFormat:@"%ld个月之前", before / (3600 * 24 * 30)];
        } else {
            return [NSString stringWithFormat:@"%ld年之前", before / (3600 * 24 * 365)];
        }
    }
}


- (NSString *)formatTimeStampWithFormat:(NSString *)format {
    NSTimeInterval interval    = [self doubleValue];
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSString *dateString       = [formatter stringFromDate: date];
    return dateString;
}

- (NSString *)getModuleImagePathWithBundleClass:(Class)bundleClass {
    
    NSInteger scale = [UIScreen mainScreen].scale;
    imageName = [NSString stringWithFormat:@"%@@%zdx.png",self,scale];
    NSBundle *currentBundle = [NSBundle bundleForClass:bundleClass];
    NSString *currentBundleName = currentBundle.infoDictionary[@"CFBundleName"];
    return [currentBundle pathForResource:imageName ofType:nil inDirectory:[NSString stringWithFormat:@"%@.bundle",currentBundleName]];
}


@end
