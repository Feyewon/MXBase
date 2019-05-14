//
//  UITableView+KHRegisterCellClass.h
//  KHUserModule_Example
//
//  Created by fei on 2019/5/8.
//  Copyright © 2019 Feyewon. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (KHRegisterCellClass)

- (void)registerCellClasses:(NSArray<Class> *)classes;

- (UITableViewCell *)dequeueReusableCellWithClassType:(Class)classType;

@end

NS_ASSUME_NONNULL_END
