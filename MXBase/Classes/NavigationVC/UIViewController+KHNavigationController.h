//
//  UIViewController+KHNavigationController.h
//  KHMainModule
//
//  Created by FEI on 2019/3/29.
//

#import <UIKit/UIKit.h>

@class KHNavigationController;

@protocol KHNavigationItemCustomizable <NSObject>

@optional

/*!
 *  @brief Override this method to provide a custom back bar item, default is a normal @c UIBarButtonItem with title @b "Back"
 *
 *  @param target the action target
 *  @param action the pop back action
 *
 *  @return a custom UIBarButtonItem
 */
- (UIBarButtonItem *)customBackItemWithTarget:(id)target action:(SEL)action DEPRECATED_MSG_ATTRIBUTE("use kh_customBackItemWithTarget:action: instead!");
- (UIBarButtonItem *)kh_customBackItemWithTarget:(id)target action:(SEL)action;

@end

IB_DESIGNABLE
@interface UIViewController (KHNavigationController) <KHNavigationItemCustomizable>

/*!
 *  @brief set this property to @b YES to disable interactive pop
 */
@property (nonatomic, assign) IBInspectable BOOL kh_disableInteractivePop;

/*!
 *  @brief @c self\.navigationControlle will get a wrapping @c UINavigationController, use this property to get the real navigation controller
 */
@property (nonatomic, readonly, strong) KHNavigationController *kh_navigationController;

/*!
 *  @brief Override this method to provide a custom subclass of @c UINavigationBar, defaults return nil
 *
 *  @return new UINavigationBar class
 */
- (Class)kh_navigationBarClass;

@end
