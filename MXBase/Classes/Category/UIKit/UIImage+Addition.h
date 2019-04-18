//
//  UIImage+Addition.h
//  MagicCamera
//
//  Created by fzw on 2019/1/2.
//  Copyright © 2019 Mxtrip. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Addition)
/**
 用base64字符串生成图片
 @param imgSrc base64字符串
 @return 图片
 */
+ (UIImage *)imageWithBase64String:(NSString *)imgSrc;

/**
 创建带渐变色的图片
 
 @param colors 颜色数组 如：@[[UIColor getColor:@"FF9053"],[UIColor getColor:@"FF6000"]]
 @param startPoint 渐变方向，需和endPoint配合；如CGPointZero
 @param endPoint 渐变方向，需和startPoint配合；如CGPointMake(0, 1)
 @param locations 渐变位置，必须和colors保持数量一致 @[@0,@1]
 @param size 图片大小
 @return 图片
 */
+ (UIImage*) createImageWithColors:(NSArray *)colors
                        startPoint:(CGPoint)startPoint
                          endPoint:(CGPoint)endPoint
                         locations:(NSArray <NSNumber *>*)locations
                              size:(CGSize)size;

/**
 质量压缩
 @return 压缩后的图片
 */
-(UIImage *)mc_compressImage;


- (UIImage *)imageByResizeToSize:(CGSize)size
                     contentMode:(UIViewContentMode)contentMode;

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
