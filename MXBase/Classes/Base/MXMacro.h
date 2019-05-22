//
//  MXMacro.h
//  MXBaseExample
//
//  Created by FEI on 2019/3/27.
//  Copyright © 2019 FEI. All rights reserved.
//

#ifndef MXMacro_h
#define MXMacro_h


#define StatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define NavigationBarHeight self.navigationController.navigationBar.frame.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define IsStringEmptyOrNil(string) !string || string.length==0
#define IsStringNil(string) !string
#define setNilStringToEmpty(string) if(!string||[string isKindOfClass:[NSNull class]]){string=@"";}
#define setNilArrayToEmpty(arr) if(!arr||[arr isKindOfClass:[NSNull class]]){arr=[NSArray array];}
#define setNilDicToEmpty(dic) if(!dic||[dic isKindOfClass:[NSNull class]]){dic=[NSDictionary dictionary];}
#define setNilMutableArrayToEmpty(arr) if(!arr||[arr isKindOfClass:[NSNull class]]){arr=[NSMutableArray array];}
#define ResourcePath(path)  [[NSBundle mainBundle] pathForResource:path ofType:nil]
#define ImageWithPath(path) [UIImage imageWithContentsOfFile:path]
#define DefConstString NSString * const
#define DefConstInt const int
#define DefConstDouble const double

#define iPhoneXSeries (((SCREEN_WIDTH == 375.f && SCREEN_HEIGHT == 812.f) || (SCREEN_WIDTH == 414.f && SCREEN_HEIGHT == 896.f)) ? YES : NO)
#define NavHeight  (iPhoneXSeries ? 88.f : 64.f)
#define TabbarHeight (iPhoneXSeries ? (49.f + 34.f) : 49.f)
#define SafeTabbarHeight (iPhoneXSeries ? 34.f : 0.f)
#define DCRGBToColor(R,G,B)  [UIColor colorWithRed:(R * 1.0) / 255.0 green:(G * 1.0) / 255.0 blue:(B * 1.0) / 255.0 alpha:1.0]
#define dc_rgba(R,G,B,A)  [UIColor colorWithRed:(R * 1.0) / 255.0 green:(G * 1.0) / 255.0 blue:(B * 1.0) / 255.0 alpha:A]
#define JDLog(format, ...) NSLog((@"%s [Line %d] " format), __FUNCTION__, __LINE__, ##__VA_ARGS__)
// 当前版本号
#define AppVersion [NSString stringWithFormat:@"%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
#define IOS8LATER [[UIDevice currentDevice].systemVersion floatValue]>=8.0
#define IOS9LATER [[UIDevice currentDevice].systemVersion floatValue]>=9.0
#define IOS9EARLY [[UIDevice currentDevice].systemVersion floatValue]<9.0
#define IOS10LATER [[UIDevice currentDevice].systemVersion floatValue]>=10.0
#define IOS8EARLY [[UIDevice currentDevice].systemVersion floatValue]<8.0
// block
#define RUN(block,...) if(block){block(__VA_ARGS__);}
#define RUNINBACKGROUND(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),block);
#define RUNINMAIN(block) dispatch_async(dispatch_get_main_queue(),block);
#define DCLOCK(...) dispatch_semaphore_wait(self->_lock, DISPATCH_TIME_FOREVER); \
__VA_ARGS__; \
dispatch_semaphore_signal(self->_lock);

#define DCLOCK_VIEW(...) dispatch_semaphore_wait(view->_lock, DISPATCH_TIME_FOREVER); \
__VA_ARGS__; \
dispatch_semaphore_signal(view->_lock);

#define DCError(errorCode, errorDescription) ([NSError errorWithDomain:@"DCErrorDomain" code:errorCode userInfo:@{NSLocalizedDescriptionKey: errorDescription}])



#define DEFWEAKSELF __weak __typeof(self)weakSelf=self

#define GetStringValueFromDic(dic,key) [dic isKindOfClass:[NSDictionary class]] && [[dic objectForKey:key] isKindOfClass:[NSString class]]?[dic objectForKey:key]:@""
#define GetNumberValueFromDic(dic,key) [dic isKindOfClass:[NSDictionary class]] && [[dic objectForKey:key] isKindOfClass:[NSNumber class]]?[dic objectForKey:key]:nil
#define GetArrayValueFromDic(dic,key) [dic isKindOfClass:[NSDictionary class]] && [[dic objectForKey:key] isKindOfClass:[NSArray class]]?[dic objectForKey:key]:@[]
#define GetDicValueFromDic(dic,key) [dic isKindOfClass:[NSDictionary class]] && [[dic objectForKey:key] isKindOfClass:[NSDictionary class]]?[dic objectForKey:key]:@{}
#define GetMutableDicValueFromDic(dic,key) [dic isKindOfClass:[NSMutableDictionary class]] && [[dic objectForKey:key] isKindOfClass:[NSMutableDictionary class]]?[dic objectForKey:key]:[NSMutableDictionary dictionary]


#define CreateLabel(dcObj,dcFontSize,dcColor) UILabel *dcObj = [UILabel new];dcObj.font = [UIFont systemFontOfSize:dcFontSize]; dcObj.textColor = [UIColor getColor:dcColor];
#define CreateLabelWithText(dcObj,dcFontSize,dcColor,dcText) UILabel *dcObj = [UILabel new];dcObj.font = [UIFont systemFontOfSize:dcFontSize]; dcObj.textColor = [UIColor getColor:dcColor];dcObj.text=dcText;
#define CreateAttributedString(dcObj,dcFontSize,dcColor,dcText) NSAttributedString *dcObj = [[NSAttributedString alloc] initWithString:dcText attributes:@{NSForegroundColorAttributeName:[UIColor getColor:dcColor],NSFontAttributeName:[UIFont systemFontOfSize:dcFontSize]}];
#define CreateAttributedBoldString(dcObj,dcFontSize,dcColor,dcText) NSAttributedString *dcObj = [[NSAttributedString alloc] initWithString:dcText attributes:@{NSForegroundColorAttributeName:[UIColor getColor:dcColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:dcFontSize]}];
#endif

#ifdef DEBUG
#define KHLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define KHLog(format, ...)
#endif
