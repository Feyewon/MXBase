//
//  UIViewController+KHNavigationController.m
//  KHMainModule
//
//  Created by FEI on 2019/3/29.
//

#import "UIViewController+KHNavigationController.h"

#import <objc/runtime.h>
#import "KHNavigationController.h"

@implementation UIViewController (KHNavigationController)
@dynamic kh_disableInteractivePop;

- (void)setKh_disableInteractivePop:(BOOL)kh_disableInteractivePop
{
    objc_setAssociatedObject(self, @selector(kh_disableInteractivePop), @(kh_disableInteractivePop), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)kh_disableInteractivePop
{
    return [objc_getAssociatedObject(self, @selector(kh_disableInteractivePop)) boolValue];
}

- (Class)kh_navigationBarClass
{
    return nil;
}

- (KHNavigationController *)kh_navigationController
{
    UIViewController *vc = self;
    while (vc && ![vc isKindOfClass:[KHNavigationController class]]) {
        vc = vc.navigationController;
    }
    return (KHNavigationController *)vc;
}


- (UIBarButtonItem *)kh_customBackItemWithTarget:(id)target action:(SEL)action
{
    return [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"common_screen_change_icon"]
                                            style:UIBarButtonItemStylePlain target:target action:action];
}



@end
