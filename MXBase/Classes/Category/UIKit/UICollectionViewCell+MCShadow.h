//
//  UICollectionViewCell+MCShadow.h
//  MagicCamera
//
//  Created by fzw on 2019/1/7.
//  Copyright © 2019 Mxtrip. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionViewCell (MCShadow)
- (void)mc_setShadowWithCornerRadius:(CGFloat)cornerRadius
                         shadowColor:(UIColor *)shadowColor
                        shadowOffset:(CGSize)shadowOffset
                        shadowRadius:(CGFloat)shadowRadius
                       shadowOpacity:(CGFloat)shadowOpacity;
@end
