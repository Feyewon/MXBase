//
//  MXViewController.m
//  MXBase
//
//  Created by Feyewon on 03/29/2019.
//  Copyright (c) 2019 Feyewon. All rights reserved.
//

#import "MXViewController.h"
#import <Masonry.h>
#import <UIScrollView+MCRefreshWithTask.h>
#import <DCAlertController.h>
#import "UIView+SWRefresh.h"
#import "UIViewController+Addition.h"
@interface MXViewController () <UIScrollViewDelegate>

@end

@implementation MXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    __weak __typeof(self)weakSelf = self;
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    scrollView.delegate = self;
    [self.view sw_refreshWithObject:scrollView atPoint:CGPointMake(20, -25) downRefresh:^{
        
    }];
    [self.view beginRefresh];
    [self showErrorPageWithFreshBlock:nil];
    [self showHud];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

}
@end
