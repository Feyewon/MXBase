//
//  NSObject+CurrentVC.h
//  AFNetworking
//
//  Created by fei on 2019/5/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (CurrentVC)
+ (UIViewController *)getCurrentVC;
@end

NS_ASSUME_NONNULL_END
