//
//  MXSystemController.m
//  MXBaseExample
//
//  Created by FEI on 2019/3/27.
//  Copyright © 2019 FEI. All rights reserved.
//

#import "MXSystemController.h"
#import "AFNetworkReachabilityManager.H"
#import <sys/utsname.h>
#import <AdSupport/AdSupport.h>

@implementation MXSystemController
+ (NSString*) deviceName{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString* code = [NSString stringWithCString:systemInfo.machine
                                        encoding:NSUTF8StringEncoding];
    static NSDictionary* deviceNamesByCode = nil;
    if (!deviceNamesByCode) {
        deviceNamesByCode = @{
                              @"x86_64"    :@"Simulator",
                              @"i386"      :@"Simulator",
                              @"iPod1,1"   :@"iPod Touch",      // (Original)
                              @"iPod2,1"   :@"iPod Touch",      // (Second Generation)
                              @"iPod3,1"   :@"iPod Touch",      // (Third Generation)
                              @"iPod4,1"   :@"iPod Touch",      // (Fourth Generation)
                              @"iPhone1,1" :@"iPhone",          // (Original)
                              @"iPhone1,2" :@"iPhone",          // (3G)
                              @"iPhone2,1" :@"iPhone",          // (3GS)
                              @"iPad1,1"   :@"iPad",            // (Original)
                              @"iPad2,1"   :@"iPad 2",          //
                              @"iPad3,1"   :@"iPad",            // (3rd Generation)
                              @"iPhone3,1" :@"iPhone 4",        // (GSM)
                              @"iPhone3,3" :@"iPhone 4",        // (CDMA/Verizon/Sprint)
                              @"iPhone4,1" :@"iPhone 4S",       //
                              @"iPhone5,1" :@"iPhone 5",        // (model A1428, AT&T/Canada)
                              @"iPhone5,2" :@"iPhone 5",        // (model A1429, everything else)
                              @"iPad3,4"   :@"iPad",            // (4th Generation)
                              @"iPad2,5"   :@"iPad Mini",       // (Original)
                              @"iPhone5,3" :@"iPhone 5c",       // (model A1456, A1532 | GSM)
                              @"iPhone5,4" :@"iPhone 5c",       // (model A1507, A1516, A1526 (China), A1529 | Global)
                              @"iPhone6,1" :@"iPhone 5s",       // (model A1433, A1533 | GSM)
                              @"iPhone6,2" :@"iPhone 5s",       // (model A1457, A1518, A1528 (China), A1530 | Global)
                              @"iPhone7,1" :@"iPhone 6 Plus",   //
                              @"iPhone7,2" :@"iPhone 6",        //
                              @"iPhone8,1" :@"iPhone 6s",
                              @"iPhone8,2" :@"iPhone 6s Plus",
                              @"iPhone8,3" :@"iPhoneSE",
                              @"iPhone8,4" :@"iPhoneSE",
                              @"iPhone9,1" :@"iPhone7",
                              @"iPhone9,2" :@"iPhone7Plus",
                              @"iPhone10,1":@"(A1863/A1906)iPhone 8",
                              @"iPhone10,2":@"(A1864/A1898)iPhone 8 Plus",
                              @"iPhone10,3":@"(A1865/A1902)iPhone X",
                              @"iPhone10,4":@"(Global/A1905)iPhone 8",
                              @"iPhone10,5":@"(Global/A1897)iPhone 8 Plus",
                              @"iPhone10,6":@"(Global/A1901)iPhone X",
                              @"iPhone11,2":@"iPhone XS",
                              @"iPhone11,4":@"iPhone XS Max",
                              @"iPhone11,6":@"iPhone XS Max",
                              @"iPhone11,8":@"iPhone XR",
                              @"iPad4,1"   :@"iPad Air",        // 5th Generation iPad (iPad Air) - Wifi
                              @"iPad4,2"   :@"iPad Air",        // 5th Generation iPad (iPad Air) - Cellular
                              @"iPad4,4"   :@"iPad Mini",       // (2nd Generation iPad Mini - Wifi)
                              @"iPad4,5"   :@"iPad Mini"        // (2nd Generation iPad Mini - Cellular)
                              };
    }
    
    NSString* deviceName = [deviceNamesByCode objectForKey:code];
    if (!deviceName) {
        if ([code rangeOfString:@"iPod"].location != NSNotFound) {
            deviceName = @"iPod Touch";
        }
        else if([code rangeOfString:@"iPad"].location != NSNotFound) {
            deviceName = @"iPad";
        }
        else if([code rangeOfString:@"iPhone"].location != NSNotFound){
            deviceName = @"iPhone";
        }
    }
    return deviceName;
}

+ (float)screenWidth{
    if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        if ([[UIDevice currentDevice].systemVersion floatValue]>=8.0) {
            return [UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale;
        } else {
            return [UIScreen mainScreen].bounds.size.height;
        }
    } else {
        if ([[UIDevice currentDevice].systemVersion floatValue]>=8.0) {
            return [UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale;
        } else {
            return [UIScreen mainScreen].bounds.size.width;
        }
    }
}

+ (float)screenHeight{
    if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        if ([[UIDevice currentDevice].systemVersion floatValue]>=8.0) {
            if ([UIApplication sharedApplication].statusBarFrame.size.width>20) {
                return [UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale-20;
            }
            return [UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale;
        } else {
            if ([UIApplication sharedApplication].statusBarFrame.size.width>20) {
                return [UIScreen mainScreen].bounds.size.width-20;
            }
            return [UIScreen mainScreen].bounds.size.width;
        }
    } else {
        if ([[UIDevice currentDevice].systemVersion floatValue]>=8.0) {
            if ([UIApplication sharedApplication].statusBarFrame.size.height>20) {
                return [UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale-20;
            }
            return [UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale;
        } else {
            if ([UIApplication sharedApplication].statusBarFrame.size.height>20) {
                return [UIScreen mainScreen].bounds.size.height-20;
            }
            return [UIScreen mainScreen].bounds.size.height;
        }
    }
}

+ (BOOL)isRetina{
    if ([[UIDevice currentDevice].systemVersion floatValue]>=8.0) {
        return [UIScreen mainScreen].nativeScale>=2;
    } else {
        return [UIScreen mainScreen].scale>=2;
    }
}

+ (float)scale{
    if ([[UIDevice currentDevice].systemVersion floatValue]>=8.0) {
        return [UIScreen mainScreen].nativeScale;
    } else {
        return [UIScreen mainScreen].scale;
    }
}

+ (NSString *)resolution{
    CGFloat width=[[self class] screenWidth]*[[self class] scale];
    CGFloat height=[[self class] screenHeight]*[[self class] scale];
    return [NSString stringWithFormat:@"%.0f*%.0f",width,height];
}

+ (NSString *)osVersion{
    return [NSString stringWithFormat:@"%@",[UIDevice currentDevice].systemVersion];
}

+ (NSString *)bundleIdentifier{
    NSString *bundleIdentifier = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleIdentifierKey];
    bundleIdentifier = bundleIdentifier.length? bundleIdentifier : @"";
    return bundleIdentifier;
}

+ (NSString *)networkingState {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    });
    AFNetworkReachabilityStatus status = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
    switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
            return @"wifi";
            case AFNetworkReachabilityStatusReachableViaWWAN:
            return @"wwan";
            case AFNetworkReachabilityStatusUnknown:
            return @"unknown";
        default:
            return @"notReachable";
    }
}

+ (NSString *)idfv {
    NSString *idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString]; ;
    return idfv;
}

+ (NSString *)currentLanguage{
    NSString* currentLanguage = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0];
    currentLanguage = currentLanguage.length? currentLanguage : @"";
    return currentLanguage;
}

+ (NSString *)appVersion {
    return [NSString stringWithFormat:@"%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
}

+ (NSString *)idfa {
    static dispatch_once_t onceToken;
    static NSString *idfa;
    dispatch_once(&onceToken, ^{
        NSString *UUIDString = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        if (UUIDString && [UUIDString isKindOfClass:[NSString class]] && UUIDString.length>0) {
            idfa = UUIDString;
        }else{
            idfa = @"";
        }
    });
    return idfa;
}
@end
