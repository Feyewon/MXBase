//
//  DCAlertController.m
//  梦想旅行
//
//  Created by fzw on 15/8/19.
//  Copyright (c) 2015年 北京梦想智联科技有限公司. All rights reserved.
//

#import "DCAlertController.h"
#import "AlertBackgroundView.h"
#import "DCAlertView.h"
#import "IndexAlertBackgroundView.h"
#import "DCAlertBackgroundView.h"
#import "DCAlertBackgroundViewV2.h"
#import "Typeset.h"
#import "DCAlertMergeAccountBackgroundView.h"
#import "UIColor+Addition.h"
#import "Masonry.h"
#import "MXMacro.h"

@implementation AlertAttributeString
+(NSDictionary *)attributesWithFontSize:(CGFloat)size color:(UIColor *)color lineSpacing:(CGFloat)lineSpacing alignment:(NSTextAlignment)textAlignment{
    NSMutableParagraphStyle *paragraphStyle=[[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [paragraphStyle setAlignment:textAlignment];
    return @{NSFontAttributeName:[UIFont systemFontOfSize:size],NSForegroundColorAttributeName:color,NSParagraphStyleAttributeName:paragraphStyle};
}
@end

@interface DCAlertController () <UIAlertViewDelegate>
@end
@implementation DCAlertController
+(void)showAlertWithTitle:(NSString *)title attributeContent:(NSAttributedString *)attributedString submitTitle:(NSString *)submitTitle submitBlock:(void (^)(SDCAlertView *))submitBlock cancelTitle:(NSString *)cancelTitle cancelBlock:(void (^)(SDCAlertView *))cancelBlock{
    if([NSStringFromClass([[[UIApplication sharedApplication] keyWindow] class]) isEqualToString:@"_UIAlertControllerShimPresenterWindow"]){
        DCAlertView *alert=[[DCAlertView alloc] initWithTitle:title message:attributedString.string cancelButtonTitle:cancelTitle submitButtonTitle:submitTitle];
        alert.submitBlock=submitBlock;
        alert.cancelBlock=cancelBlock;
        [alert show];
        return;
    }
    DCAlertController *alertController=[self alertControllerWithTitle:nil message:nil preferredStyle:SDCAlertControllerStyleLegacyAlert];
    /*
     * SDCAlertControllerStyleLegacyAlert使用这种模式时，controller只充当中间件的作用
     * 真正生效的为alertController.legacyAlertView，controller在当前函数结束后即被释放
     * 所以dismiss时必须使用alertController.legacyAlertView
     * ps 旧代码因为循环引用导致alertController溢出
     */
    alertController.contentView.backgroundColor=[UIColor whiteColor];
    alertController.legacyAlertView.layer.cornerRadius=2;
    
    AlertBackgroundView *alertBackgroundView=[[AlertBackgroundView alloc] init];
    alertBackgroundView.backgroundColor=[UIColor whiteColor];
    [alertController.contentView addSubview:alertBackgroundView];
    __weak __typeof(alertController.legacyAlertView)weakLegacyAlertView = alertController.legacyAlertView;
    
    alertBackgroundView.submitBlock=^{
        RUN(submitBlock,weakLegacyAlertView);
    };
    alertBackgroundView.cancelBlock=^{
        RUN(cancelBlock,weakLegacyAlertView);
    };
    
    __weak __typeof(alertController)weakAlert = alertController;
    [alertBackgroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(270);
        make.top.left.right.bottom.equalTo(weakAlert.contentView).priorityHigh();
    }];
    [alertBackgroundView setTitle:title];
    [alertBackgroundView setAttributeContent:attributedString];
    [alertBackgroundView setSubmitButtonTitle:submitTitle];
    [alertBackgroundView setCancelButtonTitle:cancelTitle];
    [alertController presentWithCompletion:nil];
}

-(void)dealloc{
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){
        
    }
}

+(void)showAlertWithTitle:(NSString *)title content:(NSString *)content submitTitle:(NSString *)submitTitle submitBlock:(void (^)(void))submitCompletion cancelBlock:(void(^)(void))cancelCompletion{
    NSAttributedString *string=[[NSAttributedString alloc] initWithString:content attributes:[AlertAttributeString attributesWithFontSize:14 color:[UIColor getColor:@"999999"] lineSpacing:7 alignment:NSTextAlignmentCenter]];
    [DCAlertController showAlertWithTitle:title attributeContent:string submitTitle:submitTitle submitBlock:^(SDCAlertView *alertView) {
        [alertView dismissWithClickedButtonIndex:NSIntegerMax animated:YES];
        RUN(submitCompletion);
    } cancelTitle:@"取消" cancelBlock:^(SDCAlertView *alertView) {
        [alertView dismissWithClickedButtonIndex:NSIntegerMax animated:YES];
        RUN(cancelCompletion);
    }];
}

+(void)showForceUpdateAlert:(NSString *)desc {
    NSString *desC = [[NSString alloc] initWithString:desc.length==0?@"旧版本已无法提供服务，请您下载最新版APP，谢谢":desc];
    NSAttributedString *attr = TSAttributedString(desC.typeset.fontSize(15).color([UIColor  getColor:@"78818f"]).textAlignment(NSTextAlignmentCenter).lineSpacing(3).string);
    [DCAlertController showAlertV2WithTitle:@"请更新最新版本" attributeContent:attr closeBtnHidden:YES submitTitle:@"去更新" submitBlock:^(SDCAlertView *alertView) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/id982291973?mt=8"]];
    } cancelTitle:nil cancelBlock:nil closeBlock:nil];
    
}

+(void)showAlertWithTitle:(NSString *)title content:(NSString *)content submitTitle:(NSString *)submitTitle submitBlock:(void (^)(void))submitCompletion cancelTitle:(NSString *)cancelTitle cancelBlock:(void(^)(void))cancelCompletion{
    NSAttributedString *string=[[NSAttributedString alloc] initWithString:content attributes:[AlertAttributeString attributesWithFontSize:14 color:[UIColor getColor:@"999999"] lineSpacing:7 alignment:NSTextAlignmentCenter]];
    [DCAlertController showAlertWithTitle:title attributeContent:string submitTitle:submitTitle submitBlock:^(SDCAlertView *alertView) {
        [alertView dismissWithClickedButtonIndex:NSIntegerMax animated:YES];
        RUN(submitCompletion);
    } cancelTitle:cancelTitle cancelBlock:^(SDCAlertView *alertView) {
        [alertView dismissWithClickedButtonIndex:NSIntegerMax animated:YES];
        RUN(cancelCompletion);
    }];
}

+(void)showAlertWithTitle:(NSString *)title content:(NSString *)content submitBlock:(void (^)(void))submitCompletion{
    NSAttributedString *string=[[NSAttributedString alloc] initWithString:content attributes:[AlertAttributeString attributesWithFontSize:14 color:[UIColor getColor:@"999999"] lineSpacing:7 alignment:NSTextAlignmentCenter]];
    [DCAlertController showAlertWithTitle:title attributeContent:string submitTitle:@"确定" submitBlock:^(SDCAlertView *alertView) {
        [alertView dismissWithClickedButtonIndex:NSIntegerMax animated:YES];
        RUN(submitCompletion);
    } cancelTitle:@"取消" cancelBlock:^(SDCAlertView *alertView) {
        [alertView dismissWithClickedButtonIndex:NSIntegerMax animated:YES];
    }];
}

+(void)showAlertWithTitle:(NSString *)title content:(NSString *)content{
    NSAttributedString *string=[[NSAttributedString alloc] initWithString:content attributes:[AlertAttributeString attributesWithFontSize:14 color:[UIColor getColor:@"666666"] lineSpacing:7 alignment:NSTextAlignmentCenter]];
    [DCAlertController showAlertWithTitle:title attributeContent:string submitTitle:@"知道了" submitBlock:^(SDCAlertView *alertView) {
        [alertView dismissWithClickedButtonIndex:NSIntegerMax animated:YES];
    } cancelTitle:nil cancelBlock:nil];
}

+(void)showAlertWithTitle:(NSString *)title content:(NSString *)content iKnowBlock:(void (^)(void))iKnowBlock{
    NSAttributedString *string=[[NSAttributedString alloc] initWithString:content attributes:[AlertAttributeString attributesWithFontSize:14 color:[UIColor getColor:@"666666"] lineSpacing:7 alignment:NSTextAlignmentCenter]];
    [DCAlertController showAlertWithTitle:title attributeContent:string submitTitle:@"知道了" submitBlock:^(SDCAlertView *alertView) {
        [alertView dismissWithClickedButtonIndex:NSIntegerMax animated:YES];
        RUN(iKnowBlock);
    } cancelTitle:nil cancelBlock:nil];
}


+(void)showAlertWithTitle:(NSString *)title content:(NSString *)content submitTitle:(NSString *)submitTitle submitBlock:(void (^)(void))submitCompletion{
    NSAttributedString *string=[[NSAttributedString alloc] initWithString:content attributes:[AlertAttributeString attributesWithFontSize:14 color:[UIColor getColor:@"999999"] lineSpacing:7 alignment:NSTextAlignmentCenter]];
    [DCAlertController showAlertWithTitle:title attributeContent:string submitTitle:submitTitle submitBlock:^(SDCAlertView *alertView) {
        [alertView dismissWithClickedButtonIndex:NSIntegerMax animated:YES];
        RUN(submitCompletion);
    } cancelTitle:@"取消" cancelBlock:^(SDCAlertView *alertView) {
        [alertView dismissWithClickedButtonIndex:NSIntegerMax animated:YES];
    }];
}

//注销
+ (void)showAlertWithTitle:(NSString *)title
                   content:(NSString *)content
               submitTitle:(NSString *)submitTitle
            configureBlock:(void(^)(void))configureBlock {
    NSAttributedString *string=[[NSAttributedString alloc] initWithString:content attributes:[AlertAttributeString attributesWithFontSize:14 color:[UIColor getColor:@"565E6A"] lineSpacing:7 alignment:NSTextAlignmentCenter]];
    [DCAlertController showAlertWithTitle:title attributeContent:string submitTitle:submitTitle submitBlock:^(SDCAlertView *alertView) {
        [alertView dismissWithClickedButtonIndex:NSIntegerMax animated:YES];
        RUN(configureBlock);
    } cancelTitle:nil cancelBlock:nil];
}

#pragma mark - V2
+(void)showAlertV2WithTitle:(NSString *)title
         attributeContent:(NSAttributedString *)attributedString
              closeBtnHidden:(BOOL)hidden
              submitTitle:(NSString *)submitTitle
              submitBlock:(void (^)(SDCAlertView *))submitBlock
              cancelTitle:(NSString *)cancelTitle
                cancelBlock:(void (^)(SDCAlertView *))cancelBlock
                closeBlock:(void(^)())closeCompletion{

    if([NSStringFromClass([[[UIApplication sharedApplication] keyWindow] class]) isEqualToString:@"_UIAlertControllerShimPresenterWindow"]){
        DCAlertView *alert=[[DCAlertView alloc] initWithTitle:title message:attributedString.string cancelButtonTitle:cancelTitle submitButtonTitle:submitTitle];
        alert.submitBlock=submitBlock;
        alert.cancelBlock=cancelBlock;
        [alert show];
        return;
    }
    DCAlertController *alertController=[self alertControllerWithTitle:nil message:nil preferredStyle:SDCAlertControllerStyleLegacyAlert];
    alertController.contentView.backgroundColor=[UIColor whiteColor];
    alertController.legacyAlertView.layer.cornerRadius=6;

    DCAlertBackgroundView *alertBackgroundView=[[DCAlertBackgroundView alloc] init];
    alertBackgroundView.backgroundColor=[UIColor whiteColor];
    [alertController.contentView addSubview:alertBackgroundView];
    __weak __typeof(alertController.legacyAlertView)weakLegacyAlertView = alertController.legacyAlertView;
    
    alertBackgroundView.submitBlock=^{
        RUN(submitBlock,weakLegacyAlertView);
    };
    alertBackgroundView.cancelBlock=^{
        RUN(cancelBlock,weakLegacyAlertView);
    };
    alertBackgroundView.closeBlock=^{
        RUN(closeCompletion,weakLegacyAlertView);
        [weakLegacyAlertView dismissWithClickedButtonIndex:NSIntegerMax animated:YES];
    };
    __weak __typeof(alertController)weakAlert = alertController;
    [alertBackgroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(270);
        make.top.left.right.bottom.equalTo(weakAlert.contentView).priorityHigh();
    }];
    [alertBackgroundView setTitle:title];
    [alertBackgroundView setAttributeContent:attributedString];
    [alertBackgroundView setSubmitButtonTitle:submitTitle textColor:[UIColor getColor:@"333333"]];
    [alertBackgroundView setCancelButtonTitle:cancelTitle textColor:[UIColor getColor:@"4A90E2"]];
    [alertBackgroundView setCloseButtonHidden:hidden];
    [alertController presentWithCompletion:nil];
}

//带 右上角关闭按钮 一个按钮
+(void)showAlertV2WithTitle:(NSString *)title
           attributeContent:(NSAttributedString *)attributedString
                closeBtnHidden:(BOOL)hidden
                submitTitle:(NSString *)submitTitle
                submitBlock:(void (^)())submitBlock
                closeBlock:(void(^)())closeCompletion{
    [DCAlertController showAlertV2WithTitle:title attributeContent:attributedString closeBtnHidden:hidden submitTitle:submitTitle submitBlock:^(SDCAlertView *alertView) {
        [alertView dismissWithClickedButtonIndex:NSIntegerMax animated:YES];
        RUN(submitBlock);
    } cancelTitle:nil cancelBlock:nil closeBlock:^{
        RUN(closeCompletion);
    }];
}

//带 右上角关闭按钮 两个按钮
+(void)showAlertV2WithTitle:(NSString *)title
          attributeSContent:(NSAttributedString *)attributedString
                closeBtnHidden:(BOOL)hidden
                submitTitle:(NSString *)submitTitle
                submitBlock:(void (^)())submitBlock
                cancelTitle:(NSString *)cancelTitle
                cancelBlock:(void(^)())cancelCompletion
                closeBlock:(void(^)())closeCompletion{
    
    [DCAlertController showAlertV2WithTitle:title attributeContent:attributedString closeBtnHidden:hidden submitTitle:submitTitle submitBlock:^(SDCAlertView *alertView) {
        [alertView dismissWithClickedButtonIndex:NSIntegerMax animated:YES];
        RUN(submitBlock);
    } cancelTitle:cancelTitle cancelBlock:^(SDCAlertView *alert) {
        [alert dismissWithClickedButtonIndex:NSIntegerMax animated:YES];
        RUN(cancelCompletion);
    } closeBlock:^{
        RUN(closeCompletion);
    }];
}

+(void)showAlertV3WithTitle:(NSString *)title
           attributeContent:(NSAttributedString *)attributedString
                closeBtnHidden:(BOOL)hidden
                submitTitle:(NSString *)submitTitle
                submitBlock:(void (^)(SDCAlertView *))submitBlock
                cancelTitle:(NSString *)cancelTitle
                cancelBlock:(void (^)(SDCAlertView *))cancelBlock{
    if([NSStringFromClass([[[UIApplication sharedApplication] keyWindow] class]) isEqualToString:@"_UIAlertControllerShimPresenterWindow"]){
        DCAlertView *alert=[[DCAlertView alloc] initWithTitle:title message:attributedString.string cancelButtonTitle:cancelTitle submitButtonTitle:submitTitle];
        alert.submitBlock=submitBlock;
        alert.cancelBlock=cancelBlock;
        [alert show];
        return;
    }
    DCAlertController *alertController=[self alertControllerWithTitle:nil message:nil preferredStyle:SDCAlertControllerStyleLegacyAlert];
    alertController.contentView.backgroundColor=[UIColor whiteColor];
    alertController.legacyAlertView.layer.cornerRadius=6;
    
    DCAlertBackgroundViewV2 *alertBackgroundView=[[DCAlertBackgroundViewV2 alloc] init];
    alertBackgroundView.backgroundColor=[UIColor whiteColor];
    [alertController.contentView addSubview:alertBackgroundView];
    __weak __typeof(alertController.legacyAlertView)weakLegacyAlertView = alertController.legacyAlertView;
    
    alertBackgroundView.submitBlock=^{
        RUN(submitBlock,weakLegacyAlertView);
    };
    alertBackgroundView.closeBlock=^{
        [weakLegacyAlertView dismissWithClickedButtonIndex:NSIntegerMax animated:YES];
    };
    __weak __typeof(alertController)weakAlert = alertController;
    [alertBackgroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(270);
        make.top.left.right.bottom.equalTo(weakAlert.contentView).priorityHigh();
    }];
    [alertBackgroundView setTitle:title];
    [alertBackgroundView setAttributeContent:attributedString];
    [alertBackgroundView setSubmitButtonTitle:submitTitle textColor:[UIColor getColor:@"333333"]];
    [alertBackgroundView setCloseButtonHidden:hidden];
    [alertController presentWithCompletion:nil];
}

+(void)showAlertV3WithTitle:(NSString *)title
          attributeSContent:(NSAttributedString *)attributedString
             closeBtnHidden:(BOOL)hidden
                submitTitle:(NSString *)submitTitle
                submitBlock:(void (^)())submitBlock{
    [DCAlertController showAlertV3WithTitle:title attributeContent:attributedString closeBtnHidden:hidden submitTitle:submitTitle submitBlock:^(SDCAlertView *alertView) {
        [alertView dismissWithClickedButtonIndex:NSIntegerMax animated:YES];
        RUN(submitBlock);
    } cancelTitle:nil cancelBlock:nil];
}

#pragma mark - 首页
+(void)showCityNotOpenAlertTitle:(NSString *)title
                         content:(NSString *)content
                           image:(UIImage *)image
                     submitTitle:(NSString *)submitTitle
                     submitBlock:(void (^)(SDCAlertView *a))submitBlock
                     cancelTitle:(NSString *)cancelTitle
                     cancelBlock:(void (^)(SDCAlertView *a))cancelBlock{
    if([NSStringFromClass([[[UIApplication sharedApplication] keyWindow] class]) isEqualToString:@"_UIAlertControllerShimPresenterWindow"]){
        DCAlertView *alert=[[DCAlertView alloc] initWithTitle:title message:content cancelButtonTitle:cancelTitle submitButtonTitle:submitTitle];
        alert.submitBlock=submitBlock;
        alert.cancelBlock=cancelBlock;
        [alert show];
        return;
    }
    DCAlertController *alertController=[self alertControllerWithTitle:nil message:nil preferredStyle:SDCAlertControllerStyleLegacyAlert];
    alertController.contentView.backgroundColor=[UIColor whiteColor];
    alertController.legacyAlertView.layer.cornerRadius=2;
    
    // 初始化属性
    IndexAlertBackgroundView *alertBackgroundView=[[IndexAlertBackgroundView alloc] init];
    alertBackgroundView.backgroundColor=[UIColor whiteColor];
    alertBackgroundView.titleLabel.text=title;
    alertBackgroundView.contentLabel.text=content;
    [alertBackgroundView.submitButton setTitle:submitTitle forState:UIControlStateNormal];
    [alertBackgroundView.cancelButton setTitle:cancelTitle forState:UIControlStateNormal];
    alertBackgroundView.imageView.image=image;
    __weak __typeof(alertController.legacyAlertView)weakLegacyAlertView = alertController.legacyAlertView;
    alertBackgroundView.submitBlock=^{
        [weakLegacyAlertView dismissWithClickedButtonIndex:NSIntegerMax animated:YES];
        RUN(submitBlock,weakLegacyAlertView);
    };
    alertBackgroundView.cancelBlock=^{
        [weakLegacyAlertView dismissWithClickedButtonIndex:NSIntegerMax animated:YES];
        RUN(cancelBlock,weakLegacyAlertView);
    };
    
    // 约束
    __weak __typeof(alertController)weakAlert = alertController;
    [alertController.contentView addSubview:alertBackgroundView];
    [alertBackgroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(weakAlert.contentView);
    }];
    
    
    [alertController presentWithCompletion:nil];
}

+(void)showPayResultTipAlertTitle:(NSString *)title content:(NSString *)content image:(UIImage *)image type:(PayAlertBackgroundViewType)type submitTitle:(NSString *)submitTitle
                       submitBlock:(void (^)(SDCAlertView *))submitBlock cancelTitle:(NSString *)cancelTitle cancelBlock:(void (^)(SDCAlertView *))cancelBlock{
    if([NSStringFromClass([[[UIApplication sharedApplication] keyWindow] class]) isEqualToString:@"_UIAlertControllerShimPresenterWindow"]){
        DCAlertView *alert=[[DCAlertView alloc] initWithTitle:title message:content cancelButtonTitle:cancelTitle submitButtonTitle:submitTitle];
        alert.submitBlock=submitBlock;
        alert.cancelBlock=cancelBlock;
        [alert show];
        return;
    }
    
    DCAlertController *alertController=[self alertControllerWithTitle:nil message:nil preferredStyle:SDCAlertControllerStyleLegacyAlert];
    alertController.contentView.backgroundColor=[UIColor whiteColor];
    alertController.legacyAlertView.layer.cornerRadius=2;
    
    // 初始化属性
    PayAlertBackgroundView *alertBackgroundView=[[PayAlertBackgroundView alloc] init];
    alertBackgroundView.alertviewType = type;
    alertBackgroundView.backgroundColor=[UIColor whiteColor];
    alertBackgroundView.titleLab.text=title;
    alertBackgroundView.contentLab.text=content;
    alertBackgroundView.logoImage.image=image;
    __weak __typeof(alertController.legacyAlertView)weakLegacyAlertView = alertController.legacyAlertView;
    __weak __typeof(alertController)weakAlert = alertController;
    if (type == PayAlertBackgroundViewTypeSuccess) {
        [alertBackgroundView.lookOrderBtn setTitle:submitTitle forState:UIControlStateNormal];
        alertBackgroundView.submitBlock=^{
            [weakLegacyAlertView dismissWithClickedButtonIndex:NSIntegerMax animated:YES];
            RUN(submitBlock,weakLegacyAlertView);
        };
    }else {
        [alertBackgroundView.leftBtn setTitle:cancelTitle forState:UIControlStateNormal];
        [alertBackgroundView.rightBtn setTitle:submitTitle forState:UIControlStateNormal];
        alertBackgroundView.submitBlock=^{
            [weakLegacyAlertView dismissWithClickedButtonIndex:NSIntegerMax animated:YES];
            RUN(submitBlock,weakLegacyAlertView);
        };
        alertBackgroundView.cancelBlock=^{
            [weakLegacyAlertView dismissWithClickedButtonIndex:NSIntegerMax animated:YES];
            RUN(cancelBlock,weakLegacyAlertView);
        };
        
    }
    // 约束
    [alertController.contentView addSubview:alertBackgroundView];
    [alertBackgroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(weakAlert.contentView);
    }];
    
    [alertController presentWithCompletion:nil];
}

//合并弹框
+ (void)showMergeAlertWithTitle:(NSString *)title
               attributeContent:(NSAttributedString *)attributedString
                    submitTitle:(NSString *)submitTitle
                    submitBlock:(void (^)(SDCAlertView *))submitBlock
                    cancelTitle:(NSString *)cancelTitle
                    cancelBlock:(void (^)(SDCAlertView *))cancelBlock {
    if ([NSStringFromClass([[[UIApplication sharedApplication] keyWindow] class]) isEqualToString:@"_UIAlertControllerShimPresenterWindow"]) {
        DCAlertView *alert = [[DCAlertView alloc] initWithTitle:title message:attributedString.string cancelButtonTitle:cancelTitle submitButtonTitle:submitTitle];
        alert.submitBlock = submitBlock;
        alert.cancelBlock = cancelBlock;
        [alert show];
        return;
    }
    DCAlertController *alertController = [self alertControllerWithTitle:nil message:nil preferredStyle:SDCAlertControllerStyleLegacyAlert];
    alertController.contentView.backgroundColor = [UIColor whiteColor];
    alertController.legacyAlertView.layer.cornerRadius = 6;
    
    DCAlertMergeAccountBackgroundView *alertBackgroundView = [[DCAlertMergeAccountBackgroundView alloc] init];
    alertBackgroundView.backgroundColor = [UIColor whiteColor];
    [alertController.contentView addSubview:alertBackgroundView];
    __weak __typeof(alertController.legacyAlertView)weakLegacyAlertView = alertController.legacyAlertView;
    
    alertBackgroundView.submitBlock = ^{
        RUN(submitBlock,weakLegacyAlertView);
        [weakLegacyAlertView dismissWithClickedButtonIndex:NSIntegerMax animated:YES];
    };
    alertBackgroundView.cancelBlock = ^{
        RUN(cancelBlock,weakLegacyAlertView);
        [weakLegacyAlertView dismissWithClickedButtonIndex:NSIntegerMax animated:YES];
    };
    
    __weak __typeof(alertController)weakAlert = alertController;
    [alertBackgroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(270);
        make.top.left.right.bottom.equalTo(weakAlert.contentView).priorityHigh();
    }];
    [alertBackgroundView setTitle:title];
    [alertBackgroundView setAttributeContent:attributedString];
    [alertBackgroundView setSubmitButtonTitle:submitTitle textColor:[UIColor getColor:@"127FE4"]];
    [alertBackgroundView setCancelButtonTitle:cancelTitle textColor:[UIColor getColor:@"000000"]];
    [alertController presentWithCompletion:nil];
}

@end
