//
//  UICollectionViewCell+MCShadow.m
//  MagicCamera
//
//  Created by fzw on 2019/1/7.
//  Copyright © 2019 Mxtrip. All rights reserved.
//

#import "UICollectionViewCell+MCShadow.h"

@implementation UICollectionViewCell (MCShadow)
- (void)mc_setShadowWithCornerRadius:(CGFloat)cornerRadius
                         shadowColor:(UIColor *)shadowColor
                        shadowOffset:(CGSize)shadowOffset
                        shadowRadius:(CGFloat)shadowRadius
                       shadowOpacity:(CGFloat)shadowOpacity {
    
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = cornerRadius;
    
    self.layer.shadowOffset = shadowOffset;
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowRadius = shadowRadius;
    self.layer.shadowOpacity = shadowOpacity;
    self.layer.masksToBounds = NO;
}
@end
