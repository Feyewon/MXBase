//
//  KHNavigationController.m
//  KHMainModule_Example
//
//  Created by FEI on 2019/3/29.
//  Copyright © 2019 Feyewon. All rights reserved.
//

#import <objc/runtime.h>
#import "KHNavigationController.h"
#import "UIViewController+KHNavigationController.h"

@interface NSArray<ObjectType> (KHNavigationController)
- (NSArray *)kh_map:(id(^)(ObjectType obj, NSUInteger index))block;
- (BOOL)kh_any:(BOOL(^)(ObjectType obj))block;
@end

@implementation NSArray (KHNavigationController)

- (NSArray *)kh_map:(id (^)(id obj, NSUInteger index))block
{
    if (!block) {
        block = ^(id obj, NSUInteger index) {
            return obj;
        };
    }
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * stop) {
        [array addObject:block(obj, idx)];
    }];
    return [NSArray arrayWithArray:array];
}

- (BOOL)kh_any:(BOOL (^)(id))block
{
    if (!block)
    return NO;
    
    __block BOOL result = NO;
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * stop) {
        if (block(obj)) {
            result = YES;
            *stop = YES;
        }
    }];
    return result;
}

@end


@interface KHNavigationController () <UINavigationControllerDelegate, UIGestureRecognizerDelegate>
@property (nonatomic, weak) id<UINavigationControllerDelegate> kh_delegate;
@property (nonatomic, copy) void(^animationBlock)(BOOL finished);

- (void)_installsLeftBarButtonItemIfNeededForViewController:(UIViewController *)vc;
@end


@interface KHContainerController ()
@property (nonatomic, strong) __kindof UIViewController *contentViewController;
@property (nonatomic, strong) UINavigationController *containerNavigationController;

+ (instancetype)containerControllerWithController:(UIViewController *)controller;
+ (instancetype)containerControllerWithController:(UIViewController *)controller
                               navigationBarClass:(Class)navigationBarClass;
+ (instancetype)containerControllerWithController:(UIViewController *)controller
                               navigationBarClass:(Class)navigationBarClass
                        withPlaceholderController:(BOOL)yesOrNo;
+ (instancetype)containerControllerWithController:(UIViewController *)controller
                               navigationBarClass:(Class)navigationBarClass
                        withPlaceholderController:(BOOL)yesOrNo
                                backBarButtonItem:(UIBarButtonItem *)backItem
                                        backTitle:(NSString *)backTitle;

- (instancetype)initWithController:(UIViewController *)controller;
- (instancetype)initWithController:(UIViewController *)controller navigationBarClass:(Class)navigationBarClass;

@end


static inline UIViewController *KHSafeUnwrapViewController(UIViewController *controller) {
    if ([controller isKindOfClass:[KHContainerController class]]) {
        return ((KHContainerController *)controller).contentViewController;
    }
    return controller;
}

__attribute((overloadable)) static inline UIViewController *KHSafeWrapViewController(UIViewController *controller,
                                                                                     Class navigationBarClass,
                                                                                     BOOL withPlaceholder,
                                                                                     UIBarButtonItem *backItem,
                                                                                     NSString *backTitle) {
    if (![controller isKindOfClass:[KHContainerController class]]) {
        return [KHContainerController containerControllerWithController:controller
                                                     navigationBarClass:navigationBarClass
                                              withPlaceholderController:withPlaceholder
                                                      backBarButtonItem:backItem
                                                              backTitle:backTitle];
    }
    return controller;
}

__attribute((overloadable)) static inline UIViewController *KHSafeWrapViewController(UIViewController *controller, Class navigationBarClass, BOOL withPlaceholder) {
    if (![controller isKindOfClass:[KHContainerController class]]) {
        return [KHContainerController containerControllerWithController:controller
                                                     navigationBarClass:navigationBarClass
                                              withPlaceholderController:withPlaceholder];
    }
    return controller;
}

__attribute((overloadable)) static inline UIViewController *KHSafeWrapViewController(UIViewController *controller, Class navigationBarClass) {
    return KHSafeWrapViewController(controller, navigationBarClass, NO);
}


@implementation KHContainerController

+ (instancetype)containerControllerWithController:(UIViewController *)controller
{
    return [[self alloc] initWithController:controller];
}

+ (instancetype)containerControllerWithController:(UIViewController *)controller
                               navigationBarClass:(Class)navigationBarClass
{
    return [[self alloc] initWithController:controller
                         navigationBarClass:navigationBarClass];
}

+ (instancetype)containerControllerWithController:(UIViewController *)controller
                               navigationBarClass:(Class)navigationBarClass
                        withPlaceholderController:(BOOL)yesOrNo
{
    return [[self alloc] initWithController:controller
                         navigationBarClass:navigationBarClass
                  withPlaceholderController:yesOrNo];
}

+ (instancetype)containerControllerWithController:(UIViewController *)controller
                               navigationBarClass:(Class)navigationBarClass
                        withPlaceholderController:(BOOL)yesOrNo
                                backBarButtonItem:(UIBarButtonItem *)backItem
                                        backTitle:(NSString *)backTitle
{
    return [[self alloc] initWithController:controller
                         navigationBarClass:navigationBarClass
                  withPlaceholderController:yesOrNo
                          backBarButtonItem:backItem
                                  backTitle:backTitle];
}

- (instancetype)initWithController:(UIViewController *)controller
                navigationBarClass:(Class)navigationBarClass
         withPlaceholderController:(BOOL)yesOrNo
                 backBarButtonItem:(UIBarButtonItem *)backItem
                         backTitle:(NSString *)backTitle
{
    self = [super init];
    if (self) {
        // not work while push to a hideBottomBar view controller, give up
        /*
         self.edgesForExtendedLayout = UIRectEdgeAll;
         self.extendedLayoutIncludesOpaqueBars = YES;
         self.automaticallyAdjustsScrollViewInsets = NO;
         */
        
        self.contentViewController = controller;
        self.containerNavigationController = [[KHContainerNavigationController alloc] initWithNavigationBarClass:navigationBarClass
                                                                                                    toolbarClass:nil];
        if (yesOrNo) {
            UIViewController *vc = [UIViewController new];
            vc.title = backTitle;
            vc.navigationItem.backBarButtonItem = backItem;
            self.containerNavigationController.viewControllers = @[vc, controller];
        }
        else
        self.containerNavigationController.viewControllers = @[controller];
        
        [self addChildViewController:self.containerNavigationController];
        [self.containerNavigationController didMoveToParentViewController:self];
    }
    return self;
}

- (instancetype)initWithController:(UIViewController *)controller
                navigationBarClass:(Class)navigationBarClass
         withPlaceholderController:(BOOL)yesOrNo
{
    return [self initWithController:controller
                 navigationBarClass:navigationBarClass
          withPlaceholderController:yesOrNo
                  backBarButtonItem:nil
                          backTitle:nil];
}

- (instancetype)initWithController:(UIViewController *)controller
                navigationBarClass:(Class)navigationBarClass
{
    return [self initWithController:controller
                 navigationBarClass:navigationBarClass
          withPlaceholderController:NO];
}

- (instancetype)initWithController:(UIViewController *)controller
{
    return [self initWithController:controller navigationBarClass:nil];
}

- (instancetype)initWithContentController:(UIViewController *)controller
{
    self = [super init];
    if (self) {
        self.contentViewController = controller;
        [self addChildViewController:self.contentViewController];
        [self.contentViewController didMoveToParentViewController:self];
    }
    return self;
}

- (NSString *)debugDescription
{
    return [NSString stringWithFormat:@"<%@: %p contentViewController: %@>", self.class, self, self.contentViewController];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.containerNavigationController) {
        self.containerNavigationController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self.view addSubview:self.containerNavigationController.view];
        
        self.containerNavigationController.view.frame = self.view.bounds;
    }
    else {
        self.contentViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.contentViewController.view.frame = self.view.bounds;
        [self.view addSubview:self.contentViewController.view];
    }
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

- (BOOL)becomeFirstResponder
{
    return [self.contentViewController becomeFirstResponder];
}

- (BOOL)canBecomeFirstResponder
{
    return [self.contentViewController canBecomeFirstResponder];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return [self.contentViewController preferredStatusBarStyle];
}

- (BOOL)prefersStatusBarHidden
{
    return [self.contentViewController prefersStatusBarHidden];
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation
{
    return [self.contentViewController preferredStatusBarUpdateAnimation];
}

#if __IPHONE_11_0 && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0
- (nullable UIViewController *)childViewControllerForScreenEdgesDeferringSystemGestures
{
    return self.contentViewController;
}

- (UIRectEdge)preferredScreenEdgesDeferringSystemGestures
{
    return [self.contentViewController preferredScreenEdgesDeferringSystemGestures];
}

- (BOOL)prefersHomeIndicatorAutoHidden
{
    return [self.contentViewController prefersHomeIndicatorAutoHidden];
}

- (UIViewController *)childViewControllerForHomeIndicatorAutoHidden
{
    return self.contentViewController;
}
#endif

- (BOOL)shouldAutorotate
{
    return self.contentViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return self.contentViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return self.contentViewController.preferredInterfaceOrientationForPresentation;
}

- (UIViewController *)viewControllerForUnwindSegueAction:(SEL)action
                                      fromViewController:(UIViewController *)fromViewController
                                              withSender:(id)sender
{
    return [self.contentViewController viewControllerForUnwindSegueAction:action
                                                       fromViewController:fromViewController
                                                               withSender:sender];
}

- (BOOL)hidesBottomBarWhenPushed
{
    return self.contentViewController.hidesBottomBarWhenPushed;
}

- (NSString *)title
{
    return self.contentViewController.title;
}

- (UITabBarItem *)tabBarItem
{
    return self.contentViewController.tabBarItem;
}

#if KH_INTERACTIVE_PUSH
- (nullable __kindof UIViewController *)kh_nextSiblingController
{
    return self.contentViewController.kh_nextSiblingController;
}
#endif

@end

@interface UIViewController (KHContainerNavigationController)
@property (nonatomic, assign, readonly) BOOL kh_hasSetInteractivePop;
@end

@implementation UIViewController (KHContainerNavigationController)

- (BOOL)kh_hasSetInteractivePop
{
    return !!objc_getAssociatedObject(self, @selector(kh_disableInteractivePop));
}

@end


@implementation KHContainerNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithNavigationBarClass:rootViewController.kh_navigationBarClass
                                toolbarClass:nil];
    if (self) {
        [self pushViewController:rootViewController animated:NO];
        // use following way will cause bug
        // self.viewControllers = @[rootViewController];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.interactivePopGestureRecognizer.delegate = nil;
    self.interactivePopGestureRecognizer.enabled = NO;
    
    if (self.kh_navigationController.transferNavigationBarAttributes) {
        self.navigationBar.translucent     = self.navigationController.navigationBar.isTranslucent;
        self.navigationBar.tintColor       = self.navigationController.navigationBar.tintColor;
        self.navigationBar.barTintColor    = self.navigationController.navigationBar.barTintColor;
        self.navigationBar.barStyle        = self.navigationController.navigationBar.barStyle;
        self.navigationBar.backgroundColor = self.navigationController.navigationBar.backgroundColor;
        
        [self.navigationBar setBackgroundImage:[self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault]
                                 forBarMetrics:UIBarMetricsDefault];
        [self.navigationBar setTitleVerticalPositionAdjustment:[self.navigationController.navigationBar titleVerticalPositionAdjustmentForBarMetrics:UIBarMetricsDefault]
                                                 forBarMetrics:UIBarMetricsDefault];
        
        self.navigationBar.titleTextAttributes              = self.navigationController.navigationBar.titleTextAttributes;
        self.navigationBar.shadowImage                      = self.navigationController.navigationBar.shadowImage;
        self.navigationBar.backIndicatorImage               = self.navigationController.navigationBar.backIndicatorImage;
        self.navigationBar.backIndicatorTransitionMaskImage = self.navigationController.navigationBar.backIndicatorTransitionMaskImage;
    }
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    UIViewController *viewController = self.visibleViewController;
    if (!viewController.kh_hasSetInteractivePop) {
        BOOL hasSetLeftItem = viewController.navigationItem.leftBarButtonItem != nil;
        if (self.navigationBarHidden) {
            viewController.kh_disableInteractivePop = YES;
        } else if (hasSetLeftItem) {
            viewController.kh_disableInteractivePop = YES;
        } else {
            viewController.kh_disableInteractivePop = NO;
        }
        
    }
    if ([self.parentViewController isKindOfClass:[KHContainerController class]] &&
        [self.parentViewController.parentViewController isKindOfClass:[KHNavigationController class]]) {
        [self.kh_navigationController _installsLeftBarButtonItemIfNeededForViewController:viewController];
    }
}

- (UITabBarController *)tabBarController
{
    UITabBarController *tabController = [super tabBarController];
    KHNavigationController *navigationController = self.kh_navigationController;
    if (tabController) {
        if (navigationController.tabBarController != tabController) {   // Tab is child of Root VC
            return tabController;
        }
        else {
            return !tabController.tabBar.isTranslucent || [navigationController.kh_viewControllers kh_any:^BOOL(__kindof UIViewController *obj) {
                return obj.hidesBottomBarWhenPushed;
            }] ? nil : tabController;
        }
    }
    return nil;
}

- (NSArray *)viewControllers
{
    if (self.navigationController) {
        if ([self.navigationController isKindOfClass:[KHNavigationController class]]) {
            return self.kh_navigationController.kh_viewControllers;
        }
    }
    return [super viewControllers];
}

- (UIViewController *)viewControllerForUnwindSegueAction:(SEL)action
                                      fromViewController:(UIViewController *)fromViewController
                                              withSender:(id)sender
{
    if (self.navigationController) {
        return [self.navigationController viewControllerForUnwindSegueAction:action
                                                          fromViewController:self.parentViewController
                                                                  withSender:sender];
    }
    return [super viewControllerForUnwindSegueAction:action
                                  fromViewController:fromViewController
                                          withSender:sender];
}

- (NSArray<UIViewController *> *)allowedChildViewControllersForUnwindingFromSource:(UIStoryboardUnwindSegueSource *)source
{
    if (self.navigationController) {
        return [self.navigationController allowedChildViewControllersForUnwindingFromSource:source];
    }
    return [super allowedChildViewControllersForUnwindingFromSource:source];
}

- (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated
{
    if (self.navigationController) {
        [self.navigationController pushViewController:viewController
                                             animated:animated];
    }
    else {
        [super pushViewController:viewController
                         animated:animated];
    }
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    if ([self.navigationController respondsToSelector:aSelector])
    return self.navigationController;
    return nil;
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    if (self.navigationController)
    return [self.navigationController popViewControllerAnimated:animated];
    return [super popViewControllerAnimated:animated];
}

- (NSArray<__kindof UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated
{
    if (self.navigationController)
    return [self.navigationController popToRootViewControllerAnimated:animated];
    return [super popToRootViewControllerAnimated:animated];
}

- (NSArray<__kindof UIViewController *> *)popToViewController:(UIViewController *)viewController
                                                     animated:(BOOL)animated
{
    if (self.navigationController)
    return [self.navigationController popToViewController:viewController
                                                 animated:animated];
    return [super popToViewController:viewController
                             animated:animated];
}

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated
{
    if (self.navigationController)
    [self.navigationController setViewControllers:viewControllers
                                         animated:animated];
    else
    [super setViewControllers:viewControllers animated:animated];
}

- (void)setDelegate:(id<UINavigationControllerDelegate>)delegate
{
    if (self.navigationController)
    self.navigationController.delegate = delegate;
    else
    [super setDelegate:delegate];
}

- (void)setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated
{
    [super setNavigationBarHidden:hidden animated:animated];
    if (!self.visibleViewController.kh_hasSetInteractivePop) {
        self.visibleViewController.kh_disableInteractivePop = hidden;
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return [self.topViewController preferredStatusBarStyle];
}

- (BOOL)prefersStatusBarHidden
{
    return [self.topViewController prefersStatusBarHidden];
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation
{
    return [self.topViewController preferredStatusBarUpdateAnimation];
}

#if __IPHONE_11_0 && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0
- (nullable UIViewController *)childViewControllerForScreenEdgesDeferringSystemGestures
{
    return self.topViewController;
}

- (UIRectEdge)preferredScreenEdgesDeferringSystemGestures
{
    return [self.topViewController preferredScreenEdgesDeferringSystemGestures];
}

- (BOOL)prefersHomeIndicatorAutoHidden
{
    return [self.topViewController prefersHomeIndicatorAutoHidden];
}

- (UIViewController *)childViewControllerForHomeIndicatorAutoHidden
{
    return self.topViewController;
}
#endif

@end


@implementation KHNavigationController

#pragma mark - Methods

- (void)onBack:(id)sender
{
    [self popViewControllerAnimated:YES];
}

- (void)_commonInit
{
    
}

- (void)_installsLeftBarButtonItemIfNeededForViewController:(UIViewController *)viewController
{
    BOOL isRootVC = viewController == KHSafeUnwrapViewController(self.viewControllers.firstObject);
    BOOL hasSetLeftItem = viewController.navigationItem.leftBarButtonItem != nil;
    if (!isRootVC && !self.useSystemBackBarButtonItem && !hasSetLeftItem) {
        if ([viewController respondsToSelector:@selector(kh_customBackItemWithTarget:action:)]) {
            viewController.navigationItem.leftBarButtonItem = [viewController kh_customBackItemWithTarget:self
                                                                                                   action:@selector(onBack:)];
        }
        else if ([viewController respondsToSelector:@selector(customBackItemWithTarget:action:)]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            viewController.navigationItem.leftBarButtonItem = [viewController customBackItemWithTarget:self
                                                                                                action:@selector(onBack:)];
#pragma clang diagnostic pop
        }
        else {
            viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Back", nil)
                                                                                               style:UIBarButtonItemStylePlain
                                                                                              target:self
                                                                                              action:@selector(onBack:)];
        }
    }
}

#pragma mark - Overrides

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.viewControllers = [super viewControllers];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _commonInit];
    }
    return self;
}

- (instancetype)initWithNavigationBarClass:(Class)navigationBarClass
                              toolbarClass:(Class)toolbarClass
{
    self = [super initWithNavigationBarClass:navigationBarClass toolbarClass:toolbarClass];
    if (self) {
        [self _commonInit];
    }
    return self;
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:KHSafeWrapViewController(rootViewController, rootViewController.kh_navigationBarClass)];
    if (self) {
        [self _commonInit];
    }
    return self;
}

- (instancetype)initWithRootViewControllerNoWrapping:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:[[KHContainerController alloc] initWithContentController:rootViewController]];
    if (self) {
        //        [super pushViewController:rootViewController
        //                         animated:NO];
        [self _commonInit];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [super setDelegate:self];
    [super setNavigationBarHidden:YES
                         animated:NO];
}

- (UIViewController *)viewControllerForUnwindSegueAction:(SEL)action
                                      fromViewController:(UIViewController *)fromViewController
                                              withSender:(id)sender
{
    UIViewController *controller = [super viewControllerForUnwindSegueAction:action
                                                          fromViewController:fromViewController
                                                                  withSender:sender];
    if (!controller) {
        NSInteger index = [self.viewControllers indexOfObject:fromViewController];
        if (index != NSNotFound) {
            for (NSInteger i = index - 1; i >= 0; --i) {
                controller = [self.viewControllers[i] viewControllerForUnwindSegueAction:action
                                                                      fromViewController:fromViewController
                                                                              withSender:sender];
                if (controller)
                break;
            }
        }
    }
    return controller;
}

- (void)setNavigationBarHidden:(__unused BOOL)hidden
                      animated:(__unused BOOL)animated
{
    // Override to protect
}

- (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated
{
    if (viewController == nil) {
        if (self.animationBlock) {
            self.animationBlock(YES);
            self.animationBlock = nil;
        }
        return;
    }
    
    if (self.childViewControllers.count == 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    if (self.viewControllers.count > 0) {
        UIViewController *currentLast = KHSafeUnwrapViewController(self.viewControllers.lastObject);
        [super pushViewController:KHSafeWrapViewController(viewController,
                                                           viewController.kh_navigationBarClass,
                                                           self.useSystemBackBarButtonItem,
                                                           currentLast.navigationItem.backBarButtonItem,
                                                           currentLast.navigationItem.title ?: currentLast.title)
                         animated:animated];
    }
    else {
        [super pushViewController:KHSafeWrapViewController(viewController, viewController.kh_navigationBarClass)
                         animated:animated];
    }
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    return KHSafeUnwrapViewController([super popViewControllerAnimated:animated]);
}

- (NSArray<__kindof UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated
{
    return [[super popToRootViewControllerAnimated:animated] kh_map:^id(__kindof UIViewController *obj, NSUInteger index) {
        return KHSafeUnwrapViewController(obj);
    }];
}

- (NSArray<__kindof UIViewController *> *)popToViewController:(UIViewController *)viewController
                                                     animated:(BOOL)animated
{
    __block UIViewController *controllerToPop = nil;
    [[super viewControllers] enumerateObjectsUsingBlock:^(__kindof UIViewController * obj, NSUInteger idx, BOOL * stop) {
        if (KHSafeUnwrapViewController(obj) == viewController) {
            controllerToPop = obj;
            *stop = YES;
        }
    }];
    if (controllerToPop) {
        return [[super popToViewController:controllerToPop
                                  animated:animated] kh_map:^id(__kindof UIViewController * obj, __unused NSUInteger index) {
            return KHSafeUnwrapViewController(obj);
        }];
    }
    return nil;
}

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers
                  animated:(BOOL)animated
{
    [super setViewControllers:[viewControllers kh_map:^id(__kindof UIViewController * obj,  NSUInteger index) {
        if (self.useSystemBackBarButtonItem && index > 0) {
            return KHSafeWrapViewController(obj,
                                            obj.kh_navigationBarClass,
                                            self.useSystemBackBarButtonItem,
                                            viewControllers[index - 1].navigationItem.backBarButtonItem,
                                            viewControllers[index - 1].title);
        }
        else
        return KHSafeWrapViewController(obj, obj.kh_navigationBarClass);
    }]
                     animated:animated];
}

- (void)setDelegate:(id<UINavigationControllerDelegate>)delegate
{
    self.kh_delegate = delegate;
}

- (BOOL)shouldAutorotate
{
    return self.topViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return self.topViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return self.topViewController.preferredInterfaceOrientationForPresentation;
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    if ([super respondsToSelector:aSelector]) {
        return YES;
    }
    return [self.kh_delegate respondsToSelector:aSelector];
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    return self.kh_delegate;
}

#pragma mark - Public Methods

- (UIViewController *)kh_topViewController
{
    return KHSafeUnwrapViewController([super topViewController]);
}

- (UIViewController *)kh_visibleViewController
{
    return KHSafeUnwrapViewController([super visibleViewController]);
}

- (NSArray <__kindof UIViewController *> *)kh_viewControllers
{
    return [[super viewControllers] kh_map:^id(id obj, __unused NSUInteger index) {
        return KHSafeUnwrapViewController(obj);
    }];
}

- (void)removeViewController:(UIViewController *)controller
{
    [self removeViewController:controller animated:NO];
}

- (void)removeViewController:(UIViewController *)controller animated:(BOOL)flag
{
    NSMutableArray<__kindof UIViewController *> *controllers = [self.viewControllers mutableCopy];
    __block UIViewController *controllerToRemove = nil;
    [controllers enumerateObjectsUsingBlock:^(__kindof UIViewController * obj, NSUInteger idx, BOOL * stop) {
        if (KHSafeUnwrapViewController(obj) == controller) {
            controllerToRemove = obj;
            *stop = YES;
        }
    }];
    if (controllerToRemove) {
        [controllers removeObject:controllerToRemove];
        [super setViewControllers:[NSArray arrayWithArray:controllers] animated:flag];
    }
}

- (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated
                  complete:(void (^)(BOOL))block
{
    if (self.animationBlock) {
        self.animationBlock(NO);
    }
    self.animationBlock = block;
    [self pushViewController:viewController
                    animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated complete:(void (^)(BOOL))block
{
    if (self.animationBlock) {
        self.animationBlock(NO);
    }
    self.animationBlock = block;
    
    UIViewController *vc = [self popViewControllerAnimated:animated];
    if (!vc) {
        if (self.animationBlock) {
            self.animationBlock(YES);
            self.animationBlock = nil;
        }
    }
    return vc;
}

- (NSArray <__kindof UIViewController *> *)popToViewController:(UIViewController *)viewController
                                                      animated:(BOOL)animated
                                                      complete:(void (^)(BOOL))block
{
    if (self.animationBlock) {
        self.animationBlock(NO);
    }
    self.animationBlock = block;
    NSArray <__kindof UIViewController *> *array = [self popToViewController:viewController
                                                                    animated:animated];
    if (!array.count) {
        if (self.animationBlock) {
            self.animationBlock(YES);
            self.animationBlock = nil;
        }
    }
    return array;
}

- (NSArray <__kindof UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated
                                                                  complete:(void (^)(BOOL))block
{
    if (self.animationBlock) {
        self.animationBlock(NO);
    }
    self.animationBlock = block;
    
    NSArray <__kindof UIViewController *> *array = [self popToRootViewControllerAnimated:animated];
    if (!array.count) {
        if (self.animationBlock) {
            self.animationBlock(YES);
            self.animationBlock = nil;
        }
    }
    return array;
}

#pragma mark - UINavigationController Delegate

- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    BOOL isRootVC = viewController == navigationController.viewControllers.firstObject;
    viewController = KHSafeUnwrapViewController(viewController);
    if (!isRootVC && viewController.isViewLoaded) {
        
        BOOL hasSetLeftItem = viewController.navigationItem.leftBarButtonItem != nil;
        if (hasSetLeftItem && !viewController.kh_hasSetInteractivePop) {
            viewController.kh_disableInteractivePop = YES;
        }
        else if (!viewController.kh_hasSetInteractivePop) {
            viewController.kh_disableInteractivePop = NO;
        }
        [self _installsLeftBarButtonItemIfNeededForViewController:viewController];
    }
    
    if ([self.kh_delegate respondsToSelector:@selector(navigationController:willShowViewController:animated:)]) {
        [self.kh_delegate navigationController:navigationController
                        willShowViewController:viewController
                                      animated:animated];
    }
}

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    BOOL isRootVC = viewController == navigationController.viewControllers.firstObject;
    viewController = KHSafeUnwrapViewController(viewController);
    if (viewController.kh_disableInteractivePop) {
        self.interactivePopGestureRecognizer.delegate = nil;
        self.interactivePopGestureRecognizer.enabled = NO;
    } else {
        self.interactivePopGestureRecognizer.delaysTouchesBegan = YES;
        self.interactivePopGestureRecognizer.delegate = self;
        self.interactivePopGestureRecognizer.enabled = !isRootVC;
    }
    
    [KHNavigationController attemptRotationToDeviceOrientation];
    
    
    if ([self.kh_delegate respondsToSelector:@selector(navigationController:didShowViewController:animated:)]) {
        [self.kh_delegate navigationController:navigationController
                         didShowViewController:viewController
                                      animated:animated];
    }
    
    if (self.animationBlock) {
        if (animated) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.animationBlock(YES);
                self.animationBlock = nil;
            });
        }
        else {
            self.animationBlock(YES);
            self.animationBlock = nil;
        }
    }
}

- (UIInterfaceOrientationMask)navigationControllerSupportedInterfaceOrientations:(UINavigationController *)navigationController
{
    
    if ([self.kh_delegate respondsToSelector:@selector(navigationControllerSupportedInterfaceOrientations:)]) {
        return [self.kh_delegate navigationControllerSupportedInterfaceOrientations:navigationController];
    }
    return UIInterfaceOrientationMaskAll;
}

- (UIInterfaceOrientation)navigationControllerPreferredInterfaceOrientationForPresentation:(UINavigationController *)navigationController
{
    
    if ([self.kh_delegate respondsToSelector:@selector(navigationControllerPreferredInterfaceOrientationForPresentation:)]) {
        return [self.kh_delegate navigationControllerPreferredInterfaceOrientationForPresentation:navigationController];
    }
    return UIInterfaceOrientationPortrait;
}

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    if ([self.kh_delegate respondsToSelector:@selector(navigationController:interactionControllerForAnimationController:)]) {
        return [self.kh_delegate navigationController:navigationController
          interactionControllerForAnimationController:animationController];
    }
    return nil;
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    if ([self.kh_delegate respondsToSelector:@selector(navigationController:animationControllerForOperation:fromViewController:toViewController:)]) {
        return [self.kh_delegate navigationController:navigationController
                      animationControllerForOperation:operation
                                   fromViewController:KHSafeUnwrapViewController(fromVC)
                                     toViewController:KHSafeUnwrapViewController(toVC)];
    }
    return nil;
}



#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return (gestureRecognizer == self.interactivePopGestureRecognizer);
}

@end
