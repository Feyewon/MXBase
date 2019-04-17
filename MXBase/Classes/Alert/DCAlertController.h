//
//  DCAlertController.h
//  梦想旅行
//
//  Created by fzw on 15/8/19.
//  Copyright (c) 2015年 北京梦想智联科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDCAlertController.h"
#import "PayAlertBackgroundView.h"
#import "SDCAlertView.h"
@interface AlertAttributeString : NSObject
+(NSDictionary *)attributesWithFontSize:(CGFloat)size color:(UIColor *)color lineSpacing:(CGFloat)lineSpacing alignment:(NSTextAlignment)textAlignment;
@end

@interface DCAlertController : SDCAlertController
+(void)showAlertWithTitle:(NSString *)title
         attributeContent:(NSAttributedString *)attributedString
              submitTitle:(NSString *)submitTitle
              submitBlock:(void(^)(SDCAlertView *))submitBlock
              cancelTitle:(NSString *)cancelTitle
              cancelBlock:(void(^)(SDCAlertView *))cancelBlock;
+(void)showAlertWithTitle:(NSString *)title content:(NSString *)content submitBlock:(void (^)(void))submitCompletion;
+(void)showAlertWithTitle:(NSString *)title content:(NSString *)content submitTitle:(NSString *)submitTitle submitBlock:(void (^)(void))submitCompletion;
+(void)showAlertWithTitle:(NSString *)title content:(NSString *)content submitTitle:(NSString *)submitTitle submitBlock:(void (^)(void))submitCompletion cancelBlock:(void(^)(void))cancelCompletion;
+(void)showAlertWithTitle:(NSString *)title content:(NSString *)content;
+(void)showAlertWithTitle:(NSString *)title content:(NSString *)content iKnowBlock:(void (^)(void))iKnowBlock;
+(void)showAlertWithTitle:(NSString *)title content:(NSString *)content submitTitle:(NSString *)submitTitle submitBlock:(void (^)(void))submitCompletion cancelTitle:(NSString *)cancelTitle cancelBlock:(void(^)(void))cancelCompletion;


+(void)showAlertV2WithTitle:(NSString *)title
           attributeContent:(NSAttributedString *)attributedString
             closeBtnHidden:(BOOL)hidden
                submitTitle:(NSString *)submitTitle
                submitBlock:(void (^)(SDCAlertView *))submitBlock
                cancelTitle:(NSString *)cancelTitle
                cancelBlock:(void (^)(SDCAlertView *))cancelBlock
                closeBlock:(void(^)())closeCompletion;

+(void)showAlertV2WithTitle:(NSString *)title
           attributeContent:(NSAttributedString *)attributedString
             closeBtnHidden:(BOOL)hidden
                submitTitle:(NSString *)submitTitle
                submitBlock:(void (^)())submitBlock
                 closeBlock:(void(^)())closeCompletion;

+(void)showAlertV2WithTitle:(NSString *)title
          attributeSContent:(NSAttributedString *)attributedString
                closeBtnHidden:(BOOL)hidden
                submitTitle:(NSString *)submitTitle
                submitBlock:(void (^)())submitBlock
                cancelTitle:(NSString *)cancelTitle
                cancelBlock:(void(^)())cancelCompletion
                closeBlock:(void(^)())closeCompletion;

+(void)showAlertV3WithTitle:(NSString *)title
           attributeContent:(NSAttributedString *)attributedString
                closeBtnHidden:(BOOL)hidden
                submitTitle:(NSString *)submitTitle
                submitBlock:(void (^)(SDCAlertView *))submitBlock
                cancelTitle:(NSString *)cancelTitle
                cancelBlock:(void (^)(SDCAlertView *))cancelBlock;

+(void)showAlertV3WithTitle:(NSString *)title
          attributeSContent:(NSAttributedString *)attributedString
             closeBtnHidden:(BOOL)hidden
                submitTitle:(NSString *)submitTitle
                submitBlock:(void (^)())submitBlock;

// 首页alert
+(void)showCityNotOpenAlertTitle:(NSString *)title
                         content:(NSString *)content
                           image:(UIImage *)image
                     submitTitle:(NSString *)submitTitle
                     submitBlock:(void (^)(SDCAlertView *a))submitBlock
                     cancelTitle:(NSString *)cancelTitle
                     cancelBlock:(void (^)(SDCAlertView *a))cancelBlock;

// 支付弹窗
+(void)showPayResultTipAlertTitle:(NSString *)title
                          content:(NSString *)content
                            image:(UIImage *)image
                             type:(PayAlertBackgroundViewType)type
                      submitTitle:(NSString *)submitTitle
                      submitBlock:(void (^)(SDCAlertView *a))submitBlock
                      cancelTitle:(NSString *)cancelTitle
                      cancelBlock:(void (^)(SDCAlertView *a))cancelBlock;

// 必须升级
+(void)showForceUpdateAlert:(NSString *)desc;

//合并弹框
+ (void)showMergeAlertWithTitle:(NSString *)title
               attributeContent:(NSAttributedString *)attributedString
                    submitTitle:(NSString *)submitTitle
                    submitBlock:(void (^)(SDCAlertView *))submitBlock
                    cancelTitle:(NSString *)cancelTitle
                    cancelBlock:(void (^)(SDCAlertView *))cancelBlock;

//注销
+ (void)showAlertWithTitle:(NSString *)title
                   content:(NSString *)content
               submitTitle:(NSString *)submitTitle
            configureBlock:(void(^)(void))configureBlock;

@end
