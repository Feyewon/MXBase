//
//  UIFont+Addition.m
//  MagicCamera
//
//  Created by fzw on 2019/1/5.
//  Copyright © 2019 Mxtrip. All rights reserved.
//

#import "UIFont+Addition.h"

@implementation UIFont (Addition)
+ (UIFont *)systemUltraLightFontOfSize:(CGFloat)fontSize {
    if (@available(iOS 8.2, *)) {
        return [UIFont systemFontOfSize:fontSize weight:UIFontWeightUltraLight];
    } else {
        return [UIFont systemFontOfSize:fontSize];
    }
}

+ (UIFont *)systemThinFontOfSize:(CGFloat)fontSize {
    if (@available(iOS 8.2, *)) {
        return [UIFont systemFontOfSize:fontSize weight:UIFontWeightThin];
    } else {
        return [UIFont systemFontOfSize:fontSize];
    }
}

+ (UIFont *)systemLightFontOfSize:(CGFloat)fontSize {
    if (@available(iOS 8.2, *)) {
        return [UIFont systemFontOfSize:fontSize weight:UIFontWeightLight];
    } else {
        return [UIFont systemFontOfSize:fontSize];
    }
}

+ (UIFont *)systemRegularFontOfSize:(CGFloat)fontSize {
    if (@available(iOS 8.2, *)) {
        return [UIFont systemFontOfSize:fontSize weight:UIFontWeightRegular];
    } else {
        return [UIFont systemFontOfSize:fontSize];
    }
}

+ (UIFont *)systemMediumFontOfSize:(CGFloat)fontSize {
    if (@available(iOS 8.2, *)) {
        return [UIFont systemFontOfSize:fontSize weight:UIFontWeightMedium];
    } else {
        return [UIFont systemFontOfSize:fontSize];
    }
}

+ (UIFont *)systemSemiboldFontOfSize:(CGFloat)fontSize {
    if (@available(iOS 8.2, *)) {
        return [UIFont systemFontOfSize:fontSize weight:UIFontWeightSemibold];
    } else {
        return [UIFont systemFontOfSize:fontSize];
    }
}

+ (UIFont *)systemHeavyFontOfSize:(CGFloat)fontSize {
    if (@available(iOS 8.2, *)) {
        return [UIFont systemFontOfSize:fontSize weight:UIFontWeightHeavy];
    } else {
        return [UIFont systemFontOfSize:fontSize];
    }
}

+ (UIFont *)systemBlackFontOfSize:(CGFloat)fontSize {
    if (@available(iOS 8.2, *)) {
        return [UIFont systemFontOfSize:fontSize weight:UIFontWeightBlack];
    } else {
        return [UIFont systemFontOfSize:fontSize];
    }
}
@end
