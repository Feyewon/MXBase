//
//  MXSystemController.h
//  MXBaseExample
//
//  Created by FEI on 2019/3/27.
//  Copyright © 2019 FEI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface MXSystemController : NSObject
+ (NSString *)deviceName;
+ (BOOL)isRetina;
+ (float)scale;
+ (NSString *)resolution; // 分辨率
+ (float)screenWidth;
+ (float)screenHeight;
+ (NSString *)osVersion;
+ (NSString *)bundleIdentifier;
+ (NSString *)networkingState;
+ (NSString *)idfv;
+ (NSString *)idfa;
+ (NSString *)currentLanguage;
+ (NSString *)appVersion;
@end

