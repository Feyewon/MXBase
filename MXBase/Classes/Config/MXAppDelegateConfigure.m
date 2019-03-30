//
//  MXAppDelegateConfigure.m
//  Masonry
//
//  Created by FEI on 2019/3/30.
//

#import "MXAppDelegateConfigure.h"
#import "AppDelegate.h"
#import "MCSocialManager.h"
#import <RSSwizzle.h>
#import <Bugrpt/NTESCrashReporter.h>
#import "MCDevUUID.h"

@implementation MXAppDelegateConfigure

+ (void)load {
    __typeof(self)aliasSelf=self;
    RSSwizzleInstanceMethod(
                            [AppDelegate class],
                            @selector(application:didFinishLaunchingWithOptions:),
                            RSSWReturnType(BOOL),
                            RSSWArguments(UIApplication *application,NSDictionary *launchOptions),
                            RSSWReplacement({
        
        BOOL result = RSSWCallOriginal(application, launchOptions);
        [aliasSelf initSDKConfig];
        return result;
    }), RSSwizzleModeAlways, NULL);
    
    RSSwizzleInstanceMethod([AppDelegate class],
                            @selector(application:handleOpenURL:),
                            RSSWReturnType(BOOL),
                            RSSWArguments(UIApplication *application,NSURL *url),
                            RSSWReplacement({
        
        BOOL oResult = RSSWCallOriginal(application, url);
        BOOL sResult = [aliasSelf mc_application:application handleOpenURL:url];
        return oResult | sResult;
    }), RSSwizzleModeAlways, NULL);
    
    RSSwizzleInstanceMethod([AppDelegate class],
                            @selector(application:openURL:options:),
                            RSSWReturnType(BOOL),
                            RSSWArguments(UIApplication *application,NSURL *url,NSDictionary<UIApplicationOpenURLOptionsKey, id> *options),
                            RSSWReplacement({
        
        BOOL oResult = RSSWCallOriginal(application, url, options);
        BOOL sResult = [aliasSelf mc_application:application openURL:url options:options];
        return oResult | sResult;
    }), RSSwizzleModeAlways, NULL);
    
    RSSwizzleInstanceMethod([AppDelegate class],
                            @selector(application:openURL:sourceApplication:annotation:),
                            RSSWReturnType(BOOL),
                            RSSWArguments(UIApplication *application,NSURL *url,NSString *sourceApplication,id annotation),
                            RSSWReplacement({
        
        BOOL oResult = RSSWCallOriginal(application, url, sourceApplication, application);
        BOOL sResult = [aliasSelf mc_application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
        return oResult | sResult;
    }), RSSwizzleModeAlways, NULL);
}

+ (void)initSDKConfig {
    // 网易云捕
    [[NTESCrashReporter sharedInstance] initWithAppId:@"I004001377"];
    [[NTESCrashReporter sharedInstance] setUserId:[MCDevUUID getDevUUID]];
    [MCSocialManager initUMengConfig];
}

// 设置系统回调
// 支持所有iOS系统
+ (BOOL)mc_application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [MCSocialManager handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

// 仅支持iOS9以上系统，iOS8及以下系统不会回调
+ (BOOL)mc_application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [MCSocialManager handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

// 支持目前所有iOS系统
+ (BOOL)mc_application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [MCSocialManager handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}


@end
