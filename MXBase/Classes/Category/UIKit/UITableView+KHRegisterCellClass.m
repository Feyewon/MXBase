//
//  UITableView+KHRegisterCellClass.m
//  KHUserModule_Example
//
//  Created by fei on 2019/5/8.
//  Copyright © 2019 Feyewon. All rights reserved.
//

#import "UITableView+KHRegisterCellClass.h"

@implementation UITableView (KHRegisterCellClass)

- (void)registerCellClasses:(NSArray<Class> *)classes {
    for (Class classType in classes) {
        [self registerClass:classType forCellReuseIdentifier:NSStringFromClass(classType)];
    }
}

- (UITableViewCell *)dequeueReusableCellWithClassType:(Class)classType {
    return [self dequeueReusableCellWithIdentifier:NSStringFromClass(classType)];
}

@end
