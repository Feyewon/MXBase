//
//  NSObject+CurrentVC.m
//  AFNetworking
//
//  Created by fei on 2019/5/22.
//

#import "NSObject+CurrentVC.h"

@implementation NSObject (CurrentVC)

+ (UIViewController *)getCurrentVC {
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    NSArray *winSubviews = [window subviews];
    UIView *frontView = winSubviews.count>0?winSubviews[0]:nil;
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    return result;
}

@end
